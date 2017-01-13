//
//  SearchFootView.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "SearchFootView.h"

@implementation SearchFootView



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    self.frame = CGRectMake(0, 0, SCREEN_W, MATCHSIZE(60));
    
    UIButton *btn = [FactoryClass buttonWithFrame:self.frame Title:@"清除所有历史数据" backGround:[UIColor grayColor] tintColor:[UIColor blackColor]];
   //清除动作
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_block) {
            _block();
        }
    }];
    
    [self addSubview:btn];
}



-(void)clearAllHistoryDataWithBlock:(SearchFootViewBlock)searchFootBlock{
    _block = searchFootBlock;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
