//
//  LYKMyMessage.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "MyMessage.h"

@interface MyMessage ()
/** 头像 */
@property (nonatomic, strong) UIButton *headIMGBtn;
/** 昵称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 号码 */
@property (nonatomic, strong) UILabel *numberLabel;
/** 车牌车型文本 */
@property (nonatomic, strong) UILabel *carStyleLabel;
/** 个性签名图标 */
@property (nonatomic, strong) UIImageView *signatureIMG;
/** 个性签名文本 */
@property (nonatomic, strong) UILabel *signatureLabel;
/** 星级 */
@property (nonatomic, strong) StarsView *starsView;

@property (nonatomic, strong) PublicTool *tool;

@end

@implementation MyMessage

-(PublicTool *)tool{
    if (!_tool) {
        _tool = [PublicTool shareInstance];
    }
    return _tool;
}

-(UIButton *)headIMGBtn{
    if (!_headIMGBtn) {
        _headIMGBtn = [FactoryClass buttonWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(200))/2, MATCHSIZE(100), MATCHSIZE(200), MATCHSIZE(200)) image:[UIImage imageNamed:@""]];
        _headIMGBtn.backgroundColor = [UIColor whiteColor];
    }
    return _headIMGBtn;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(35) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
        
    }
    return _nameLabel;
}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(40) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    }
    return _numberLabel;
}

-(UILabel *)carStyleLabel{
    if (!_carStyleLabel) {
        _carStyleLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(25) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    }
    return _carStyleLabel;
}


-(UIImageView *)signatureIMG{
    if(!_signatureIMG) {
        _signatureIMG = [FactoryClass imageViewWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(450))/2, MATCHSIZE(520), MATCHSIZE(40), MATCHSIZE(40)) Image:[UIImage imageNamed:@"item"]];
    }
    return _signatureIMG;
}
-(UILabel *)signatureLabel{
    if (!_signatureLabel) {
        _signatureLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(25) textColor:[UIColor whiteColor] numberOfLine:0 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    }
    return _signatureLabel;
}

-(StarsView *)starsView{
    if (!_starsView) {
        _starsView = [[StarsView alloc] initWithStarSize:CGSizeMake(MATCHSIZE(60), MATCHSIZE(60)) space:MATCHSIZE(60) numberOfStar:5];
        _starsView.selectable = NO;
    }
    return _starsView;
}
-(void)viewWillAppear:(BOOL)animated{
    
    //导航栏的状态
    [self changeNavigation];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editedOnclick:)];
}

-(void)editedOnclick:(UIBarButtonItem *)barItem{
    [self showHint:@"编辑按钮"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    [self creatUI];
}
-(void)initData{
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"我的信息";
}

-(void)creatUI{
    
    //获取头像
    NSData *headData = [CacheClass getAllDataFromYYCacheWithKey:HeadIMG_KEY];
    if (headData != nil) {
        UIImage *image = [UIImage imageWithData:headData];
        [self.headIMGBtn setImage:image forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.headIMGBtn];
    
    @weakify(self);

    //头像点击事件
    [[self.headIMGBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);

        UIButton *headBtn = (UIButton *)x;
        
        [self.tool putAlertViewWithViewController:self andPicBlock:^(UIImage *image) {
            [headBtn setImage:image forState:UIControlStateNormal];
            NSData *dataIMG = UIImagePNGRepresentation(image);
            //缓存
            [CacheClass cacheFromYYCacheWithValue:dataIMG AndKey:HeadIMG_KEY];
            
            //发送通知修改头像（在leftMian头部view接收该通知） 测试*************************
            [[NSNotificationCenter defaultCenter] postNotificationName:@"headIMG" object:nil userInfo:@{@"headIMG":dataIMG}];
        }];
        
        

        
    }];
    
    self.nameLabel.text = @"王师傅";
    self.nameLabel.frame = CGRectMake((SCREEN_W - MATCHSIZE(200))/2, MATCHSIZE(320), MATCHSIZE(200), MATCHSIZE(50));
    [self.view addSubview:self.nameLabel];
    
    //测试***************
    NSString *phoneNumber = (NSString *)[CacheClass getAllDataFromYYCacheWithKey:PhoneNumber_KEY];
    NSString *number = [PublicTool setStartOfMumber:phoneNumber];
    self.numberLabel.text = number;

    self.numberLabel.frame = CGRectMake((SCREEN_W - MATCHSIZE(300))/2, MATCHSIZE(380), MATCHSIZE(300), MATCHSIZE(60));
    [self.view addSubview:self.numberLabel];
    
    self.carStyleLabel.text = @"车型 ＋ 车牌";
    self.carStyleLabel.frame = CGRectMake((SCREEN_W - MATCHSIZE(200))/2, MATCHSIZE(450), MATCHSIZE(200), MATCHSIZE(50));
    [self.view addSubview:self.carStyleLabel];
    
    [self.view addSubview:self.signatureIMG];
    
    self.signatureLabel.text = @"还未填写个性签名，来介绍一下自己吧。";
    CGFloat height = [PublicTool heightOfStr:self.signatureLabel.text andTextWidth:MATCHSIZE(400) andFont:[UIFont systemFontOfSize:MATCHSIZE(25)]];
    self.signatureLabel.frame = CGRectMake((SCREEN_W - MATCHSIZE(450))/2 + MATCHSIZE(50), MATCHSIZE(520), MATCHSIZE(400), height);
    [self.view addSubview:self.signatureLabel];
    
    self.starsView.frame = CGRectMake((SCREEN_W -  MATCHSIZE(60)*9)/2, MATCHSIZE(700), MATCHSIZE(60)*9, MATCHSIZE(60));
    self.starsView.score = 4.0;
    [self.view addSubview:self.starsView];
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
