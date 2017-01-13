//
//  AMMapView.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerEndTitle         = @"终点";

#define RoutePlanningPaddingEdge MATCHSIZE(80)

#import "AMMapView.h"
#import "DriverAnnotationView.h"//测试自定义
#import "DriverPointAnnotation.h"
#import "LXObj.h"
#import "LXRequest.h"
#import "LXLocatiion.h"

#import "UserPointAnnotation.h"
#import "UserAnnotationView.h"

@interface AMMapView()<MAMapViewDelegate,AMapSearchDelegate,LXObjManagerDelegate>
//地图
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMPublicTools *tool;
//大头针
@property (retain, nonatomic) MAPointAnnotation *pointAnnotation;
@property (nonatomic, strong) UserPointAnnotation *userPointAnnotation;


@property (nonatomic, strong) UIImageView *centerLocationIMG;

//搜索
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic,retain) NSArray *pathPolylines;

/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

/** 起点大头针 */
@property (retain, nonatomic) MAPointAnnotation *startAnnotation;

/** 终点大头针 */
@property (retain, nonatomic) MAPointAnnotation *endAnnotation;

@property (nonatomic, strong) LXObjManage *objManage;
//汽车
@property (nonatomic, copy) NSArray *carAnnoArray;
@property (retain, nonatomic) DriverPointAnnotation *carAnnotation;

@end

@implementation AMMapView



-(MAPointAnnotation *)startAnnotation{
    if (!_startAnnotation) {
        _startAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _startAnnotation;
}

-(MAPointAnnotation *)endAnnotation{
    if (!_endAnnotation) {
        _endAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _endAnnotation;
}


-(MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        _mapView.delegate = self;
       
        //是否显示用户的位置
        _mapView.showsUserLocation = YES;
        
        //设置指南针compass，默认是开启状态，大小是定值，显示在地图的右上角
        _mapView.showsCompass = NO;
        
        //设置比例尺scale，默认显示在地图的左上角
        _mapView.showsScale = NO;
        
        //地图的缩放
        [_mapView setZoomLevel:16.2 animated:YES];
        
        //设置地图logo，默认字样是“高德地图”，用logoCenter来设置logo的位置
        _mapView.logoCenter = CGPointMake(0, 0);
        
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        
        // 去除精度圈。
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        
        //不支持旋转
        _mapView.rotateEnabled = NO;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
            _mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
        }
        
        //获取实时路况（根据用户的设置）
        NSObject *objValue = [CacheClass getAllDataFromYYCacheWithKey:Traffic_KEY];
        if (objValue != nil) {
            NSInteger flag = [(NSString *)objValue integerValue];
            if(flag == 1){
                _mapView.showTraffic = YES;
            }else{
                _mapView.showTraffic = NO;
            }
        }
    }
    return _mapView;
}
-(UIImageView *)centerLocationIMG{
    if (!_centerLocationIMG) {
        UIImage *image = [UIImage imageNamed:@"map60"];
        _centerLocationIMG = [[UIImageView alloc] initWithImage:image];
        _centerLocationIMG.center = self.mapView.center;
        _centerLocationIMG.y -= MATCHSIZE(50);
    }
    return _centerLocationIMG;
}

- (MAPointAnnotation *)pointAnnotation {
    if (!_pointAnnotation) {
        _pointAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}

-(UserPointAnnotation *)userPointAnnotation{
    if (!_userPointAnnotation) {
        _userPointAnnotation = [[UserPointAnnotation alloc] init];
    }
    return _userPointAnnotation;
}

-(LXObjManage *)objManage{
    if (!_objManage) {
        _objManage = [[LXObjManage alloc] init];
        _objManage.delegate = self;
    }
    return _objManage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatMap];
        
        [self creatLocationBtn];
        
        [self creatCenterLocationIMG];
       
        [self location];


      
    }
    return self;
}

#pragma mark - drivers
- (void)updatingDrivers{
    
#define latitudinalRangeMeters 500.0
#define longitudinalRangeMeters 500.0

    MAMapRect rect = MAMapRectForCoordinateRegion(MACoordinateRegionMakeWithDistance(self.mapView.centerCoordinate, latitudinalRangeMeters, longitudinalRangeMeters));
    [self.objManage searchDriversWithinMapRect:rect];
}


