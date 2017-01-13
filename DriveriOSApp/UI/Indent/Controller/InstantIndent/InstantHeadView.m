//
//  InstantHeadView.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "InstantHeadView.h"

@implementation InstantHeadView

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
    
    self.startIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(20), MATCHSIZE(40), MATCHSIZE(40))];
    self.startIMG.image = [UIImage imageNamed:@"item"];
    [self addSubview:self.startIMG];
    
    UILabel *startLable = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(80), MATCHSIZE(20), MATCHSIZE(120), MATCHSIZE(40))];
    startLable.textAlignment = NSTextAlignmentLeft;
    startLable.text = @"出发地:";
    startLable.font = FontDefault;
    startLable.textColor = [UIColor whiteColor];
    [self addSubview:startLable];
    
    self.endIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(80), MATCHSIZE(40), MATCHSIZE(40))];
    self.endIMG.image = [UIImage imageNamed:@"item"];
    [self addSubview:self.endIMG];
    
    UILabel *endLable = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(80), MATCHSIZE(80), MATCHSIZE(120), MATCHSIZE(40))];
    endLable.textAlignment = NSTextAlignmentLeft;
    endLable.text = @"目的地:";
    endLable.font = FontDefault;
    endLable.textColor = [UIColor whiteColor];
    [self addSubview:endLable];
    
    
    self.startAddress = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(210), MATCHSIZE(20),SELF_W - MATCHSIZE(200), MATCHSIZE(40))];
    self.startAddress.textAlignment = NSTextAlignmentLeft;
    self.startAddress.text = @"广州荔湾区中山七路";//测试＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    self.startAddress.font = FontDefault;
    self.startAddress.textColor = [UIColor whiteColor];
    [self addSubview:self.startAddress];
    
    self.endAddress = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(210), MATCHSIZE(80),SELF_W - MATCHSIZE(200), MATCHSIZE(40))];
    self.endAddress.textAlignment = NSTextAlignmentLeft;
    self.endAddress.text = @"广州荔湾区中山八路";//测试＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    self.endAddress.font = FontDefault;
    self.endAddress.textColor = [UIColor whiteColor];
    [self addSubview:self.endAddress];
}

@end
