//
//  DriverManage.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LXObjManage.h"
#import "LXRoute.h"

@interface LXObjManage() <AMapSearchDelegate>

@property(nonatomic, strong) LXRequest * currentRequest;
@property(nonatomic, strong) LXObj * selectDriver;

@property(nonatomic, strong) NSArray * driverPath;
@property(nonatomic, assign) NSUInteger subpathIdx;

@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation LXObjManage

//根据mapRect取司机数据
- (void)searchDriversWithinMapRect:(MAMapRect)mapRect
{
    //在mapRect区域里随机生成coordinate
#define COUNT 8   //车辆
    NSUInteger randCount = COUNT;
    
    NSMutableArray * drivers = [NSMutableArray arrayWithCapacity:randCount];
    for (int i = 0; i < randCount; i++)
    {
        LXObj * obj = [LXObj driverWithID:[NSString stringWithFormat:@"粤 A168**%d",i] coordinate:[self randomPointInMapRect:mapRect]];
        
        [drivers addObject:obj];
    }
    
    //回调返回司机数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchDoneInMapRect:withDriversResult:timestamp:)])
    {
        [self.delegate searchDoneInMapRect:mapRect withDriversResult:drivers timestamp:[NSDate date].timeIntervalSinceReferenceDate];
    }
    
}

//发送用车请求：起点终点
- (BOOL)callTaxiWithRequest:(LXRequest *)request
{
    if (request.start == nil || request.end == nil)
    {
        return NO;
    }
    
    _currentRequest = request;
    
    CLLocationCoordinate2D driverLocation = request.start.coordinate;
    _selectDriver = [LXObj driverWithID:@"粤 A186168" coordinate:driverLocation];
    
    //延迟返回司机选择结果
    __weak __typeof(&*self) weakSelf = self;
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(callTaxiDoneWithRequest:Taxi:)])
        {
            [weakSelf.delegate callTaxiDoneWithRequest:_currentRequest Taxi:_selectDriver];
        }
        //司机位置更新
        [weakSelf startUpdateLocationForDriver:_selectDriver];
        
    });
    
    return YES;
}

- (void)startUpdateLocationForDriver:(LXObj *)obj
{
    [self searchPathFrom:obj.coordinate to:_currentRequest.end.coordinate];
}

//找驾车到达乘客位置的路径
- (void)searchPathFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    navi.requireExtension = YES;
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:from.latitude longitude:from.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:to.latitude longitude:to.longitude];
    
    [self.search AMapDrivingRouteSearch:navi];

    
}
/**
 *  当请求发生错误时，会调用代理的此方法.
 *
 *  @param request 发生错误的请求.
 *  @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"----%@",error);
}

/**
 *  路径规划查询回调
 *
 *  @param request  发起的请求，具体字段参考 AMapRouteSearchBaseRequest 及其子类。
 *  @param response 响应结果，具体字段参考 AMapRouteSearchResponse 。
 */
-(void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    
    AMapRouteSearchResponse *naviResponse = (AMapRouteSearchResponse *)response;
    
    NSLog(@"%@", naviResponse);
    if (naviResponse.route == nil)
    {
        return;
    }
    
    //路径解析
    LXRoute * naviRoute = [LXRoute naviRouteForPath:naviResponse.route.paths[0]];
    
    //保存路径串
    self.driverPath = naviRoute.path;
    self.subpathIdx = 0;
    
    //开始push给乘客端
    if (self.delegate && [self.delegate respondsToSelector:@selector(onUpdatingLocations:forDriver:)] && _subpathIdx < self.driverPath.count)
    {
        [self.delegate onUpdatingLocations:self.driverPath[_subpathIdx++] forDriver:self.selectDriver];
    }
}



#pragma mark - Utility
- (CLLocationCoordinate2D)randomPointInMapRect:(MAMapRect)mapRect
{
    MAMapPoint result;
    result.x = mapRect.origin.x + arc4random() % (int)(mapRect.size.width);
    result.y = mapRect.origin.y + arc4random() % (int)(mapRect.size.height);
    
    return MACoordinateForMapPoint(result);
    
}



@end