#pragma mark - LXObjManagerDelegate
- (void)searchDoneInMapRect:(MAMapRect)mapRect withDriversResult:(NSArray *)drivers timestamp:(NSTimeInterval)timestamp
{

    [self.mapView removeAnnotations:_carAnnoArray];
    NSMutableArray * currDrivers = [NSMutableArray arrayWithCapacity:[drivers count]];
    [drivers enumerateObjectsUsingBlock:^(LXObj * obj, NSUInteger idx, BOOL *stop) {
        _carAnnotation = [[DriverPointAnnotation alloc] init];

        _carAnnotation.coordinate = obj.coordinate;
        self.carAnnotation.title = obj.idInfo;
        [currDrivers addObject:_carAnnotation];
        
    }];

    [_mapView addAnnotations:currDrivers];
    
    _carAnnoArray = currDrivers;
    
}

#pragma mark - 绘制驾车路径
-(void)showRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
           andDestinationCoordinate:(CLLocationCoordinate2D)destinationCoordinat
                        andStrategy:(NSInteger)strategy{
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    
    navi.requireExtension = YES;
    navi.strategy = strategy;//!< 驾车导航策略([default = 0]) 0-速度优先（时间）；1-费用优先（不走收费路段的最快道路）；2-距离优先；3-不走快速路；4-结合实时交通（躲避拥堵）；5-多策略（同时使用速度优先、费用优先、距离优先三个策略）；6-不走高速；7-不走高速且避免收费；8-躲避收费和拥堵；9-不走高速且躲避收费和拥堵
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:startCoordinate.latitude longitude:startCoordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:destinationCoordinat.latitude longitude:destinationCoordinat.longitude];
    
    [self.search AMapDrivingRouteSearch:navi];
    
    //显示终点和起点大头针
    [self addAnnotationWithStartCoordinate:startCoordinate andEndCoordinate:destinationCoordinat];

    
}
#pragma mark - 添加终点和起点大头针
-(void)addAnnotationWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
               andEndCoordinate:(CLLocationCoordinate2D)endCoordinat{
    self.startAnnotation.coordinate = startCoordinate;
    self.startAnnotation.title = (NSString *)RoutePlanningViewControllerStartTitle;
    [self.mapView addAnnotation:self.startAnnotation];
    //自动显示气泡信息
    [self.mapView selectAnnotation:self.startAnnotation animated:YES];
    
    self.endAnnotation.coordinate = endCoordinat;
    self.endAnnotation.title = (NSString *)RoutePlanningViewControllerEndTitle;
    [self.mapView addAnnotation:self.endAnnotation];
    //自动显示气泡信息
    [self.mapView selectAnnotation:self.endAnnotation animated:YES];
    
    //移除原有大头针
    [self.mapView removeAnnotation:self.userPointAnnotation];
    //隐藏真心位置图标
    self.centerLocationIMG.hidden = YES;
    //不显示当前位置
    self.mapView.showsUserLocation = NO;

}

