//
//  ChangeNumber.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/14.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "ChangeNumber.h"
#import "Safety.h"
@interface ChangeNumber ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *subTitleL;

@property (nonatomic, strong) UITextField *phoneNumberF;

@property (nonatomic, strong) UIBarButtonItem *cancleBarbtn;

@property (nonatomic, strong) UIBarButtonItem *nextBarbtn;

@end

@implementation ChangeNumber


-(UILabel *)titleL{
    if (!_titleL) {
        NSString *phoneNumber = [PublicTool setStartOfMumber:(NSString *)[CacheClass getAllDataFromYYCacheWithKey:PhoneNumber_KEY]];
        _titleL = [FactoryClass labelWithText:[NSString stringWithFormat:@"您当前的手机号码:%@",phoneNumber] fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
        _titleL.frame = CGRectMake(0, MATCHSIZE(80), SCREEN_W, MATCHSIZE(60));
    }
    return _titleL;
}
-(UILabel *)subTitleL{
    if (!_subTitleL) {
        _subTitleL = [FactoryClass labelWithText:@"更换手机不影响账号和数据，下次可以使用新手机号登陆" fontSize:MATCHSIZE(20) textColor:[UIColor grayColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
        _subTitleL.frame = CGRectMake(0, MATCHSIZE(180), SCREEN_W, MATCHSIZE(50));
    }
    return _subTitleL;
}

-(UITextField *)phoneNumberF{
    if (!_phoneNumberF) {
        _phoneNumberF = [[UITextField alloc] initWithFrame:CGRectMake(0, MATCHSIZE(350), SCREEN_W, MATCHSIZE(80))];
        _phoneNumberF.placeholder = @"请输入新的手机号";
        [_phoneNumberF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
        _phoneNumberF.textColor = [UIColor whiteColor];
        _phoneNumberF.textAlignment = NSTextAlignmentCenter;
        _phoneNumberF.backgroundColor = [UIColor grayColor];
        _phoneNumberF.keyboardType = UIKeyboardTypeNumberPad; //数字键
        _phoneNumberF.clearButtonMode = UITextFieldViewModeAlways;
        _phoneNumberF.delegate = self;
    }
    return _phoneNumberF;
}

-(UIBarButtonItem *)cancleBarbtn{
    if (!_cancleBarbtn) {
        _cancleBarbtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancleOnclick:)];
    }
    return _cancleBarbtn;
}
-(void)cancleOnclick:(UIBarButtonItem *)itemBar{

    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
}

-(UIBarButtonItem *)nextBarbtn{
    if (!_nextBarbtn) {
        _nextBarbtn = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(nextOnclick:)];
        _nextBarbtn.enabled = NO;
    }
    return _nextBarbtn;
}
//下一步
-(void)nextOnclick:(UIBarButtonItem *)itemBar{
    //保存新手机号
    [CacheClass cacheFromYYCacheWithValue:self.phoneNumberF.text AndKey:PhoneNumber_KEY];
    //发送通知修改号码（在leftMian头部view接收该通知） 测试*************************
    [[NSNotificationCenter defaultCenter] postNotificationName:@"phoneNumber" object:nil userInfo:@{@"phoneNumber":self.phoneNumberF.text}];

    AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypePhoneAlert];
    [alert alertViewShow];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationItem.leftBarButtonItem = self.cancleBarbtn;
    
    self.navigationItem.rightBarButtonItem = self.nextBarbtn;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"更换手机号";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
}

-(void)creatUI{
    
    [self.view addSubview:self.titleL];
    
    [self.view addSubview:self.subTitleL];
    
    [self.view addSubview:self.phoneNumberF];

    @weakify(self);

    [[[self.phoneNumberF rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length == 11 && [PublicTool isMobileNumber:text];
    }] subscribeNext:^(id x) {
        @strongify(self);
        //显示下一步按钮
        self.nextBarbtn.enabled = YES;
        
        [self.phoneNumberF resignFirstResponder];
    }];
    
    //更换手机号：保存到内存里
    [[[self.phoneNumberF rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length != 11 || ![PublicTool isMobileNumber:text];
    }] subscribeNext:^(id x) {
        @strongify(self);
        //下一步按钮变暗
        self.nextBarbtn.enabled = NO;
        
    }];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    if (textField.text.length != 11 || ![PublicTool isMobileNumber:textField.text]) {
        [self showHint:@"手机号码有误"];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumberF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
