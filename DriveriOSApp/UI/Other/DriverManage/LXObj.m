//
//  LXObj.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LXObj.h"

@implementation LXObj
+ (instancetype)driverWithID:(NSString *)idInfo coordinate:(CLLocationCoordinate2D)coordinate
{
    return [[self alloc] initWithID:idInfo coordinate:coordinate];
}

- (id)initWithID:(NSString *)idInfo coordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.idInfo = idInfo;
        self.coordinate = coordinate;
    }
    return self;
}
@end