- (MAMapRect)mapRectForOverlays:(NSArray *)overlays
{
    if (overlays.count == 0)
    {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }
    
    MAMapRect mapRect;
    
    MAMapRect *buffer = (MAMapRect*)malloc(overlays.count * sizeof(MAMapRect));
    
    [overlays enumerateObjectsUsingBlock:^(id<MAOverlay> obj, NSUInteger idx, BOOL *stop) {
        buffer[idx] = [obj boundingMapRect];
    }];
    
    mapRect = [self mapRectUnion:buffer count:overlays.count];
    
    free(buffer), buffer = NULL;
    
    return mapRect;
}
-(MAMapRect)mapRectUnion:(MAMapRect *)mapRects count:(NSUInteger)count
{
    if (mapRects == NULL || count == 0)
    {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }
    
    MAMapRect unionMapRect = mapRects[0];
    
    for (int i = 1; i < count; i++)
    {
        unionMapRect = [self unionMapRect1:unionMapRect mapRect2:mapRects[i]];
    }
    
    return unionMapRect;
}
-(MAMapRect)unionMapRect1:(MAMapRect)mapRect1 mapRect2:(MAMapRect)mapRect2
{
    CGRect rect1 = CGRectMake(mapRect1.origin.x, mapRect1.origin.y, mapRect1.size.width, mapRect1.size.height);
    CGRect rect2 = CGRectMake(mapRect2.origin.x, mapRect2.origin.y, mapRect2.size.width, mapRect2.size.height);
    
    CGRect unionRect = CGRectUnion(rect1, rect2);
    
    return MAMapRectMake(unionRect.origin.x, unionRect.origin.y, unionRect.size.width, unionRect.size.height);
}
#pragma mark - 移除地图上的行驶绘制路线
-(void)clearRoute{
    [self.mapView removeOverlays:_pathPolylines];
    //移除终点和起点大头针
    [self.mapView removeAnnotation:self.startAnnotation];
    [self.mapView removeAnnotation:self.endAnnotation];

    //展示原有大头针
    [self.mapView addAnnotation:self.userPointAnnotation];
    //显示真心位置图标
    self.centerLocationIMG.hidden = NO;
    //显示当前位置
    self.mapView.showsUserLocation = YES;
}

//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
        return;
    }
    
    AMapPath *path = response.route.paths[0]; //选择一条路径
    AMapStep *step = path.steps[0]; //这个路径上的导航路段数组
    NSLog(@"step.polyline %@",step.polyline);   //此路段坐标点字符串
    
    if (response.count > 0)
    {
        //移除地图原本的遮盖
        [_mapView removeOverlays:_pathPolylines];
        _pathPolylines = nil;
        // 只显⽰示第⼀条 规划的路径
        _pathPolylines = [self polylinesForPath:response.route.paths[0]];
        NSLog(@"%@",response.route.paths[0]);
        //添加新的遮盖，然后会触发代理方法进行绘制
        [self.mapView addOverlays:_pathPolylines];
        
        //展示路径
        [self.mapView setVisibleMapRect:[self mapRectForOverlays:self.pathPolylines] edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge) animated:YES];
        
    }
    
}
//路线解析
- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}

//解析经纬度
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}


//创建地图
-(void)creatMap{
    
    //显示地图
    [self addSubview:self.mapView];
    //接收通知
    PublicTool *tool = [PublicTool shareInstance];
    [tool getNotificationWithName:Traffic_KEY object:^(NSNotification *notify) {
        int flag = [(NSString *)notify.userInfo intValue];
        if(flag == 1){
            _mapView.showTraffic = YES;
        }else{
            _mapView.showTraffic = NO;
        }
    }];
    
}

-(void)creatCenterLocationIMG{
    [self.mapView addSubview:self.centerLocationIMG];
}

-(void)creatLocationBtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [self.mapView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mapView).offset(MATCHSIZE(-260));
        make.right.equalTo(self.mapView).offset(MATCHSIZE(-30));
        make.height.offset(MATCHSIZE(80));
        make.width.offset(MATCHSIZE(80));
    }];
    
    @weakify(self);
    
    self.tool = [AMPublicTools shareInstance];
    
    //点击事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        //开始连续定位
        [self location];
        
    }];
}
#pragma mark - 定位
-(void)location{
    __weak typeof(self) weakSelf = self;
    
    [self.tool locationWithLocationBlock:^(AMapLocationManager *manager, CLLocation *location, AMapLocationReGeocode *reGeocode) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        //定位获取到的数据
        NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
        
        CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        
        strongSelf.mapView.centerCoordinate = coordinate2D;

        //地图的缩放
        [strongSelf.mapView setZoomLevel:16.2 animated:YES];

    }];
    
}


/** -------------------------------------------------------- */
/** -------------------MAMapViewDelegate-------------------- */
/** -------------------------------------------------------- */

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{

    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [[UIColor purpleColor]colorWithAlphaComponent:0.9];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    
    
    //热力图
    if ([overlay isKindOfClass:[MATileOverlay class]])
    {
        MATileOverlayRenderer *render = [[MATileOverlayRenderer alloc] initWithTileOverlay:overlay];
        
        return render;
    }

    return nil;
}


