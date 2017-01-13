//
//  IndentData.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/12.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "IndentData.h"

@implementation IndentData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _name = @"吴先生";
        _headIMG = [UIImage imageNamed:@"userIMG"];
        _number = @"13303672389";
        
        _startName = @"香港希尔顿酒店";
        _endName = @"国际公馆俱乐部";
        
        CLLocationCoordinate2D start;
        start.latitude = 22.3400;
        start.longitude = 114.8900;
        _startLocation = start;
        
        CLLocationCoordinate2D end;
        end.latitude = 22.3480;
        end.longitude = 114.8920;
        _endLocation = end;
        
        _times = @"01月12日";
    }
    return self;
}

@end
