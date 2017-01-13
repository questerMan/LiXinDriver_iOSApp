//
//  IndentData.h
//  DriveriOSApp
//
//  Created by lixin on 17/1/12.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndentData : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *headIMG;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, assign) CLLocationCoordinate2D startLocation;

@property (nonatomic, assign) CLLocationCoordinate2D endLocation;

@property (nonatomic, copy) NSString *startName;

@property (nonatomic, copy) NSString *endName;

@property (nonatomic, copy) NSString *times;

@end
