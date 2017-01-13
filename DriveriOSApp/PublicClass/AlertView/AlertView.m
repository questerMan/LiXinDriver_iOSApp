//
//  AlertView.m
//  AlertViewDemo
//
//  Created by lixin on 16/10/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AlertView.h"
#import "CenterAlertInfo.h"
#import "PhoneAlert.h"
#import "CodeAlert.h"
#import "LoadAlert.h"
#import "IndentAlert.h"
#import "LoginView.h"

@interface AlertView()<PhoneAlertDelegate,IndentAlertDelegate>

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *alertView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CenterAlertInfo *centerAlertInfo;

@property (nonatomic, strong) PhoneAlert *phoneAlert;

@property (nonatomic, strong) CodeAlert *codeAlert;

@property (nonatomic, strong) LoadAlert *loadAlert;

@property (nonatomic, strong) IndentAlert *indentAlert;

@property (nonatomic, strong) LoginView *loginAlert;
@end

@implementation AlertView

/** 懒加载 */
-(CenterAlertInfo *)centerAlertInfo{
    if (!_centerAlertInfo) {
        _centerAlertInfo = [[CenterAlertInfo alloc] init];
    }
    return _centerAlertInfo;
}

-(PhoneAlert *)phoneAlert{
    if (!_phoneAlert) {
        _phoneAlert = [[PhoneAlert alloc] init];
        _phoneAlert.delegate = self;
    }
    return _phoneAlert;
}

-(CodeAlert *)codeAlert{
    if (!_codeAlert) {
        _codeAlert = [[CodeAlert alloc] init];
    }
    return _codeAlert;
}

-(LoadAlert *)loadAlert{
    if (!_loadAlert) {
        _loadAlert = [[LoadAlert alloc] init];
    }
    return _loadAlert;
}

-(IndentAlert *)indentAlert{
    if (!_indentAlert) {
        _indentAlert = [[IndentAlert alloc] init];
        _indentAlert.delegate = self;
    }
    return _indentAlert;
}

-(LoginView *)loginAlert{
    if (!_loginAlert) {
        _loginAlert = [[LoginView alloc] init];
    }
    return _loginAlert;
}

//直接调用该方法一般用于固定 view 的展示
-(instancetype)initWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType{
    
    _addAlertViewType = alertViewType;
    
    if (self = [super initWithFrame:frame]) {
        
        switch (alertViewType) {
            case AlertViewTypeCenterAlertInfo:
              
                [self isCloseWithTap:YES];
                [self isCreatTimerWithTimeInterval:5];//测试
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

                break;
                
            case AlertViewTypePhoneAlert:
               
                [self isCloseWithTap:NO];
                
                break;
                
            case AlertViewTypeCodeAlert:
              
                [self isCloseWithTap:YES];
                
                break;
                
            case AlertViewTypeLoadAlert:
              
                [self isCloseWithTap:YES];
                
                break;
                
            case AlertViewTypeIndentAlert:
                
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeLoginAlert:
                
                [self isCloseWithTap:YES];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

                break;
            default:
                break;
        }
        
    }
    
   

    return self;
}
#pragma mark - 添加背景膜层，是否需要点击模糊层关闭弹出框:YES为可以点击模糊层关闭alertView
-(void)isCloseWithTap:(BOOL)isClose{
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    
    [self addSubview:self.bgView];
    
    if (isClose == YES) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        self.bgView.userInteractionEnabled = YES;
        [self.bgView addGestureRecognizer:tap];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    [self alertViewClose];
    
}
-(void)isCreatTimerWithTimeInterval:(NSTimeInterval)timeInterval{
    //不重复，只调用一次。timer运行一次就会自动停止运行
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(scrollTimer) userInfo:nil repeats:NO];
}
-(void)scrollTimer{
    [self alertViewClose];
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
    
}
#pragma mark - 初始化alertView
-(void)initAlertViewWithViewController:(UIViewController *)controller{
    if (self.alertView) return;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(300))];
    self.alertView.layer.cornerRadius = MATCHSIZE(10);
    self.alertView.layer.masksToBounds = YES;
    self.alertView.alpha = 0;
    self.alertView.userInteractionEnabled = YES;
    
    [self.alertView addSubview:controller.view];
    [self addSubview:self.alertView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 1;
    }];
    
    [window addSubview:self];
}

