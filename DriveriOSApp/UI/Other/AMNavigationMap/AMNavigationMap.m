//
//  AMNavigationMap.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/5.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AMNavigationMap.h"

@interface AMNavigationMap ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate>

@property (nonatomic, strong) AMapNaviDriveManager *driveManager;
@property (nonatomic, strong) AMapNaviDriveView *driveView;

@property (nonatomic, strong) VoiceClass *voiceSpeech;

@end

@implementation AMNavigationMap

-(VoiceClass *)voiceSpeech{
    if (!_voiceSpeech) {
        _voiceSpeech = [VoiceClass shareInstance];
    }
    return _voiceSpeech;
}

-(AMapNaviDriveManager *)driveManager{
    if (!_driveManager) {
        _driveManager = [[AMapNaviDriveManager alloc] init];
        [_driveManager setDelegate:self];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
            _driveManager.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
        }        
    }
    return _driveManager;
}

-(AMapNaviDriveView *)driveView{
    if (!_driveView) {
        _driveView = [[AMapNaviDriveView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_driveView setDelegate:self];

    }
    return _driveView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //路径规划
    [self reloadDriveRoute];
}

//获取路径规划
-(void)reloadDriveRoute{
   
    
    if(self.startLocatoin != nil && self.destinationPoint != nil){
    
        BOOL isSuccess = [self.driveManager calculateDriveRouteWithStartPoints:@[self.startLocatoin] endPoints:@[self.destinationPoint] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleDefault];
        
        if (isSuccess) {
            NSLog(@"导航路线规划成功");
        }
        
        [self.driveManager setBroadcastMode:AMapNaviBroadcastModeConcise];
    }
    
}

//路径规划成功后，开始模拟导航
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    //[self.driveManager startEmulatorNavi];//模拟导航
    
    //算路成功后开始GPS导航
    [self.driveManager startGPSNavi];
    
}
/**
 *  导航到达目的地后的回调函数
 */
- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager{
    
}

/**
 *  启动导航后回调函数
 *
 *  @param naviMode 导航类型，参考AMapNaviMode
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode{
    
}

/**
 *  导航播报信息回调函数
 *
 *  @param soundString 播报文字
 *  @param soundStringType 播报类型,参考AMapNaviSoundType
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType{

    //语音播报
    [self.voiceSpeech speechWithSoundString:soundString AndSpeechRate:0.5 AndLanguage:@"zh-CN"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化 AMapNaviDriveManager 和 AMapNaviDriveView
    [self initDriveNAC];

}


-(void)initDriveNAC{
    
    //将AMapNaviManager与AMapNaviDriveView关联起来
    [self.driveManager addDataRepresentative:self.driveView];
    //将AManNaviDriveView显示出来
    [self.view addSubview:self.driveView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.voiceSpeech stopSpeech];//停止播报
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
