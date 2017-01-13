//
//  TabClass.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TabClassBlock) (NSString *type);

@interface TabClass : UIView

@property (nonatomic, copy) TabClassBlock Block;

/** tab点击事件 */
-(void)didSelectTabWithBlock:(TabClassBlock)block;

/** 获取tab数据 */
-(void)getTabTitleDataWithArray:(NSMutableArray *)arrayData;


@end
