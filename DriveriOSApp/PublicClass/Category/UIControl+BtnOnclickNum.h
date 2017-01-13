//
//  UIControl+BtnOnclickNum.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/9.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (BtnOnclickNum)

@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;

@end
