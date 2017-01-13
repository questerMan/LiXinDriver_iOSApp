//
//  LXLocatiion.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXLocatiion : NSObject
/**
 *  封装位置信息。
 */

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *address;

@end
