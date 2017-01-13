//
//  NSObject+EasyModel.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "NSObject+EasyModel.h"

@implementation NSObject (EasyModel)


+ (id)easy_modelWithDictionary:(NSDictionary *)modelInfo {
    // 1. 取出该类所有的实例变量列表
    NSArray *ivarList = [self ivarList];
    // 2. 创建对象
    id model = [[self alloc] init];
    // 3. 根据传入的字典数据设置 model 的属性值
    [model setValuesWithModelInfo:modelInfo andNameList:ivarList];
    // 4. 返回
    return model;
}

// 封装一个方法，将该类中，所有的实例变量取出
+ (NSArray *)ivarList {
    // 1. 先取出该类的 Ivar 数组。
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList(self, &ivarCount);
    
    // 2. 遍历取出实例变量的名字
    NSMutableArray *nameList = [NSMutableArray array];
    for (int i = 0; i < ivarCount; ++i) {
        // 取出数组中第 i 个实例变量
        Ivar ivar = ivarList[i];
        // 取出实例变量的名字
        const char *ivarname = ivar_getName(ivar);
        // 转换为 OC 的字符串，方便存到数组中
        NSString *name = [[NSString stringWithUTF8String:ivarname] substringFromIndex:1];
        // 存入数组
        [nameList addObject:name];
        
    }
    // 释放刚才创建的 Ivar 数组
    free(ivarList);
    // 返回数组
    return nameList;
}

// 再封装一个对象方法，传入字典和实例变量列表，设置相应的属性
- (void)setValuesWithModelInfo:(NSDictionary *)modelInfo andNameList:(NSArray *)nameList {
    // 遍历 nameList
    // 快速枚举
    // 这个方法，是所有的容器类都有的方法，快速遍历容器里面的内容
    // 字典里面的内容也可以遍历
    [modelInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 将值赋给当前对象
        // 在这里可以进行一些特殊情况处理，比如将 OC 的 id 转换为可用的 ID
        if ([key isEqualToString:@"id"]) {
            key = @"ID";
        }
        
        // 判断 key 是否是当前对象的一个实例变量
        if ([nameList containsObject:key]) {
            // 如果有，就将对应的值设置为这个实例变量的值
            [self setValue:obj forKey:key];
        }
    }];
    
}

- (id)easy_modelInfo {
    // 1. 取出所有的实例变量名
    NSArray *ivarList = [[self class] ivarList];
    
    // 2. 创建一个可变字典，用于存储所有的键值对
    NSMutableDictionary *modelInfo = [NSMutableDictionary dictionary];
    
    // 3. 遍历实例变量数组，并将所有的对应值取出
    [ivarList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // kvc 取出键对应的值
        id value = [self valueForKey:obj];
        
        // 如果值为空，将其置为空字符串
        if (!value) {
            value = @"";
        }
        
        // 加入到字典里面
        [modelInfo setObject:value forKey:obj];
    }];
    
    // 4. 返回字典
    return modelInfo;
}

@end
