//
//  MyIndentCell.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyIndentModel.h"

@interface MyIndentCell : UITableViewCell
//订单类型
@property (nonatomic, strong) UILabel *typeLabel;
//时间
@property (nonatomic, strong) UILabel *timeLabel;
//起点
@property (nonatomic, strong) UILabel *startPalceLabel;
//目的地
@property (nonatomic, strong) UILabel *endPalceLabel;
//状态
@property (nonatomic, strong) UILabel *stateLabel;
//模型
@property (nonatomic, strong) MyIndentModel *model;

@end
