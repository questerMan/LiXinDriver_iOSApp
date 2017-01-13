//
//  PhoneNumber.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/14.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "PhoneNumber.h"
#import "ChangeNumber.h"

@interface PhoneNumber ()

@property (nonatomic, strong) UIImageView *phoneIMG;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *subTitleL;

@property (nonatomic, strong) UIButton *changePhoneNumber;

@end

@implementation PhoneNumber

-(UIImageView *)phoneIMG{
    if (!_phoneIMG) {
        _phoneIMG = [FactoryClass imageViewWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(220))/2, MATCHSIZE(150), MATCHSIZE(220), MATCHSIZE(220)) Image:[UIImage imageNamed:@"iPhone"] cornerRadius:MATCHSIZE(8)];
    }
    return _phoneIMG;
}

-(UILabel *)titleL{
    if (!_titleL) {
        NSString *phoneNumber = [PublicTool setStartOfMumber:(NSString *)[CacheClass getAllDataFromYYCacheWithKey:PhoneNumber_KEY]];
        _titleL = [FactoryClass labelWithText:[NSString stringWithFormat:@"您当前的手机号码:%@",phoneNumber] fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
        _titleL.frame = CGRectMake(0, MATCHSIZE(400), SCREEN_W, MATCHSIZE(60));
    }
    return _titleL;
}
-(UILabel *)subTitleL{
    if (!_subTitleL) {
        _subTitleL = [FactoryClass labelWithText:@"更换手机号后个人信息不变，下次可以使用新手机号登陆" fontSize:MATCHSIZE(20) textColor:[UIColor grayColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
        _subTitleL.frame = CGRectMake(0, MATCHSIZE(470), SCREEN_W, MATCHSIZE(50));
    }
    return _subTitleL;
}

-(UIButton *)changePhoneNumber{
    if (!_changePhoneNumber) {
        _changePhoneNumber = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(30), MATCHSIZE(700), SCREEN_W - MATCHSIZE(30)*2, MATCHSIZE(80)) Title:@"更换手机号" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
        [_changePhoneNumber setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _changePhoneNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"更换手机号";
    
    [self creatUI];
}

-(void)creatUI{
    
    [self.view addSubview:self.phoneIMG];
    
    [self.view addSubview:self.titleL];

    [self.view addSubview:self.subTitleL];

    [self.view addSubview:self.changePhoneNumber];
    
    @weakify(self);
    //更换手机号按钮点击事件
    [[self.changePhoneNumber rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        ChangeNumber *changeNum = [[ChangeNumber alloc] init];
        [self.navigationController pushViewController:changeNum animated:YES];
    }];

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
