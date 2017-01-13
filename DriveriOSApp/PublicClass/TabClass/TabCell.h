//
//  TabCell.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//


#import <UIKit/UIKit.h>
/**
 *tab点击对应相应的类型，比如：0 表示 等单
 *                        1 表示 即时单
 *                        2 表示 预约单
 *                        3 表示 接机
 *                        4 表示 送机
 *                        5 表示 抢单
 */

@interface TabCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lable;

@property (nonatomic, assign) BOOL isSelectItem;//默认第一次加载选中第一个cell为YES来改变Lable文本颜色
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) TabModel *model;

@end
