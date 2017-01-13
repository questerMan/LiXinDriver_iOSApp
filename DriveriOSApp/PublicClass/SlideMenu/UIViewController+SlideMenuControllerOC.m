//
//  UIViewController+SlideMenuControllerOC.m
//  SlideMenuControllerOC
//
//  Created by 陆遗坤 on 16/11/08.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "UIViewController+SlideMenuControllerOC.h"


@implementation UIViewController (SlideMenuControllerOC)

-(void)setNavigationBarItem {
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"ic_menu_black_24dp"]];

    //[self.slideMenuController removeLeftGestures];
    [self.slideMenuController removeRightGestures];
//    [self.slideMenuController addLeftGestures];
//    [self.slideMenuController addRightGestures];
    
}

-(void)removeNavigationBarItem {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    [self.slideMenuController removeLeftGestures];
    [self.slideMenuController removeRightGestures];
}

-(void)prensentCloseLeftViewWithViewController:(UIViewController *)newsViewController
                                   andAnimated:(BOOL)animated
{
    [self closeLeft];
    [self presentViewController:newsViewController animated:animated completion:nil];
}

-(void)closeLeftView{
    [self closeLeft];

}
-(void)addLeftGestures{
    
    [self.slideMenuController addLeftGestures];

}
-(void)removeLeftGestures{
    
    [self.slideMenuController removeLeftGestures];

}

#pragma mark - 同一改变导航栏状态
-(void)changeNavigation{
    
    self.navigationController.navigationBarHidden = NO;
    
    //不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    //显示的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}
#pragma mark - 左侧栏item的模态跳转
-(void)presentFromViewController:(UIViewController *)selfViewController
             andToViewController:(UIViewController *)toViewController
                     andAnimated:(BOOL)animated{
    
    [selfViewController presentViewController:toViewController animated:animated completion:^{
        //显示状态栏
        [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelNormal;
    }];
}
#pragma mark - 左侧栏item的模态返回
-(void)dismissFromViewController:(UIViewController *)selfViewController
                        andAnimated:(BOOL)animated{
    //隐藏状态栏
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelStatusBar;
    
    [selfViewController dismissViewControllerAnimated:animated completion:nil];
    
}

#pragma mark - 创建导航栏返回按钮
-(void)creatNavigationBackItemBtn{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backOnclick:)];

}
-(void)backOnclick:(UIBarButtonItem *)itemBtn{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
