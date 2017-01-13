//
//  PhoneAlert.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/13.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "PhoneAlert.h"

@interface PhoneAlert ()

@end

@implementation PhoneAlert
/** 懒加载 */
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [FactoryClass labelWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(10), SCREEN_W-MATCHSIZE(200), MATCHSIZE(60)) TextColor:[UIColor blackColor] fontBoldSize:MATCHSIZE(40)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor grayColor] numberOfLine:0 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
       
    }
    return _contentLabel;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [FactoryClass buttonWithFrame:CGRectMake(0,  MATCHSIZE(220), (SCREEN_W-MATCHSIZE(200))/2, MATCHSIZE(80)) Title:@"取消" backGround:[UIColor whiteColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(0)];
        _cancleBtn.layer.borderWidth = MATCHSIZE(1);
        _cancleBtn.tag = 100;
        [_cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancleBtn;
}



-(UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [FactoryClass buttonWithFrame:CGRectMake((SCREEN_W-MATCHSIZE(200))/2,  MATCHSIZE(220), (SCREEN_W-MATCHSIZE(200))/2, MATCHSIZE(80)) Title:@"好" backGround:[UIColor whiteColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(0)];
        _okBtn.layer.borderWidth = MATCHSIZE(1);
        _okBtn.tag = 100;
        [_okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _okBtn;
}

-(UITextField *)codeField{
    if (!_codeField) {
        _codeField = [[UITextField alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(160), (SCREEN_W-MATCHSIZE(200))/2 - MATCHSIZE(90) + MATCHSIZE(20), MATCHSIZE(80))];
        _codeField.keyboardType = UIKeyboardTypeNumberPad; //数字键
        _codeField.layer.borderWidth = MATCHSIZE(1);
        _codeField.hidden = YES;
    }
    return _codeField;
}

-(UIButton *)timeBtn{
    if (!_timeBtn) {
        _timeBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(60)*2 + (SCREEN_W-MATCHSIZE(200))/2 - MATCHSIZE(90) - MATCHSIZE(20), MATCHSIZE(160), (SCREEN_W-MATCHSIZE(200))/2 - MATCHSIZE(90) + MATCHSIZE(20), MATCHSIZE(80)) Title:@"获取验证码"];
        _timeBtn.layer.borderWidth = MATCHSIZE(1);
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeBtn.hidden = YES;
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:MATCHSIZE(30)];
    }
    return _timeBtn;
}
-(UIButton *)confirmCodeBtn{
    if (!_confirmCodeBtn) {
        _confirmCodeBtn = [FactoryClass buttonWithFrame:CGRectMake(0, MATCHSIZE(250), SCREEN_W-MATCHSIZE(200), MATCHSIZE(80)) Title:@"完成" backGround:[UIColor whiteColor] tintColor:[UIColor blueColor]];
        [_confirmCodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _confirmCodeBtn.hidden = YES;
    }
    return _confirmCodeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.cancleBtn];
    [self.view addSubview:self.okBtn];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.timeBtn];
    [self.view addSubview:self.confirmCodeBtn];
    
    [self creatUIWithState:State_PhoneNumber];//默认处于第一状态
    
    @weakify(self);

    //取消按钮点击事件
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        if ([_delegate respondsToSelector:@selector(closeAlertView)]) {
            [_delegate closeAlertView];
        }
        
    }];
    
    //好按钮点击事件
    [[self.okBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);

        [self creatUIWithState:State_sendCode];
        
    }];
    //监测验证码输入6位数 显示完成按钮
    [[[self.codeField rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length == 6;
    }] subscribeNext:^(id x) {
        @strongify(self);

        int lenght = (int)[(NSString *)x length];
        //显示完成按钮，下拉列表框
        if (_block) {
            _block(lenght);
        }
        //只能输入六位数
        [self.codeField resignFirstResponder];
        //显示完成按钮
        self.confirmCodeBtn.hidden = NO;
    }];
    //监测验证码输入不是6位数 显示不显示完成按钮
    [[[self.codeField rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length != 6;
    }] subscribeNext:^(id x) {
        @strongify(self);

        int lenght = (int)[(NSString *)x length];
        //显示完成按钮，下拉列表框
        if (_block) {
            _block(lenght);
        }
        //关闭完成按钮
        self.confirmCodeBtn.hidden = YES;
    }];
    
    //获取验证码倒计时按钮
    [[self.timeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.timeBtn countDownFromTime:60 title:@"获取验证码" unitTitle:@"s后重发" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
    }];
    
    //完成按钮
    [[self.confirmCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);

        [self creatUIWithState:State_remind];

        //收起下拉框 2s后自动关闭弹出框
        if (_block) {
            _block(100);
        }
        
    }];

}


-(void)creatUIWithState:(PhoneAlertState)state{
    
    NSString *phoneNumber = [PublicTool setStartOfMumber:(NSString *)[CacheClass getAllDataFromYYCacheWithKey:PhoneNumber_KEY]];

    if(state == State_PhoneNumber){
        self.okBtn.hidden = NO;
        self.cancleBtn.hidden = NO;
        self.codeField.hidden = YES;
        self.timeBtn.hidden = YES;
        
    self.titleLabel.text = @"确认手机号码";
        
    self.contentLabel.text = [NSString stringWithFormat:@"我们将以短信方式发送验证码到这个手机号码:%@",phoneNumber];
    CGFloat height = [PublicTool heightOfStr:_contentLabel.text andTextWidth:SCREEN_W-MATCHSIZE(200) andFont:[UIFont systemFontOfSize:MATCHSIZE(30)]];
    self.contentLabel.frame = CGRectMake(MATCHSIZE(10), MATCHSIZE(80), SCREEN_W-MATCHSIZE(200) - MATCHSIZE(20), height);
    
    }else if(state == State_sendCode){
        self.codeField.hidden = NO;
        self.okBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.timeBtn.hidden = NO;
        
        self.timeBtn.enabled = YES;//开始倒计时
        
        self.titleLabel.text = @"输入验证码";
        
        self.contentLabel.text = [NSString stringWithFormat:@"验证码发送至:%@",phoneNumber];
        CGFloat height = [PublicTool heightOfStr:_contentLabel.text andTextWidth:SCREEN_W-MATCHSIZE(200) andFont:[UIFont systemFontOfSize:MATCHSIZE(25)]];
        self.contentLabel.frame = CGRectMake(MATCHSIZE(10), MATCHSIZE(80), SCREEN_W-MATCHSIZE(200) - MATCHSIZE(20), height);

    }else if(state == State_remind){
        self.okBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.codeField.hidden = YES;
        self.timeBtn.hidden = YES;
        self.titleLabel.hidden = YES;
        self.confirmCodeBtn.hidden = YES;

        self.contentLabel.text = @"您已成功更换手机号码，记得下次登录使用新号码";
        self.contentLabel.textColor = [UIColor blueColor];
        CGFloat height = [PublicTool heightOfStr:_contentLabel.text andTextWidth:SCREEN_W-MATCHSIZE(200) andFont:[UIFont systemFontOfSize:MATCHSIZE(30)]];
        self.contentLabel.frame = CGRectMake(MATCHSIZE(10), MATCHSIZE(80), SCREEN_W-MATCHSIZE(200)- MATCHSIZE(20), height);

    }
    
}
#pragma mark - 显示下拉框列表回调
-(void)showInsetAlertViewHeightWithBlock:(PhoneAlertBlock)block{
    _block = block;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.codeField resignFirstResponder];
}



@end
