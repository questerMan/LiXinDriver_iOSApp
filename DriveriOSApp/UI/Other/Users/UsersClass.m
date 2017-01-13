//
//  UsersClass.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "UsersClass.h"

static UsersClass *userInfo = nil;


@implementation UsersClass


#pragma mark - - 用户单例对象
+ (UsersClass *)userInfoShareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UsersClass alloc]init];
        
    });
    return userInfo;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([value isKindOfClass:[NSNull class]]) {
        // NSNull处理
        [self setValue:@"" forKey:key];
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
