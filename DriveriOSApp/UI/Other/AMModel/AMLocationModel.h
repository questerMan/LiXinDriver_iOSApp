//
//  AMLocation.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/1.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMLocationModel : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 位置 */
@property (nonatomic, copy) NSString *address;
/** 经度 */
@property (nonatomic, copy) NSString *latitude;
/** 纬度 */
@property (nonatomic, copy) NSString *longitude;



@end
