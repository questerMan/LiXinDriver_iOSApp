//
//  PublicTool.h
//  LiXinDriverTest
//
//  Created by lixin on 16/11/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


//通知
typedef void (^NotificationBlock)(NSNotification *notify);

//打开相机／图片代码块
typedef void (^PicBlock) (UIImage *image);

@interface PublicTool : NSObject


/**
 *  工具单例类
 *
 *  @return 返回一个工具对象🔧
 */
+ (PublicTool *)shareInstance;

/**
 *  获取当前version号，并转化成int类型, 例:@111
 *
 *  @return version号
 */
+(int) getVersionNum;

/** 计算字符串长度*/
+(CGFloat)lengthofStr:(NSString *)str AndSystemFontOfSize:(CGFloat) fontSize;

/** 计算字符串高度*/
+(CGFloat)heightOfStr:(NSString *)str andTextWidth:(CGFloat)width andFont:(UIFont *)font;

/**
 *	@brief	传入电话号码，拨打电话
 *
 */
+ (void)callPhoneWithPhoneNum:(NSString *)phoneNumberStr;

/**
 *	@brief	获取UUID
 */
-(NSString*) uuid;

/**
 *	@brief	获取时间戳
 */
-(NSString *) getTime;


/**
 *	@brief	绘制圆形图片
 */
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

/**
 *	@brief	压缩图片到指定尺寸大小
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
/**
 *	@brief	颜色转图片
 */
+(UIImage*) createImageWithColor:(UIColor*) color;

/**
 *  是否第一次打开app 0 = 首次，1 ＝ 不是首次
 *
 *  @return 1第一
 */
+ (int)isFirstOpenApp;


/**
 *  正则判断手机号码地址格式
 *
 *  @return  Yes正确✅
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  手号做星号处理
 *
 *  @return  处理过的手机号 188*＊＊＊6403
 */
+(NSString *)setStartOfMumber:(NSString *)mumber;

/**
 *  检测网络状态(返回YES为可用网络)
 *
 *  @ param 基于AFNetWokring检测
 *
 *  @return 返回YES为可用网络
 */
+ (BOOL)testNetworkIsConnected;


/**
 *  检测网络状态(返回YES为wifi环境)
 *
 *  @ param 基于AFNetWokring检测
 *
 *  @return 返回YES为wifi环境
 */
+ (BOOL)testNetworkIsWifi;

/**
 *  发送通知
 *
 *  @param nameStr        通知名
 *  @param userInfoObject 附带参数
 */
+ (void)postNotificationWithName:(NSString *)nameStr object:(id)userInfoObject;

//通知
@property (nonatomic,copy) NotificationBlock userInfoObjectBlock;

/**
 *  接收通知
 *
 *  @param nameStr        通知名
 *  @param userInfoObjectBlock 收到通知执行的方法
 */
- (void)getNotificationWithName:(NSString *)nameStr object:(NotificationBlock)userInfoObjectBlock;

/**
 *  字符转换F8
 *
 *  @param str 需转换的字符串
 *
 *  @return 转换后的字符串
 */
+ (NSString *)UTF8String:(NSString *)str;


//相机／图片
@property (nonatomic, copy) PicBlock picBlock;
/**
 *  　创建获取图片方法
 *
 *  @param selfViewCOntroller 要获取图片的页面
 *
 *  @param picBlock 执行方法(带UIImage图片)
 */
-(void)putAlertViewWithViewController:(UIViewController *)selfViewCOntroller
                          andPicBlock:(PicBlock)picBlock;

/**
 *    获取当前时间
 *   
 */
+(NSString *)getCurrentTime;

@end
