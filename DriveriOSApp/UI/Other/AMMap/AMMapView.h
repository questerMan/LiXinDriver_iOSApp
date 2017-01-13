//
//  AMMapView.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMMapView : UIView

@property (nonatomic, assign) CLLocationCoordinate2D currentLocationCoordinate2D;

@property (nonatomic, assign) MAUserLocation *userLocation;
/**
 *                             绘制驾车路径
 * @param startCoordinate      起点经纬度
 * @param destinationCoordinat 终点经纬度
 * @param strategy             行驶道路规划
 */
-(void)showRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
           andDestinationCoordinate:(CLLocationCoordinate2D)destinationCoordinat
                        andStrategy:(NSInteger)strategy;
/**
 *     移除地图上的行驶绘制路线
 */

-(void)clearRoute;


@end
