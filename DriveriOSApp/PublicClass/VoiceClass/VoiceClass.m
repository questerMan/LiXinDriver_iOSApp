//
//  VoiceClass.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/9.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "VoiceClass.h"

@interface VoiceClass()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *avSpeech;

@end

@implementation VoiceClass

-(AVSpeechSynthesizer *)avSpeech{
    if (!_avSpeech) {
        _avSpeech = [[AVSpeechSynthesizer alloc]init];
        _avSpeech.delegate=self;//挂上代理
    }
    
    return _avSpeech;
}

/** 单例 */
+ (VoiceClass *)shareInstance{
    
    static dispatch_once_t onceToken;
    static VoiceClass * voice = nil;
    dispatch_once(&onceToken, ^{
        voice = [[VoiceClass alloc]init];
        
    });
    return voice;
}


#pragma mark - 语音播报信息
-(void)speechWithSoundString:(NSString *)soundString
                    AndSpeechRate:(CGFloat)speechRate
                      AndLanguage:(NSString *)language
{
    [self stopSpeech];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:soundString];//需要转换成语音的文字
    
    utterance.rate=speechRate;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
    
    AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:language];//设置发音，这是中文普通话zh-CN
    
    utterance.voice= voice;
    
    [self.avSpeech speakUtterance:utterance];//开始
}
#pragma mark - 暂停播报
-(void)pauseSpeech{
    [self.avSpeech pauseSpeakingAtBoundary:AVSpeechBoundaryWord];//暂停
}
#pragma mark - 停止播报
-(void)stopSpeech{
    [self.avSpeech stopSpeakingAtBoundary:AVSpeechBoundaryWord];
}



- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---开始播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---完成播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放中止");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---恢复播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放取消");
    
}

@end
