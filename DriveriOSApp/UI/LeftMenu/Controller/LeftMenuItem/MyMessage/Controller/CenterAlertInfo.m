//
//  CenterAlertInfo.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "CenterAlertInfo.h"

@interface CenterAlertInfo ()



@end

@implementation CenterAlertInfo

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:0 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    }
    return _contentLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self creatUI];
    
}

-(void)creatUI{
    
   
    
    [self.view addSubview:self.contentLabel];
    
    
    
    
    
}




-(void)viewDidDisappear:(BOOL)animated{
   

}
-(void)dealloc{
    
    
}

@end
