//
//  NotifyCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/12.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "NotifyCell.h"

@interface NotifyCell()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *dataIMG;

@end
@implementation NotifyCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
        
    }
    return self;
}

-(void)creatUI{
    //选中无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //背景
    self.backgroundColor = [UIColor whiteColor];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor grayColor];
    self.bgView.layer.cornerRadius = MATCHSIZE(8);
    self.bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    self.titleLabel = [FactoryClass labelWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(0), MATCHSIZE(300), MATCHSIZE(50)) TextColor:[UIColor blackColor] fontBoldSize:MATCHSIZE(30)];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.titleLabel];
    
    self.contentLable = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:0 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self.bgView addSubview:self.contentLable];
    
    self.dataLable = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentRight backGroundColor:[UIColor clearColor]];
    [self.bgView addSubview:self.dataLable];
    
    self.dataIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item"]];
    [self.bgView addSubview:self.dataIMG];
    
}

-(void)setModel:(NotifyModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;
    
    self.contentLable.text = model.content;
    
    self.dataLable.text = model.data;
    
    self.height = model.height + MATCHSIZE(160);

    self.bgView.frame = CGRectMake(MATCHSIZE(20), MATCHSIZE(20), SCREEN_W-MATCHSIZE(40), model.height + MATCHSIZE(140));
    
    self.contentLable.frame = CGRectMake(MATCHSIZE(10), MATCHSIZE(70), SCREEN_W - MATCHSIZE(60), model.height);

    self.dataLable.frame = CGRectMake(SCREEN_W - MATCHSIZE(220), MATCHSIZE(80) + model.height, MATCHSIZE(170), MATCHSIZE(50));
    
    self.dataIMG.frame = CGRectMake(SCREEN_W - MATCHSIZE(220) - MATCHSIZE(50), MATCHSIZE(80) + model.height, MATCHSIZE(50), MATCHSIZE(50));

}

@end
