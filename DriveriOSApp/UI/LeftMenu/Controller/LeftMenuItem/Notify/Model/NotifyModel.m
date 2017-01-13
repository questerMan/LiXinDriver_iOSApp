//
//  NotifyModel.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/12.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "NotifyModel.h"

@implementation NotifyModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//重写
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"content"]) {
        //计算高度
       CGFloat height = [PublicTool heightOfStr:(NSString *)value andTextWidth:(SCREEN_W - MATCHSIZE(60)) andFont:[UIFont systemFontOfSize:MATCHSIZE(30)]];
        self.height = height;
        self.content = value;
        
    }else{
        if ([value isKindOfClass:[NSNull class]]) {
            // NSNull处理
            [self setValue:@"" forKey:key];
        }
        else {
            [super setValue:value forKey:key];
        }
    }
}

@end