/**
 * @brief 地图区域即将改变时会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}


/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    //逆地理编码
    [self searchReGeocodeWithCoordinate:CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude)];
    
}

/**
 *  地图将要发生移动时调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    
    if (mapView.annotations.count > 0) {
        [mapView removeAnnotation:self.userPointAnnotation];
    }
    
}


/**
 *  地图移动结束后调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    
    //测试显示附近司机
    [self updatingDrivers];
    
//    //热力图
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self.tool creatHotMapWittMapView:mapView];
//    });
    
}

/**
 * @brief 地图开始加载
 * @param mapView 地图View
 */
- (void)mapViewWillStartLoadingMap:(MAMapView *)mapView{
    
}

/**
 * @brief 地图加载成功
 * @param mapView 地图View
 */
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView{

   
}

/**
 * @brief 地图加载失败
 * @param mapView 地图View
 * @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
#pragma -mark添加大头针（自定义标注）
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{

    //司机（附近车辆）
    if ([annotation isKindOfClass:[DriverPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"DriverAnnotationReuseIndetifier";
        DriverAnnotationView *annotationView = (DriverAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[DriverAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];

        }
        
        [annotationView getDataWithBlock:^(UILabel *label) {
            label.text = [annotation title];
        }];
        
        annotationView.image = [UIImage imageNamed:@"driver_car"];

        return annotationView;
        
    }
    //当前用户位置
    if ([annotation isKindOfClass:[UserPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"UserAnnotationReuseIndetifier";
        UserAnnotationView *annotationView = (UserAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[UserAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            
        }
        
        [annotationView getDataWithBlock:^(UILabel *label) {
            label.text = [annotation title];
        }];
        
        annotationView.image = [UIImage imageNamed:@"map60"];
        
        [UIView animateWithDuration:0.3 animations:^{
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -MATCHSIZE(50));
        } completion:^(BOOL finished) {
            self.centerLocationIMG.y -= MATCHSIZE(50);
            annotationView.y -= MATCHSIZE(50);
            [UIView animateWithDuration:0.3 animations:^{
                //设置中心点偏移，使得标注底部中间点成为经纬度对应点
                annotationView.centerOffset = CGPointMake(0, -MATCHSIZE(50));
                self.centerLocationIMG.y += MATCHSIZE(50);
            }];
        }];

        return annotationView;
        
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {//真机调试这里有可能出错
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        /* 起点. */
        if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
        {
            annotationView.image = [UIImage imageNamed:@"start"];
        }
        /* 终点. */
        else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerEndTitle])
        {
            annotationView.image = [UIImage imageNamed:@"end"];
        }
        return annotationView;
    }
    
//    /* 自定义userLocation对应的annotationView. */
//    if ([annotation isKindOfClass:[MAUserLocation class]])
//    {
//        static NSString *userLocationStyleReuseIndetifier = @"userLocationReuseIndetifier";
//        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
//                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
//        }
//        annotationView.tag = 1002;
//        UIImage *image = [UIImage imageNamed:@"guides"];
//        annotationView.image = image;
//
//        annotationView.centerOffset = CGPointMake(0,0);
//        annotationView.canShowCallout = YES;
//        
//        
//        
//        return annotationView;
//    }
    return nil;
}



