//
//  AMPublicTools.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AMPublicTools.h"


@interface AMPublicTools()<AMapLocationManagerDelegate,AMapSearchDelegate>

//定位
@property (nonatomic, strong) AMapLocationManager *locationManager;
//搜索
@property (nonatomic, strong) AMapSearchAPI *search;
//热力图
@property (nonatomic, strong) MAHeatMapTileOverlay *heatMapTileOverlay;
//大头针
@property (retain, nonatomic) MAPointAnnotation *pointAnnotation;

@end

@implementation AMPublicTools

-(AMapLocationManager *)locationManager{//定位
    
    if (!_locationManager) {
        
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        
    }
    
    return _locationManager;
}

-(MAPointAnnotation *)pointAnnotation{
    if (!_pointAnnotation) {
        _pointAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}


/** 单例 */
+ (AMPublicTools *)shareInstance{
    
    static dispatch_once_t onceToken;
    static AMPublicTools * shareTools = nil;
    dispatch_once(&onceToken, ^{
        shareTools = [[AMPublicTools alloc]init];
        
    });
    return shareTools;
}

#pragma mark － 定位
-(void)locationWithLocationBlock:(LocationBlock)locationBlock{
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //开始连续定位
    [self.locationManager startUpdatingLocation];
    
    _locationBlock = locationBlock;
}
#pragma mark － AMapLocationManagerDelegate

//连续定位回调函数
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (_locationBlock != nil) {
        _locationBlock(manager,location,reGeocode);
    }
    
    //停止定位
    [self.locationManager stopUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"错误 %@",error);
    //停止定位
    [self.locationManager stopUpdatingLocation];
}
#pragma mark - 搜索
-(void)onReGeocodeSearchDoneWithRequest:(id)request
                               andBlock:(OnReGeocodeSearchBlock)onReGeocodeSearchBlock{
    if(_search == nil) {
        self.search = [[AMapSearchAPI alloc] init];
    }
    
    self.search.delegate = self;
    
    //发起逆地理编码
    if ([request isKindOfClass:[AMapPOIKeywordsSearchRequest class]])
    {
        [self.search AMapPOIKeywordsSearch:request];
    }
    else if ([request isKindOfClass:[AMapDrivingRouteSearchRequest class]])
    {
        [self.search AMapDrivingRouteSearch:request];
    }
    else if ([request isKindOfClass:[AMapInputTipsSearchRequest class]])
    {
        [self.search AMapInputTipsSearch:request];
    }
    else if ([request isKindOfClass:[AMapGeocodeSearchRequest class]])
    {
        [self.search AMapGeocodeSearch:request];
    }
    else if ([request isKindOfClass:[AMapReGeocodeSearchRequest class]])
    {
        [self.search AMapReGoecodeSearch:request];
    }
    else
    {
        NSLog(@"unsupported request");
        return;
    }
    
    _onReGeocodeSearchBlock = onReGeocodeSearchBlock;
}

#pragma mark - 搜索Helpers

- (void)performBlockWithRequest:(id)request withResponse:(id)response
{
    if (_onReGeocodeSearchBlock != nil) {
        _onReGeocodeSearchBlock(request,response,nil);
    }
}

#pragma mark - AMapSearchDelegate
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    if (_onReGeocodeSearchBlock != nil) {
        _onReGeocodeSearchBlock(request,nil,error);
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}


//************************************************************************//

#pragma mark - 创建热力图
-(void)creatHotMapWittMapView:(MAMapView *)mapView{
    
    self.heatMapTileOverlay = [[MAHeatMapTileOverlay alloc] init];
    
    //构造热力图数据，从locations.json中读取经纬度
    NSMutableArray* dataArray = [NSMutableArray array];
    
    
#define latitudinalRangeMeter 1000.0
#define longitudinalRangeMeter 1000.0
    
    MAMapRect rect = MAMapRectForCoordinateRegion(MACoordinateRegionMakeWithDistance(mapView.centerCoordinate, latitudinalRangeMeter, longitudinalRangeMeter));
    
    //在mapRect区域里随机生成coordinate
#define MAX_COUNT 120   //车辆
#define MIN_COUNT 5
    NSUInteger randCount = arc4random() % MAX_COUNT + MIN_COUNT;
    
    
    for (int i = 0; i < randCount; i++)
    {
        LXObj * obj = [LXObj driverWithID:@"粤 A168" coordinate:[self randomPointInMapRect:rect]];
        
        MAHeatMapNode *node = [[MAHeatMapNode alloc] init];
        
        node.coordinate = obj.coordinate;
        
        node.intensity = 1;//设置权重
        [dataArray addObject:node];
    }
    
    
    //构造渐变色对象
    MAHeatMapGradient *gradient = [[MAHeatMapGradient alloc] initWithColor:@[[UIColor blueColor],[UIColor greenColor], [UIColor redColor]] andWithStartPoints:@[@(0.2),@(0.5),@(0.9)]];
    self.heatMapTileOverlay.gradient = gradient;
    
    self.heatMapTileOverlay.data = dataArray;
    self.heatMapTileOverlay.radius = 20.0;
    //将热力图添加到地图上
    [mapView addOverlay: self.heatMapTileOverlay];
    
}
#pragma mark - Utility
- (CLLocationCoordinate2D)randomPointInMapRect:(MAMapRect)mapRect
{
    MAMapPoint result;
    result.x = mapRect.origin.x + arc4random() % (int)(mapRect.size.width);
    result.y = mapRect.origin.y + arc4random() % (int)(mapRect.size.height);
    
    return MACoordinateForMapPoint(result);

}

//************************************************************************//

#pragma mark - 添加大头针
+(void)addPointAnnocationWithMap:(MAMapView *)mapView
                      Coordinate:(CLLocationCoordinate2D)coordinate{
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    
    pointAnnotation.coordinate = coordinate;
    
    pointAnnotation.title = @"pointAnnotation";
    
    [mapView addAnnotation:pointAnnotation];
    //自动显示气泡信息
    [mapView selectAnnotation:pointAnnotation animated:YES];
    
}
@end