#pragma mark - 显示alertView
-(void)alertViewShow{
    
    if (_addAlertViewType == AlertViewTypePhoneAlert){
        
        [self initAlertViewWithViewController:self.phoneAlert];
        __weak typeof(self) weakSelf = self;

        //下拉框回调
        [self.phoneAlert showInsetAlertViewHeightWithBlock:^(int lenght) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;

            if (lenght == 6) {
                [UIView animateWithDuration:0.3 animations:^{
                    strongSelf.alertView.frame = CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(360));
                }];
            }else if (lenght == 100) {
                [UIView animateWithDuration:0.3 animations:^{
                    strongSelf.alertView.frame = CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(200));
                }];
                //2s后自动关闭弹出框
                double delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [strongSelf alertViewClose];
                });
            } else{
                [UIView animateWithDuration:0.3 animations:^{
                    strongSelf.alertView.frame = CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(300));
                }];
            }
        }];
        
    }else if (_addAlertViewType == AlertViewTypeCodeAlert){
        
        [self initAlertViewWithViewController:self.codeAlert];
        
    }else if (_addAlertViewType == AlertViewTypeLoadAlert){
        
        [self initAlertViewWithViewController:self.loadAlert];
        
    }else if (_addAlertViewType == AlertViewTypeIndentAlert){
        
        [self initAlertViewWithViewController:self.indentAlert];
        self.alertView.frame = CGRectMake(MATCHSIZE(50), MATCHSIZE(150), SCREEN_W - MATCHSIZE(100),SCREEN_H - MATCHSIZE(300));

    }else if (_addAlertViewType == AlertViewTypeLoginAlert){
        [self initAlertViewWithViewController:self.loginAlert];
        self.alertView.frame = CGRectMake(MATCHSIZE(110), MATCHSIZE(600), SCREEN_W - MATCHSIZE(220), MATCHSIZE(530));

    }
    
}
#pragma mark - 只显示文字
-(void)alertViewShowTitle:(NSString *)title
                textColor:(UIColor *)textColor{
    if (_addAlertViewType == AlertViewTypeCenterAlertInfo) {
        
        [self initAlertViewWithViewController:self.centerAlertInfo];
        
        //计算文字高度
        self.centerAlertInfo.contentLabel.text = title;
        self.centerAlertInfo.contentLabel.textColor = [UIColor blueColor];
        CGFloat height = [PublicTool heightOfStr:self.centerAlertInfo.contentLabel.text andTextWidth:SCREEN_W-MATCHSIZE(200) andFont:[UIFont systemFontOfSize:MATCHSIZE(30)]];
        self.centerAlertInfo.contentLabel.frame = CGRectMake(MATCHSIZE(20), MATCHSIZE(30), SCREEN_W-MATCHSIZE(200)- MATCHSIZE(40), height);
        self.centerAlertInfo.contentLabel.textColor = textColor;
        
        self.alertView.frame = CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), height + MATCHSIZE(60));

    }
}

#pragma mark - phoneAlert/IndentAlertDelegate代理
-(void)closeAlertView{
    [self alertViewClose];
}

-(void)alertViewClose{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        if (_timer) {
            //关闭定时器
            [_timer setFireDate:[NSDate distantFuture]];
            _timer = nil;
        }
        [self.alertView removeFromSuperview];
        self.alertView = nil;
        [self removeFromSuperview];
    }];
}

-(void)keyboardWillChange:(NSNotification  *)notification
{
    // 1.获取键盘的Y值
    NSDictionary *dict  = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 获取动画执行时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 2.计算需要移动的距离
    CGFloat selfY = keyboardY - self.height;
    
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        // 需要执行动画的代码
        self.y = selfY;
        //self.bgView.alpha = 0.5;
    } completion:^(BOOL finished) {
        // 动画执行完毕执行的代码
        if (_alertView == nil) {
            //  [self.textField resignFirstResponder];
            [self removeFromSuperview];
        }
    }];
}
@end
