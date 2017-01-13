//
//  MyIndentCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//


#import "MyIndentCell.h"

@interface MyIndentCell()
    
@property (nonatomic, strong) UIView *bgView;

@end

@implementation MyIndentCell

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
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(0), (SCREEN_W - MATCHSIZE(40)), MATCHSIZE(300))];
    self.bgView.backgroundColor = [UIColor grayColor];
    self.bgView.layer.cornerRadius = MATCHSIZE(8);
    self.bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    self.typeLabel = [FactoryClass labelWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(0), MATCHSIZE(300), MATCHSIZE(50)) TextColor:[UIColor blackColor] fontBoldSize:MATCHSIZE(30)];
    self.typeLabel.numberOfLines = 1;
    self.typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.typeLabel];
    
    //
    self.stateLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentRight backGroundColor:[UIColor clearColor]];
    self.stateLabel.frame = CGRectMake(self.bgView.frame.size.width - MATCHSIZE(300) - MATCHSIZE(50), MATCHSIZE(0), MATCHSIZE(300), MATCHSIZE(50));
    [self.bgView addSubview:self.stateLabel];
    
    UIImageView *timeIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(70), MATCHSIZE(50), MATCHSIZE(50))];
    timeIMG.image = [UIImage imageNamed:@"item"];
    [self.bgView addSubview:timeIMG];
    
    self.timeLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.timeLabel.frame = CGRectMake(MATCHSIZE(70), MATCHSIZE(70), SCREEN_W - MATCHSIZE(100), MATCHSIZE(50));
    [self.bgView addSubview:self.timeLabel];
    
    
    UIImageView *startIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(140), MATCHSIZE(50), MATCHSIZE(50))];
    startIMG.image = [UIImage imageNamed:@"item"];
    [self.bgView addSubview:startIMG];
    
    self.startPalceLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.startPalceLabel.frame = CGRectMake(MATCHSIZE(70), MATCHSIZE(140), SCREEN_W - MATCHSIZE(100), MATCHSIZE(50));
    [self.bgView addSubview:self.startPalceLabel];
    
    UIImageView *endIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(210), MATCHSIZE(50), MATCHSIZE(50))];
    endIMG.image = [UIImage imageNamed:@"item"];
    [self.bgView addSubview:endIMG];
    
    self.endPalceLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.endPalceLabel.frame = CGRectMake(MATCHSIZE(70), MATCHSIZE(210), SCREEN_W - MATCHSIZE(100), MATCHSIZE(50));
    [self.bgView addSubview:self.endPalceLabel];

    
}



-(void)setModel:(MyIndentModel *)model{
    _model = model;

    self.typeLabel.text = model.type;
    
    self.timeLabel.text = model.timeData;
    
    self.startPalceLabel.text = model.startPlace;
    
    self.endPalceLabel.text = model.endPlace;
    
    self.stateLabel.text = model.state;
 
}

@end
