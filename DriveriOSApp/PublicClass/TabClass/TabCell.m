//
//  TabCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "TabCell.h"

@implementation TabCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    self.lable = [[UILabel alloc] init];
    self.lable.frame = CGRectMake(0, MATCHSIZE(10), SELF_W, SELF_H - MATCHSIZE(20));
    self.lable.textAlignment = NSTextAlignmentCenter;
    self.lable.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
    self.lable.textColor = TAB_NOTSELECT_TEXTCOLOR;
    [self addSubview:self.lable];
    
    self.lable.layer.cornerRadius = self.lable.frame.size.height/2;
    self.lable.layer.masksToBounds = YES;
    self.isSelectItem = NO;
    
    self.countLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:[UIColor redColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor whiteColor]];
    self.countLabel.frame = CGRectMake(SELF_W - MATCHSIZE(35), 0, MATCHSIZE(35), MATCHSIZE(35));
    self.countLabel.layer.cornerRadius = self.countLabel.frame.size.height/2;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.hidden = YES;
    [self addSubview:self.countLabel];
    
    
}


-(void)setModel:(TabModel *)model{
    _model = model;
    
    self.lable.text = model.title;
    
    if (self.isSelectItem == YES) {
        
        self.lable.textColor = TAB_SELECT_TEXTCOLOR;
        
        self.lable.backgroundColor = TAB_SELECT_BG;
    }
    
    if(model.indentCount != nil){
        if ([model.type isEqualToString:@"2"]) {
            self.countLabel.text = model.indentCount;
            if ([model.indentCount intValue] > 0) {
                self.countLabel.hidden = NO;
            }else{
                self.countLabel.hidden = YES;
            }
        }
    }
    
}

@end
