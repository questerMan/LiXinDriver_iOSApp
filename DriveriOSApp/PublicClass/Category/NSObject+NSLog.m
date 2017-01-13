//
//  NSObject+NSLog.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/6.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "NSObject+NSLog.h"


@implementation NSObject (NSLog)

-(void)NSLogInfoWithObj:(NSObject *)obj{
    if (App_Sate == 0) {
        switch (App_NSLog) {
            case 1://打印

                break;
            case 2://弹出框
                
                break;
            case 3://存储
                
                break;
                
            default:
                break;
        }
    }
}

@end
