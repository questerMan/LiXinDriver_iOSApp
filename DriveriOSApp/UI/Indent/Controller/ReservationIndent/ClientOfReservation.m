//
//  UserOfReservation.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "ClientOfReservation.h"

@implementation ClientOfReservation

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}


-(void)creatUI{
    
    self.backgroundColor = [UIColor grayColor];
    
    self.clientIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(10), MATCHSIZE(100), MATCHSIZE(100))];
    self.clientIMG.layer.cornerRadius = MATCHSIZE(50);
    self.clientIMG.layer.masksToBounds = YES;
    self.clientIMG.image = [UIImage imageNamed:@"userIMG"];
    [self addSubview:self.clientIMG];
    
    self.clientName = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(130), MATCHSIZE(30), MATCHSIZE(100), MATCHSIZE(60))];
    self.clientName.textColor = [UIColor whiteColor];
    self.clientName.text = @"吴先生";//测试
    self.clientName.textAlignment = NSTextAlignmentLeft;
    self.clientName.font = FontDefault;
    [self addSubview:self.clientName];
    
    self.number= [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(240), MATCHSIZE(30), MATCHSIZE(200), MATCHSIZE(60))];
    self.number.textColor = [UIColor whiteColor];
    self.number.text = @"133****0987";//测试
    self.number.textAlignment = NSTextAlignmentLeft;
    self.number.font = FontDefault;
    [self addSubview:self.number];
    
    self.starsView = [[StarsView alloc] initWithStarSize:CGSizeMake(MATCHSIZE(30), MATCHSIZE(30)) space:5 numberOfStar:5];
    self.starsView.frame = CGRectMake(SCREEN_W - MATCHSIZE(220), MATCHSIZE(40), MATCHSIZE(200), MATCHSIZE(40));
    self.starsView.score = 4.5;
    self.starsView.selectable = NO;
    [self addSubview:self.starsView];

}

@end
