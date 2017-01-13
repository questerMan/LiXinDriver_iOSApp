//
//  AppDelegate.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/26.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //测试：保存当前登陆的手机号
    [CacheClass cacheFromYYCacheWithValue:@"18898326403" AndKey:PhoneNumber_KEY];
    
    [AMapServices sharedServices].apiKey = AMMAP_KEY;

    [self initEM];

    [self initWindow];

    [self.window addSubview:[[Login alloc] init].view];
    
    return YES;
}

/** 初始化window */
-(void)initWindow{
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:GROUND_ID conversationType:EMConversationTypeGroupChat];
    
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:chatController];
    
    LeftMenuMain *leftViewController = [[LeftMenuMain alloc] init];
    
    SlideMenuController *slideMenuController = [[SlideMenuController alloc] initWithMainViewController:nac leftMenuViewController:leftViewController];
    
    slideMenuController.automaticallyAdjustsScrollViewInsets = YES;
    
    [slideMenuController changeLeftViewWidth:MATCHSIZE(550)];//左侧栏显示宽度的大小
    
    slideMenuController.delegate = chatController;
    
    self.window.rootViewController = slideMenuController;
    
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// 环信
-(void)initEM{
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:EM_KEY];
//    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
