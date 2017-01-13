//
//  LXObj.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXObj : NSObject

@property (nonatomic, strong) NSString * idInfo;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

+ (instancetype)driverWithID:(NSString *)idInfo coordinate:(CLLocationCoordinate2D)coordinate;

- (id)initWithID:(NSString *)idInfo coordinate:(CLLocationCoordinate2D)coordinate;

@end
