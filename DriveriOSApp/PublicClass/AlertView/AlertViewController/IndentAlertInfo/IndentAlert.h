//
//  IndentAlert.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/14.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndentAlertDelegate <NSObject>

@optional
/** 关闭alertView */
-(void)closeAlertView;
@end
@interface IndentAlert : UIViewController

@property (nonatomic, weak) id <IndentAlertDelegate> delegate;

@end
