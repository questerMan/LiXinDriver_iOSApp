//
//  UserAnnotationView.h
//  DriveriOSApp
//
//  Created by lixin on 17/1/4.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "UserCalloutView.h"

@interface UserAnnotationView : MAAnnotationView


typedef void (^ UserAnnotationViewBlock) (UILabel *label);


@property (nonatomic, strong) UserCalloutView *calloutView;

@property (nonatomic, copy) UserAnnotationViewBlock block;

-(void)getDataWithBlock:(UserAnnotationViewBlock)block;

@end
