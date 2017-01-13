//
//  UserPointAnnotation.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/4.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "UserPointAnnotation.h"
#import "UserCalloutView.h"


@implementation UserPointAnnotation

-(void)setTitle:(NSString *)title{
    UserCalloutView *userCallout = [[UserCalloutView alloc] init];
    userCallout.titleLable.text = title;
    _title = title;
}

@end
