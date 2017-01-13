//
//  PhoneAlert.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/13.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneAlertDelegate <NSObject>

@optional
/** 关闭alertView */
-(void)closeAlertView;
@end

typedef void (^ PhoneAlertBlock) (int lenght);

@interface PhoneAlert : UIViewController

typedef enum {
    State_PhoneNumber,
    State_sendCode,
    State_confirmCode,
    State_remind
}PhoneAlertState;

@property (nonatomic, weak) id<PhoneAlertDelegate> delegate;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 内容 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 取消 */
@property (nonatomic, strong) UIButton *cancleBtn;
/** 好 */
@property (nonatomic, strong) UIButton *okBtn;
/** 文本框 */
@property (nonatomic, strong) UITextField *codeField;
/** 倒计时按钮 */
@property (nonatomic, strong) UIButton *timeBtn;
/** 完成 */
@property (nonatomic, strong) UIButton *confirmCodeBtn;
//下拉列表框
@property (nonatomic, copy) PhoneAlertBlock block;

-(void)showInsetAlertViewHeightWithBlock:(PhoneAlertBlock)block;

@end
