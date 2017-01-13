//
//  UIViewController+SlideMenuControllerOC.h
//  SlideMenuControllerOC
//
//  Created by 陆遗坤 on 16/11/08.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SlideMenuControllerOC)

//设置导航栏item
-(void)setNavigationBarItem;

//移除导航栏Item
-(void)removeNavigationBarItem;

//关闭侧栏跳转
-(void)prensentCloseLeftViewWithViewController:(UIViewController *)newsViewController
                                     andAnimated:(BOOL)animated;

-(void)closeLeftView;
-(void)addLeftGestures;
-(void)removeLeftGestures;

/** 同一改变导航栏状态 */
-(void)changeNavigation;

/** 左侧栏item的模态跳转 (该方法主要是打开状态栏显示) 
 *  selfViewController 当前视图
 *  toViewController 要跳转到的视图
 *  animated 跳转是否要动画:YES有动画
 */
-(void)presentFromViewController:(UIViewController *)selfViewController
             andToViewController:(UIViewController *)toViewController
                     andAnimated:(BOOL)animated;

/** 左侧栏item的模态返回 (该方法主要是关闭状态栏显示) 
 *  selfViewController 当前视图
 *  animated 跳转是否要动画:YES有动画
 */
-(void)dismissFromViewController:(UIViewController *)selfViewController

                     andAnimated:(BOOL)animated;

/** 创建导航栏返回按钮 */
-(void)creatNavigationBackItemBtn;


@end
