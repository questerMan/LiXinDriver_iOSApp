//
//  NotifyCell.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/12.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotifyModel.h"

@interface NotifyCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLable;

@property (nonatomic, strong) UILabel *dataLable;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NotifyModel *model;

@end
