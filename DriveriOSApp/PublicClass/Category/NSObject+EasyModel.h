//
//  NSObject+EasyModel.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EasyModel)
// 直接返回一个模型
+ (id)easy_modelWithDictionary:(NSDictionary *)modelInfo;

// 将一个模型转为字典
- (id)easy_modelInfo;
@end
