//
//  SetupCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/12.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "SetupCell.h"

@implementation SetupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    //选中无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //背景
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleL = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.titleL.frame = CGRectMake(MATCHSIZE(30), MATCHSIZE(10), MATCHSIZE(200), MATCHSIZE(40));
    [self addSubview:self.titleL];
    
    self.subTitleL = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:[UIColor grayColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.subTitleL.frame = CGRectMake(MATCHSIZE(30), MATCHSIZE(50),SCREEN_W - MATCHSIZE(200), MATCHSIZE(30));
    [self addSubview:self.subTitleL];
    
    self.SwitchButton = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_W - MATCHSIZE(120), MATCHSIZE(20), MATCHSIZE(100), MATCHSIZE(50))];
    self.SwitchButton.transform = CGAffineTransformMakeScale(0.7, 0.7); //改变大小的关键代码
    [self.SwitchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.SwitchButton];
    
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    
    //改变本地缓存
    if (isButtonOn) {
        if ([self.titleL.text isEqualToString:@"实时路况"]) {
           [CacheClass cacheFromYYCacheWithValue:@"1" AndKey:Traffic_KEY];
            //发送通知：让地图做改变
            [PublicTool postNotificationWithName:Traffic_KEY object:@"1"];
        }else if ([self.titleL.text isEqualToString:@"声音提示"]){
          [CacheClass cacheFromYYCacheWithValue:@"1" AndKey:Voice_KEY];
        }else if([self.titleL.text isEqualToString:@"美颜相机"]){
           [CacheClass cacheFromYYCacheWithValue:@"1" AndKey:Beautiful_KEY];
        }

    }else {
        if ([self.titleL.text isEqualToString:@"实时路况"]) {
            [CacheClass cacheFromYYCacheWithValue:@"0" AndKey:Traffic_KEY];
            //发送通知：让地图做改变
            [PublicTool postNotificationWithName:Traffic_KEY object:@"0"];
        }else if ([self.titleL.text isEqualToString:@"声音提示"]){
            [CacheClass cacheFromYYCacheWithValue:@"0" AndKey:Voice_KEY];
        }else if([self.titleL.text isEqualToString:@"美颜相机"]){
            [CacheClass cacheFromYYCacheWithValue:@"0" AndKey:Beautiful_KEY];
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)changeTitle:(NSDictionary *)dict{
    
    //根据本地缓存获取SwitchButton的开或关
        if ([dict[@"title"] isEqualToString:@"实时路况"]) {
            NSObject *objValue = [CacheClass getAllDataFromYYCacheWithKey:Traffic_KEY];
            if (objValue != nil) {
                NSInteger flag = [(NSString *)objValue integerValue];
                if(flag == 1){
                    self.SwitchButton.on = YES;
                }else{
                    self.SwitchButton.on = NO;
                }
            }else{
                self.SwitchButton.on = NO;//默认状态 关闭
            }
           
        }else if ([dict[@"title"] isEqualToString:@"声音提示"]){
            NSObject *objValue = [CacheClass getAllDataFromYYCacheWithKey:Voice_KEY];
            if (objValue != nil) {
                NSInteger flag = [(NSString *)objValue integerValue];
                if(flag == 1){
                    self.SwitchButton.on = YES;
                }else{
                    self.SwitchButton.on = NO;
                }
            }else{
                self.SwitchButton.on = NO; //默认状态 关闭
            }

        }else if([dict[@"title"] isEqualToString:@"美颜相机"]){
            NSObject *objValue = [CacheClass getAllDataFromYYCacheWithKey:Beautiful_KEY];
            if (objValue != nil) {
                NSInteger flag = [(NSString *)objValue integerValue];
                if(flag == 1){
                    self.SwitchButton.on = YES;
                }else{
                    self.SwitchButton.on = NO;
                }
            }else{
                self.SwitchButton.on = YES;//默认状态 打开
            }
        }

    
    self.titleL.text = dict[@"title"];
    self.subTitleL.text = dict[@"subTitle"];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
