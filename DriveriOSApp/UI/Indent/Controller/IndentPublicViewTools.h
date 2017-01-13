//
//  IndentPublicViewTools.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

/**
 *tab点击对应相应的类型，比如：0 表示 等单
 *                        1 表示 即时单
 *                        2 表示 预约单
 *                        3 表示 接机
 *                        4 表示 送机
 *                        5 表示 抢单
 */

#import <UIKit/UIKit.h>

//搜索
typedef void (^IndentPublicViewToolsPusToSearchBlock) (void);
//导航
typedef void (^IndentPublicViewToolsPusToNavigationMapBlock) (void);
// 移除驾车的路线
typedef void (^IndentPublicViewToolsPusOfClearRouteBlock) (void);

@interface IndentPublicViewTools : UIView

/**
 *  工具单例类
 *
 *  @return 返回一个工具对象🔧
 */
+ (IndentPublicViewTools *)shareInstance;

/** 等单 */
//搜索
@property (nonatomic, strong) UITextField *seachTextF;
//开始导航
@property (nonatomic, strong) UIButton *startNavigation;
@property (nonatomic, strong) UIButton *cancelBtn;

/** 即时单 */
@property (nonatomic, strong) InstantHeadView *instantHeadView;
@property (nonatomic, strong) UIButton *acceptIndentBtn;
/** 预约单 */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;
/** 接送机 */

/** 抢单 */

@property (nonatomic, copy) IndentPublicViewToolsPusToSearchBlock searchBlock;

@property (nonatomic, copy) IndentPublicViewToolsPusToNavigationMapBlock navigationMapBlock;

@property (nonatomic, copy) IndentPublicViewToolsPusOfClearRouteBlock clearRouteBlock;

/** 跳到搜索栏 */
-(void)pusToSearchWithSearchBlock:(IndentPublicViewToolsPusToSearchBlock) searchBlock;
/** 跳到导航页 */
-(void)pusToNavigationMapWithNavigationMapBlock:(IndentPublicViewToolsPusToNavigationMapBlock) navigationMapBlock;
/** 取消驾车路线 */
-(void)clearRouteWithBlock:(IndentPublicViewToolsPusOfClearRouteBlock) clearRouteBlock;

/** tab显示相应的View */
-(void)implementAllMethodWithIndent:(int)type andIndent:(UIViewController *)indent;

@end


