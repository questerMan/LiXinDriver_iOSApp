//
//  NotifyModel.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/12.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotifyModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 日期 */
@property (nonatomic, copy) NSString *data;

@property (nonatomic, assign) CGFloat height;
@end
