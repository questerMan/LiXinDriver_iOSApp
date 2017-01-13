//
//  LYKLeftMainHeadView.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/27.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LeftMainHeadView.h"

@implementation LeftMainHeadView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    //背景颜色
    self.backgroundColor = [UIColor grayColor];
    //用户头像
    self.userIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(30), MATCHSIZE(30), MATCHSIZE(140), MATCHSIZE(140))];
    self.userIMG.image = [UIImage imageNamed:@"userIMG"];//测试***************
    self.userIMG.layer.cornerRadius = MATCHSIZE(70);
    self.userIMG.backgroundColor = [UIColor whiteColor];
    self.userIMG.layer.masksToBounds = YES;
    [self addSubview:self.userIMG];
    
    //获取头像
    NSData *headData = [CacheClass getAllDataFromYYCacheWithKey:HeadIMG_KEY];
    if (headData != nil) {
        UIImage *image = [UIImage imageWithData:headData];
        self.userIMG.image = image;
    }
    //接收到修改头像信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"headIMG" object:nil] subscribeNext:^(NSNotification *x) {
        UIImage *image = [UIImage imageWithData:x.userInfo[@"headIMG"]];
        self.userIMG.image = image;

    }];

    
    
    //用户手机号
    self.userNumber = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(200), MATCHSIZE(50), SELF_W - MATCHSIZE(260), MATCHSIZE(50))];
    self.userNumber.textAlignment = NSTextAlignmentLeft;
    self.userNumber.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
    self.userNumber.textColor = [UIColor whiteColor];
    
    
    //测试***************
    NSString *phoneNumber = (NSString *)[CacheClass getAllDataFromYYCacheWithKey:PhoneNumber_KEY];
    NSString *number = [PublicTool setStartOfMumber:phoneNumber];
    self.userNumber.text = number;
    //接收到修改号码信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"phoneNumber" object:nil] subscribeNext:^(NSNotification *x) {
        self.userNumber.text = [PublicTool setStartOfMumber:x.userInfo[@"phoneNumber"]];
    }];
    
    //测试***************

    
    [self addSubview:self.userNumber];
    
    //用户星级
    self.userStars = [[StarsView alloc] initWithStarSize:CGSizeMake(MATCHSIZE(30), MATCHSIZE(30)) space:5 numberOfStar:5];
    self.userStars.frame = CGRectMake(MATCHSIZE(200), MATCHSIZE(100), SELF_W - MATCHSIZE(280), MATCHSIZE(50));
    self.userStars.score = 4.5;
    self.userStars.selectable = NO;
    [self addSubview:self.userStars];
}

@end
