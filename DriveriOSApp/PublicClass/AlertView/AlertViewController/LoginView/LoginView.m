//
//  LoginView.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LoginView.h"


@interface LoginView ()
/** 用户名 */
@property (nonatomic, strong) UITextField *usersF;
/** 密  码 */
@property (nonatomic, strong) UITextField *passWordF;
/** 验证码 */
@property (nonatomic, strong) UITextField *codeF;
/** 发送验证码按钮 */
@property (nonatomic, strong) UIButton *sendCodeBtn;
/** 忘记密码 */
@property (nonatomic, strong) UIButton *lookPassWordBtn;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *eyeBtn;

@end

@implementation LoginView

-(UITextField *)usersF{
    if (!_usersF) {
        _usersF = [FactoryClass textFieldWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(80), SCREEN_W - MATCHSIZE(340), MATCHSIZE(40)) placeholder:@"  " placeholderColor:[UIColor grayColor] textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft cornerRadius:0 itemImage:[UIImage imageNamed:@""] keyboardType:UIKeyboardTypeNumberPad];
        _usersF.tag = 1000;
    }
    return _usersF;
}

-(UITextField *)passWordF{
    if (!_passWordF) {
        _passWordF = [FactoryClass textFieldWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(183), SCREEN_W - MATCHSIZE(340), MATCHSIZE(40)) placeholder:@"  " placeholderColor:[UIColor grayColor] textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft cornerRadius:0 itemImage:[UIImage imageNamed:@""] keyboardType:UIKeyboardTypeNumberPad];
        _passWordF.secureTextEntry = YES;
        _passWordF.tag = 1001;
    }
    return _passWordF;
}

-(UITextField *)codeF{
    if (!_codeF) {
        _codeF = [FactoryClass textFieldWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(284), MATCHSIZE(180), MATCHSIZE(40)) placeholder:@"  " placeholderColor:[UIColor grayColor] textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft cornerRadius:0 itemImage:[UIImage imageNamed:@""] keyboardType:UIKeyboardTypeNumberPad];
        _codeF.tag = 1002;
    }
    return _codeF;
}

-(UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [FactoryClass buttonWithFrame:CGRectMake(SCREEN_W - MATCHSIZE(340) - MATCHSIZE(120) , MATCHSIZE(254), MATCHSIZE(180), MATCHSIZE(70)) Title:@"获取验证码" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(2)];
        [_sendCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(25)];
    }
    return _sendCodeBtn;
}


-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [FactoryClass buttonWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(220) - MATCHSIZE(100))/2, MATCHSIZE(384), MATCHSIZE(100), MATCHSIZE(40)) Title:@"登录" backGround:[UIColor clearColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
    }
    return _loginBtn;
}

-(UIButton *)eyeBtn{
    if (!_eyeBtn) {
        _eyeBtn = [FactoryClass buttonWithFrame:CGRectMake(0, MATCHSIZE(20), MATCHSIZE(40), MATCHSIZE(40)) image:[UIImage imageNamed:@"eye"]];
    }
    return _eyeBtn;
}

-(UIButton *)lookPassWordBtn{
    if (!_lookPassWordBtn) {
        CGFloat lenght = [PublicTool lengthofStr:@"忘记密码？" AndSystemFontOfSize:MATCHSIZE(30)];
        _lookPassWordBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(470), lenght, MATCHSIZE(60)) Title:@"忘记密码?" backGround:[UIColor clearColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(0)];
        [_lookPassWordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _lookPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
        _lookPassWordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _lookPassWordBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];

}


-(void)creatUI{
    self.view.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(0), VIEW_W, MATCHSIZE(450))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = MATCHSIZE(10);
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    UILabel *userNameLab = [FactoryClass labelWithText:@"手机号" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    userNameLab.frame = CGRectMake(MATCHSIZE(60), MATCHSIZE(30), MATCHSIZE(200), MATCHSIZE(40));
    [self.view addSubview:userNameLab];
    //手机文本框
    [self.view addSubview:self.usersF];
   
    UILabel *line = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor blackColor]];
    line.frame = CGRectMake(MATCHSIZE(60), MATCHSIZE(121), VIEW_W - MATCHSIZE(340), MATCHSIZE(2));
    [self.view addSubview:line];

    UILabel *userPassLab = [FactoryClass labelWithText:@"密  码" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    userPassLab.frame = CGRectMake(MATCHSIZE(60), MATCHSIZE(133), MATCHSIZE(200), MATCHSIZE(40));
    [self.view addSubview:userPassLab];
    //密码文本框
    [self.view addSubview:self.passWordF];

    UILabel *line2 = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor blackColor]];
    line2.frame = CGRectMake(MATCHSIZE(60), MATCHSIZE(224), VIEW_W - MATCHSIZE(340), MATCHSIZE(2));
    [self.view addSubview:line2];
    //验证码文本框
    [self.view addSubview:self.codeF];
    
    UILabel *line3 = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor blackColor]];
    line3.frame = CGRectMake(MATCHSIZE(60), MATCHSIZE(325), MATCHSIZE(160), MATCHSIZE(2));
    [self.view addSubview:line3];
    
    //发送验证码
    [self.view addSubview:self.sendCodeBtn];
    //发送验证码按钮点击事件
    [[self.sendCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        UIButton *btn = (UIButton *)x;
        [btn countDownFromTime:60 title:@"获取验证码" unitTitle:@"s后重新获取" mainColor:[UIColor grayColor] countColor:[UIColor grayColor]];
        
    }];
    
    
    //登录
    [self.view addSubview:self.loginBtn];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        
        [self showHint:@"登录"];
        
    }];
    
    //忘记密码
    [self.view addSubview:self.lookPassWordBtn];
    [[self.lookPassWordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        

        [self showHint:@"忘记密码"];
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.usersF resignFirstResponder];
    [self.passWordF resignFirstResponder];
    [self.codeF resignFirstResponder];
}






@end


