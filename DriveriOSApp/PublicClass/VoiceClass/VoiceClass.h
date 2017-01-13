//
//  VoiceClass.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/9.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceClass : NSObject

/**
 *  工具单例类
 *
 *  @return 返回一个工具对象🔧
 */
+ (VoiceClass *)shareInstance;

/**
 *    语音播报信息
 *    @pram soundString 播报的文字
 *    @pram speechRate  播报语速：设置语速，范围0-1，注意0最慢，1最快；
 *    @pram language    播报用的语言
 */
-(void)speechWithSoundString:(NSString *)soundString
               AndSpeechRate:(CGFloat)speechRate
                 AndLanguage:(NSString *)language;

/** 暂停播报 */
-(void)pauseSpeech;

/** 停止播报 */
-(void)stopSpeech;

@end