/**
 * @brief 当mapView新添加annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
}

/**
 * @brief 当选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param view 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
   
    
    
}

/**
 * @brief 当取消选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
  
}

/**
 * @brief 在地图View将要启动定位时，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView{
    
}
/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
}

/**
 * @brief 在地图View停止定位后，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
    
}


/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    

    // 让定位箭头随着方向旋转
    MAAnnotationView *annotationView = (MAAnnotationView *)[self viewWithTag:1002];
    
    if (!updatingLocation && annotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            annotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f);
        }];
    }
   
    
    
    
    self.userLocation = mapView.userLocation;
    
    self.currentLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    
    if (updatingLocation) {
        
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQueue, ^{
            //子线程异步执行任务，防止主线程卡顿
            CLLocationCoordinate2D coordinate2D = userLocation.coordinate;
            [self saveLocationWithCoordinate2D:coordinate2D];
        });
    }
    
}
#pragma mark - 保存数据到本地
-(void)saveLocationWithCoordinate2D:(CLLocationCoordinate2D)coordinate2D{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude];
    regeo.requireExtension            = YES;
    
    [self.tool onReGeocodeSearchDoneWithRequest:regeo andBlock:^(id request, id response, NSError *error) {
        AMapReGeocodeSearchResponse *responseNew = (AMapReGeocodeSearchResponse *)response;
        
        if (responseNew.regeocode != nil) {
            
            UsersClass *usersModel = [UsersClass userInfoShareInstance];
            //省/直辖市
            usersModel.province = responseNew.regeocode.addressComponent.province;
            //市
            usersModel.citycode = responseNew.regeocode.addressComponent.citycode;
            //区
            usersModel.district = responseNew.regeocode.addressComponent.district;
            //乡镇街道
            usersModel.town = responseNew.regeocode.addressComponent.township;
            //街道＋门牌号
            usersModel.address = [NSString stringWithFormat:@"%@%@",responseNew.regeocode.addressComponent.streetNumber.street,responseNew.regeocode.addressComponent.streetNumber.number];
            //经度
            usersModel.latitude = [NSString stringWithFormat:@"%f",coordinate2D.latitude];
            //纬度
            usersModel.longitude = [NSString stringWithFormat:@"%f",coordinate2D.longitude];
            //方向
            usersModel.direction = responseNew.regeocode.addressComponent.streetNumber.direction;
            //模型转字典
            NSDictionary *dict = [usersModel easy_modelInfo];
            //保存字典信息
            [CacheClass cacheFromYYCacheWithValue:dict AndKey:CACHE_DATA];
            //            NSLog(@"字典信息 %@",dict);
        }
        
    }];
}

#pragma mark - 逆地理编码
/**
 * coordinate 经纬度
 * isLocation 判断是定位使用该方法还是移动地图使用该方法 isLocation为YES定位使用该方法，保存当前位置
 */
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{

   
    

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 处理耗时操作的代码块...
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        regeo.requireExtension            = YES;
        
        __weak typeof(self) weakSelf = self;
        
        [self.tool onReGeocodeSearchDoneWithRequest:regeo andBlock:^(id request, id response, NSError *error) {
            
            AMapReGeocodeSearchResponse *responseNew = (AMapReGeocodeSearchResponse *)response;
            
            __strong __typeof(weakSelf)strongSelf = weakSelf;//防止多次weakSelf会把之前方法置空而崩溃
            
            if (responseNew.regeocode != nil) {
                //注意这里，如果数据为空会出错，可以做字符串判断
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新
                    //头标题
                    strongSelf.userPointAnnotation.title = [NSString stringWithFormat:@"%@%@",responseNew.regeocode.addressComponent.streetNumber.street,responseNew.regeocode.addressComponent.building];
                    
                    //副标题
                    strongSelf.userPointAnnotation.subtitle = [NSString stringWithFormat:@"%@%@%@",responseNew.regeocode.addressComponent.township,responseNew.regeocode.addressComponent.streetNumber.street,responseNew.regeocode.addressComponent.streetNumber.number];
                    
                    //大头针坐标
                    strongSelf.userPointAnnotation.coordinate = CLLocationCoordinate2DMake(self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude);
                    
                    [strongSelf.mapView addAnnotation:self.userPointAnnotation];
                  
                    //自动显示气泡信息
                    [strongSelf.mapView selectAnnotation:self.userPointAnnotation animated:YES];
                    
                });
            }
        }];
    });
}





@end




/**
 *origin：起点坐标，必设。
 *destination：终点坐标，必设。
 *waypoints：途经点，最多支持16个途经点。
 *avoidpolygons：避让区域，最多支持100个避让区域，每个区域16个点。
 *avoidroad：避让道路，设置避让道路后，避让区域失效。
 *strategy：驾车导航策略，0-速度优先（时间）；1-费用优先（不走收费路段的最快道路）；2-距离优先；3-不走快速路；4-结合实时交通（躲避拥堵）；5-多策略（同时使用速度优先、费用优先、距离优先三个策略）；6-不走高速；7-不走高速且避免收费；8-躲避收费和拥堵；9-不走高速且躲避收费和拥堵
 */
