//
//  FactoryClass.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/3.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "FactoryClass.h"

@implementation FactoryClass

#pragma mark ----------------Label----------------

/** 标签 Label 字色 字号 */
+(UILabel *)labelWithTextColor:(UIColor *)textColor
                      fontSize:(CGFloat)size{
    return [FactoryClass labelWithText:nil fontSize:size textColor:textColor numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
}
/** 标签 Label 字色 加粗字号 */
+(UILabel *)labelWithFrame:(CGRect)frame
                 TextColor:(UIColor *)textColor
              fontBoldSize:(CGFloat)size{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor;
    label.font = [UIFont boldSystemFontOfSize:size];
    return label;

}

/** 标签 Label 文字 字号 */
+(UILabel *)labelWithText:(NSString *)text
                 fontSize:(CGFloat)size{
    return [FactoryClass labelWithText:text fontSize:size textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
}

/** 标签 Label 文字 字号 字色 行数 */
+(UILabel *)labelWithText:(NSString *)text
                 fontSize:(CGFloat)size
                textColor:(UIColor *)textColor
             numberOfLine:(NSInteger)numberOfLine{
    return [FactoryClass labelWithText:text fontSize:size textColor:textColor numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
}

/** 标签 Label 文字 字号 字色 行数 对齐 背景色*/
+(UILabel *)labelWithText:(NSString *)text
                 fontSize:(CGFloat)size
                textColor:(UIColor *)textColor
             numberOfLine:(NSInteger)numberOfLine
            textAlignment:(NSTextAlignment)textAlignment
          backGroundColor:(UIColor *)backGroundColor{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = textColor;
    label.numberOfLines = numberOfLine;
    label.textAlignment = textAlignment;
    label.backgroundColor = backGroundColor;
    return label;
}

#pragma mark ----------------Button----------------


/** 按钮 Button 标题 */
+(UIButton *)buttonWithFrame:(CGRect)frame
                       Title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    return btn;
}

/** 按钮 Button 圆形图片 */
+(UIButton *)buttonWithFrame:(CGRect)frame
                       image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:image forState:UIControlStateNormal];
    btn.layer.cornerRadius = btn.frame.size.width/2;
    btn.layer.masksToBounds = YES;
    return btn;
}



/** 按钮 Button 标题 背景色 字色 */
+(UIButton *)buttonWithFrame:(CGRect)frame
                       Title:(NSString *)title
                  backGround:(UIColor *)backGround
                   tintColor:(UIColor *)tintColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:backGround];
    [btn setTintColor:tintColor];
    return btn;
    
}

/** 按钮 Button 标题 背景色 字色 圆角*/
+(UIButton *)buttonWithFrame:(CGRect)frame
                       Title:(NSString *)title
                  backGround:(UIColor *)backGround
                   tintColor:(UIColor *)tintColor
                cornerRadius:(CGFloat)cornerRadius{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:backGround];
    [btn setTintColor:tintColor];
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.masksToBounds = YES;
    return btn;
}

#pragma mark ----------------UIImageView----------------
/** 图片视图 UIImageView 图片 */
+(UIImageView *)imageViewWithFrame:(CGRect)frame
                             Image:(UIImage *)image{
    UIImageView *imagView = [[UIImageView alloc] initWithFrame:frame];
    imagView.image = image;
    return imagView;
}

/** 图片视图 UIImageView 图片 圆形 */
+(UIImageView *)imageViewWithFrame:(CGRect)frame
                             Image:(UIImage *)image
                                cornerRadius:(CGFloat)cornerRadius{
    UIImageView *imagView = [[UIImageView alloc] initWithFrame:frame];
    imagView.image = image;
    imagView.layer.cornerRadius = cornerRadius;
    imagView.layer.masksToBounds = YES;
    return imagView;
}
#pragma mark ----------------UITextField----------------

+(UITextField *)textFieldWithFrame:(CGRect)frame
                       placeholder:(NSString *)placeholder
                  placeholderColor:(UIColor *)placeholderColor
                         textColor:(UIColor *)textColor
                   backgroundColor:(UIColor *)backgroundColor
                     textAlignment:(NSTextAlignment)textAlignment
                      cornerRadius:(CGFloat)cornerRadius
                         itemImage:(UIImage *)image
                    keyboardType:(UIKeyboardType)keyboardType{
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.placeholder = placeholder;
    [field setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
    field.textAlignment = textAlignment;
    field.textColor = textColor;
    field.backgroundColor = backgroundColor;
    field.layer.cornerRadius = cornerRadius;
    field.layer.masksToBounds = YES;
    field.leftView = [[UIImageView alloc] initWithImage:image];
    field.leftViewMode = UITextFieldViewModeAlways;
    field.clearButtonMode = UITextFieldViewModeAlways;
    field.keyboardType = keyboardType; //数字键

    return field;
}

+(UITextField *)textFieldWithFrame:(CGRect)frame
                       placeholder:(NSString *)placeholder
                  placeholderColor:(UIColor *)placeholderColor
                         textColor:(UIColor *)textColor
                   backgroundColor:(UIColor *)backgroundColor
                     textAlignment:(NSTextAlignment)textAlignment
                      cornerRadius:(CGFloat)cornerRadius
                      keyboardType:(UIKeyboardType)keyboardType{
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.placeholder = placeholder;
    [field setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
    field.textAlignment = textAlignment;
    field.textColor = textColor;
    field.backgroundColor = backgroundColor;
    field.layer.cornerRadius = cornerRadius;
    field.layer.masksToBounds = YES;
    field.leftViewMode = UITextFieldViewModeAlways;
    field.keyboardType = keyboardType; //数字键
    field.layer.borderWidth = MATCHSIZE(2);
    return field;
}


@end
