//
//  NativeBaseDataManage.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/2.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMLocationModel.h"

@interface NativeData : NSObject

@property (nonatomic,retain) FMDatabase *dataBase;

// 创建单例
+(NativeData *)shareInstance;

#pragma mark - 定位信息



@end
