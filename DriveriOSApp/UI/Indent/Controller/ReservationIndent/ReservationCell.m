//
//  ReservationCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "ReservationCell.h"

@interface ReservationCell ()
@property (nonatomic, strong) UIView *bgView;//背景图
@end

@implementation ReservationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //选中无色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    /** 背景 */
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(0), SCREEN_W - MATCHSIZE(20), MATCHSIZE(300))];
    self.bgView.backgroundColor = [UIColor grayColor];
    self.bgView.layer.cornerRadius = MATCHSIZE(8);
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:self.bgView];
    
    /** 头像图标 */
    self.headIMG = [FactoryClass imageViewWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(10), MATCHSIZE(140), MATCHSIZE(140)) Image:[UIImage imageNamed:@"userIMG"] cornerRadius:MATCHSIZE(70)];
    [self.bgView addSubview:self.headIMG];
    
    /** 名字 */
    self.name = [FactoryClass labelWithText:@"吴先生" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.name.frame = CGRectMake(MATCHSIZE(160), MATCHSIZE(20), MATCHSIZE(120), MATCHSIZE(60));
    [self.bgView addSubview:self.name];
                 
    /** 电话 */
    self.number = [FactoryClass labelWithText:@"18898326403" fontSize:MATCHSIZE(25) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.number.frame = CGRectMake(MATCHSIZE(280), MATCHSIZE(25), MATCHSIZE(200), MATCHSIZE(55));
    [self.bgView addSubview:self.number];
    
    /** 上车图标 */
    self.tCarIMG = [FactoryClass imageViewWithFrame:CGRectMake(MATCHSIZE(160), MATCHSIZE(100), MATCHSIZE(50), MATCHSIZE(50)) Image:[UIImage imageNamed:@"start"]];
    [self.bgView addSubview:self.tCarIMG];
    
    /** 下车图标 */
    self.bCarIMG = [FactoryClass imageViewWithFrame:CGRectMake(MATCHSIZE(160), MATCHSIZE(170), MATCHSIZE(50), MATCHSIZE(50)) Image:[UIImage imageNamed:@"end"]];
    [self.bgView addSubview:self.bCarIMG];
    
    /** 预约时间图标 */
    self.timeIMG = [FactoryClass imageViewWithFrame:CGRectMake(MATCHSIZE(160), MATCHSIZE(240), MATCHSIZE(50), MATCHSIZE(50)) Image:[UIImage imageNamed:@"history"]];
    [self.bgView addSubview:self.timeIMG];
    
    /** 上车点 */
    self.tCarLab = [FactoryClass labelWithText:@"上车点:" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.tCarLab.frame = CGRectMake(MATCHSIZE(220), MATCHSIZE(100), MATCHSIZE(120), MATCHSIZE(50));
    [self.bgView addSubview:self.tCarLab];
    
    /** 下车点 */
    self.bCarLab = [FactoryClass labelWithText:@"下车点:" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.bCarLab.frame = CGRectMake(MATCHSIZE(220), MATCHSIZE(170), MATCHSIZE(120), MATCHSIZE(50));
    [self.bgView addSubview:self.bCarLab];
    
    /** 预约时间 */
    self.timeLab = [FactoryClass labelWithText:@"预约时间:" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.timeLab.frame = CGRectMake(MATCHSIZE(220), MATCHSIZE(240), MATCHSIZE(140), MATCHSIZE(50));
    [self.bgView addSubview:self.timeLab];
    
    /** 上车点文本 */
    self.tCarText = [FactoryClass labelWithText:@"白云区白云山南门" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.tCarText.frame = CGRectMake(MATCHSIZE(340), MATCHSIZE(100), MATCHSIZE(230), MATCHSIZE(50));
    [self.bgView addSubview:self.tCarText];
    
    /** 下车点文本 */
    self.bCarText = [FactoryClass labelWithText:@"白云区白云山北门" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.bCarText.frame = CGRectMake(MATCHSIZE(340), MATCHSIZE(170), MATCHSIZE(230), MATCHSIZE(50));
    [self.bgView addSubview:self.bCarText];
    
    /** 预约时间文本 */
    self.timeText = [FactoryClass labelWithText:@"12月7日" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.timeText.frame = CGRectMake(MATCHSIZE(350), MATCHSIZE(240), MATCHSIZE(300), MATCHSIZE(50));
    [self.bgView addSubview:self.timeText];
    
    /** 打电话按钮 */
    self.callBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(500), MATCHSIZE(20), MATCHSIZE(60), MATCHSIZE(60)) image:[UIImage imageNamed:@"phone"]];
    
    //打电话
    [[self.callBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.number.text.length > 0 && self.number.text != nil) {
            //拨打电话
            [PublicTool callPhoneWithPhoneNum:self.number.text];
        }
    }];
    [self.bgView addSubview:self.callBtn];
    
    /** 订单状态标签 */
    self.satus = [FactoryClass labelWithText:@"预约中" fontSize:MATCHSIZE(30) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor blackColor]];
    self.satus.frame = CGRectMake(SCREEN_W - MATCHSIZE(170), MATCHSIZE(200), MATCHSIZE(140), MATCHSIZE(80));
    [self.bgView addSubview:self.satus];
}



@end
