//
//  LXRoute.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LXRoute.h"
#import "LXCommonUtility.h"

@implementation LXRoute
#pragma mark - Format Search Result

/* polyline parsed from search result. */

+ (NSArray *)pathForStep:(AMapStep *)step
{
    if (step == nil)
    {
        return nil;
    }
    
    return [LXCommonUtility pathForCoordinateString:step.polyline];
}

#pragma mark - Life Cycle

+ (instancetype)naviRouteForPath:(AMapPath *)path
{
    return [[self alloc] initWithPath:path];
}

- (id)initWithPath:(AMapPath *)path
{
    self = [self init];
    
    if (self == nil)
    {
        return nil;
    }
    
    if (path == nil || path.steps.count == 0)
    {
        return self;
    }
    
    NSMutableArray *temp_path = [NSMutableArray array];
    
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        NSArray *stepPath = [LXRoute pathForStep:step];
        
        if (stepPath != nil)
        {
            [temp_path addObject:stepPath];
        }
    }];
    
    self.path = temp_path;
    
    return self;
    
}
@end
