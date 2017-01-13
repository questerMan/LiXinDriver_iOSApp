//
//  FactoryClass.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/3.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FactoryClass : NSObject

#pragma mark ----------------Label----------------

/** 标签 Label 字色 字号 */
+(UILabel *)labelWithTextColor:(UIColor *)textColor
                      fontSize:(CGFloat)size;

/** 标签 Label 字色 加粗字号 */
+(UILabel *)labelWithFrame:(CGRect)frame
                 TextColor:(UIColor *)textColor
              fontBoldSize:(CGFloat)size;


/** 标签 Label 文字 字号 */
+(UILabel *)labelWithText:(NSString *)text
                      fontSize:(CGFloat)size;

/** 标签 Label 文字 字号 字色 行数 */
+(UILabel *)labelWithText:(NSString *)text
                      fontSize:(CGFloat)size
                textColor:(UIColor *)textColor
             numberOfLine:(NSInteger)numberOfLine;

/** 标签 Label 文字 字号 字色 行数 对齐 背景色*/
+(UILabel *)labelWithText:(NSString *)text
                 fontSize:(CGFloat)size
                textColor:(UIColor *)textColor
             numberOfLine:(NSInteger)numberOfLine
            textAlignment:(NSTextAlignment)textAlignment
          backGroundColor:(UIColor *)backGroundColor;

#pragma mark ----------------Button----------------


/** 按钮 Button 标题 */
+(UIButton *)buttonWithFrame:(CGRect)frame
                       Title:(NSString *)title;

/** 按钮 Button 圆形图片 */
+(UIButton *)buttonWithFrame:(CGRect)frame
                       image:(UIImage *)image;


/** 按钮 Button 标题 背景色 字色 */
+(UIButton *)buttonWithFrame:(CGRect)frame
                       Title:(NSString *)title
                  backGround:(UIColor *)backGround
                   tintColor:(UIColor *)tintColor;


/** 按钮 Button 标题 背景色 字色 圆角*/
+(UIButton *)buttonWithFrame:(CGRect)frame
                       Title:(NSString *)title
                  backGround:(UIColor *)backGround
                   tintColor:(UIColor *)tintColor
                cornerRadius:(CGFloat)cornerRadius;

#pragma mark ----------------UIImageView----------------
/** 图片视图 UIImageView 图片 */
+(UIImageView *)imageViewWithFrame:(CGRect)frame
                             Image:(UIImage *)image;

/** 图片视图 UIImageView 图片 圆形 */
+(UIImageView *)imageViewWithFrame:(CGRect)frame
                             Image:(UIImage *)image
                                cornerRadius:(CGFloat)cornerRadius;

#pragma mark ----------------UITextField----------------

/** 文本输入框 UITextField 左边带图标*/
+(UITextField *)textFieldWithFrame:(CGRect)frame
                       placeholder:(NSString *)placeholder
                  placeholderColor:(UIColor *)placeholderColor
                         textColor:(UIColor *)textColor
                   backgroundColor:(UIColor *)backgroundColor
                     textAlignment:(NSTextAlignment)textAlignment
                      cornerRadius:(CGFloat)cornerRadius
                         itemImage:(UIImage *)image
                      keyboardType:(UIKeyboardType)keyboardType;


/** 文本输入框 UITextField 不带图标，无删除btn */
+(UITextField *)textFieldWithFrame:(CGRect)frame
                       placeholder:(NSString *)placeholder
                  placeholderColor:(UIColor *)placeholderColor
                         textColor:(UIColor *)textColor
                   backgroundColor:(UIColor *)backgroundColor
                     textAlignment:(NSTextAlignment)textAlignment
                      cornerRadius:(CGFloat)cornerRadius
                      keyboardType:(UIKeyboardType)keyboardType;

@end
