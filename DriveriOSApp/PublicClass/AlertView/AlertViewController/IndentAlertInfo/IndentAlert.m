//
//  IndentAlert.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/14.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "IndentAlert.h"

@interface IndentAlert ()
/** 头像 */
@property (nonatomic, strong) UIButton *headIMGBtn;
/** 昵称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 星级 */
@property (nonatomic, strong) StarsView *starsView;
/** 上车点 */
@property (nonatomic, strong) UILabel *startLabel;
/** 下车点 */
@property (nonatomic, strong) UILabel *endlabel;
/** 预约时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 抢单 */
@property (nonatomic, strong) UIButton *robIndent;

@property (nonatomic, strong) PublicTool *tool;
@end

@implementation IndentAlert
-(PublicTool *)tool{
    if (!_tool) {
        _tool = [PublicTool shareInstance];
    }
    return _tool;
}

-(UIButton *)headIMGBtn{
    if (!_headIMGBtn) {
        _headIMGBtn = [FactoryClass buttonWithFrame:CGRectMake((SCREEN_W-MATCHSIZE(60) - MATCHSIZE(200))/2, MATCHSIZE(100), MATCHSIZE(200), MATCHSIZE(200)) image:[UIImage imageNamed:@""]];
        _headIMGBtn.backgroundColor = [UIColor grayColor];
    }
    return _headIMGBtn;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(35) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
        _nameLabel.frame = CGRectMake((SCREEN_W -MATCHSIZE(60) - MATCHSIZE(200))/2, MATCHSIZE(320), MATCHSIZE(200), MATCHSIZE(50));

    }
    return _nameLabel;
}

-(StarsView *)starsView{
    if (!_starsView) {
        _starsView = [[StarsView alloc] initWithStarSize:CGSizeMake(MATCHSIZE(50), MATCHSIZE(50)) space:MATCHSIZE(50) numberOfStar:5];
        _starsView.selectable = NO;
    }
    return _starsView;
}

-(UILabel *)startLabel{
    if (!_startLabel) {
        _startLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    }
    return _startLabel;
}

-(UILabel *)endlabel{
    if (!_endlabel) {
        _endlabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    }
    return _endlabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    }
    return _timeLabel;
}

-(UIButton *)robIndent{
    if (!_robIndent) {
        _robIndent = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(30),MATCHSIZE(850), (SCREEN_W - MATCHSIZE(30)*2 - MATCHSIZE(100)), MATCHSIZE(80)) Title:@"抢单" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
        [_robIndent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _robIndent;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
    
    [self indentOnclick];
    
}

-(void)creatUI{
    
    [self.view addSubview:self.headIMGBtn];

    [self.view addSubview:self.nameLabel];
    //星级
    self.starsView.frame = CGRectMake((SCREEN_W - MATCHSIZE(60) -  MATCHSIZE(50)*9)/2, MATCHSIZE(400), MATCHSIZE(50)*9, MATCHSIZE(50));
    [self.view addSubview:self.starsView];
    //上车点图标
    UIImageView *startIMG = [FactoryClass imageViewWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2, MATCHSIZE(500), MATCHSIZE(40), MATCHSIZE(40)) Image:[UIImage imageNamed:@"item"]];
    [self.view addSubview:startIMG];
    //上车点标签
    UILabel *startL = [FactoryClass labelWithText:@"上车点:" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    startL.frame = CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2 + MATCHSIZE(50), MATCHSIZE(500), MATCHSIZE(130), MATCHSIZE(40));
    [self.view addSubview:startL];
    
    //上车点文本（乘客信息）
    self.startLabel.frame = CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2 + MATCHSIZE(50) + MATCHSIZE(130), MATCHSIZE(500), MATCHSIZE(300), MATCHSIZE(40));
    [self.view addSubview:self.startLabel];
    
    
    UIImageView *endIMG = [FactoryClass imageViewWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2, MATCHSIZE(570), MATCHSIZE(40), MATCHSIZE(40)) Image:[UIImage imageNamed:@"item"]];
    [self.view addSubview:endIMG];
    
    UILabel *endL = [FactoryClass labelWithText:@"下车点:" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    endL.frame = CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2 + MATCHSIZE(50), MATCHSIZE(570), MATCHSIZE(130), MATCHSIZE(40));
    [self.view addSubview:endL];
    
    //下车点文本（乘客信息）
    self.endlabel.frame = CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2 + MATCHSIZE(50) + MATCHSIZE(130), MATCHSIZE(570), MATCHSIZE(300), MATCHSIZE(40));
    [self.view addSubview:self.endlabel];
    
    UIImageView *timeIMG = [FactoryClass imageViewWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(400) - MATCHSIZE(60))/2, MATCHSIZE(640), MATCHSIZE(40), MATCHSIZE(40)) Image:[UIImage imageNamed:@"item"]];
    [self.view addSubview:timeIMG];
    
    UILabel *timeL = [FactoryClass labelWithText:@"预约时间:" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    timeL.frame = CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2 + MATCHSIZE(50), MATCHSIZE(640), MATCHSIZE(140), MATCHSIZE(40));
    [self.view addSubview:timeL];
    
    //预约时间文本（乘客信息）
    self.timeLabel.frame = CGRectMake((SCREEN_W - MATCHSIZE(400)-MATCHSIZE(60))/2 + MATCHSIZE(50) + MATCHSIZE(140), MATCHSIZE(640), MATCHSIZE(300), MATCHSIZE(40));
    [self.view addSubview:self.timeLabel];
    
    [self.view addSubview:self.robIndent];
    
    //测试  ＊＊＊＊＊获取数据＊＊＊＊＊
    self.nameLabel.text = @"吴先生";

    self.starsView.score = 4.0;
    
    self.startLabel.text = @"广州天环广场";
    
    self.endlabel.text = @"万胜围地铁站";

    self.timeLabel.text = @"12月15日";

}

-(void)indentOnclick{
    
    [[self.robIndent rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([_delegate respondsToSelector:@selector(closeAlertView)]) {
            [_delegate closeAlertView];
        }
        //测试***********显示抢单成功***********测试
        AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeCenterAlertInfo];
        [alert alertViewShowTitle:@"恭喜您，抢单成功，请赶紧与乘客联系，确认信息" textColor:[UIColor blueColor]];
    }];
}

@end
