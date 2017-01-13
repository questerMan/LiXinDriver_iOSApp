//
//  SetupCell.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/12.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *subTitleL;

@property (nonatomic, strong) UISwitch *SwitchButton;

-(void)changeTitle:(NSDictionary *)dict;

@end
