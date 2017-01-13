//
//  DriverAnnotationView.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/21.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"


typedef void (^ DriverAnnotationViewBlock) (UILabel *label);

@interface DriverAnnotationView : MAAnnotationView

@property (nonatomic, strong) CustomCalloutView *calloutView;

@property (nonatomic, copy) DriverAnnotationViewBlock block;

-(void)getDataWithBlock:(DriverAnnotationViewBlock)block;

@end
