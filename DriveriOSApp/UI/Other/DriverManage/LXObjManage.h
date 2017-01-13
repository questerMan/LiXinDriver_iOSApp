//
//  DriverManage.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXRequest.h"
#import "LXObj.h"

@protocol LXObjManagerDelegate;

@interface LXObjManage : NSObject

@property (nonatomic, weak) id<LXObjManagerDelegate> delegate;

//根据mapRect取司机数据
- (void)searchDriversWithinMapRect:(MAMapRect)mapRect;

//发送请求：起点终点
- (BOOL)callTaxiWithRequest:(LXRequest *)request;

@end



@protocol LXObjManagerDelegate <NSObject>

@optional
//返回数据结果
- (void)searchDoneInMapRect:(MAMapRect)mapRect withDriversResult:(NSArray *)drivers timestamp:(NSTimeInterval)timestamp;

//选择结果
- (void)callTaxiDoneWithRequest:(LXRequest *)request Taxi:(LXObj *)obj;

//位置更新
- (void)onUpdatingLocations:(NSArray *)locations forDriver:(LXObj *)obj;


@end
