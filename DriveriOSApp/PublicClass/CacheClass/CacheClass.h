//
//  CacheClass.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheClass : NSObject

/**
 *  用户单例类
 *
 *  @return 返回一个用户对象
 */
+ (CacheClass *)cacheShareInstance;



/**
 *  YYCache基础缓存方法（存入）
 *
 *  @param value  值
 *  @param key    键
 *
 */
+(void) cacheFromYYCacheWithValue:(id<NSCoding>) value AndKey:(NSString*) key;

/**
 *  YYCache基础缓存方法（取出）
 *
 *  @param key  键
 *
 *  @return 返回任意类型数据
 */

+(id) getAllDataFromYYCacheWithKey:(NSString*) key;

/**
 *  保存用户搜索结果，array传入需要保存的数组
 *  array 传入需要保存的数组
 *
 */
+(void) saveUserSearchHistoryWithArray:(NSArray*) array;

/**
 *  返回用户搜索结果数据(NSArray*)
 *  @return 数组
 */
+(NSArray*)getUserSearchHistory;


@end
