//
//  CacheClass.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "CacheClass.h"

static CacheClass *cacheInfo = nil;

@implementation CacheClass

+ (CacheClass *)cacheShareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheInfo = [[CacheClass alloc]init];
        
    });
    return cacheInfo;
}

#pragma mark ===== YYCache =====
#pragma mark - 基础存数据
/* 存数据
 *  yyCache路径-->/Users/lixingongsi/Library/Developer/CoreSimulator/Devices/CD899DA6-3C20-4623-8BD0-0BB28EBB29F9/data/Containers/Data/Application/D4BF23C6-1789-4EFF-9F53-E31E27EDC883/Library/Caches/CACHEDATA
 */
+(void) cacheFromYYCacheWithValue:(id<NSCoding>) value AndKey:(NSString*) key
{
    if (!value) return;
    
    YYCache * yyCache = [[YYCache alloc]initWithName:CACHE_DATA];
    
//    NSLog(@"yyCache路径-->%@",yyCache.diskCache.path);
    
    [yyCache setObject:value forKey:key];
}

#pragma mark - 基础取数据
+(id) getAllDataFromYYCacheWithKey:(NSString*) key
{
    if (key.length == 0) return nil;
    
    YYCache * yyCache = [[YYCache alloc]initWithName:CACHE_DATA];
    
    return [yyCache objectForKey:key];
}

#pragma mark ===== NSUserDefault =====
#pragma mark - - 本地缓存基类
+ (void)setCacheWithKey:(NSString *)cacheKey cacheValue:(id)cache
{
    
    if (cache != nil) {  //判断缓存数据是否为空
        
        //        [UserDefault removeObjectForKey:cacheKey];
        
        [UserDefault setObject:cache forKey:cacheKey];
        [UserDefault synchronize];
    }
    
}

#pragma mark - - 返回本地数据基类
+ (id)getCacheWithCacheKey:(NSString *)cacheKey
{
    return [UserDefault objectForKey:cacheKey];
}

#pragma mark - 保存用户搜索历史记录
+(void) saveUserSearchHistoryWithArray:(NSArray*) array
{
    [CacheClass setCacheWithKey:HISTORYLIST cacheValue:array];
}

#pragma mark - 取本地,用户搜索历史记录
+(NSArray*)getUserSearchHistory{
    
    return [CacheClass getCacheWithCacheKey:HISTORYLIST];
}




@end
