//
//  LXRoute.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXRoute : NSObject

@property (nonatomic, copy) NSArray * path;

+ (instancetype)naviRouteForPath:(AMapPath *)path;

- (id)initWithPath:(AMapPath *)path;

@end
