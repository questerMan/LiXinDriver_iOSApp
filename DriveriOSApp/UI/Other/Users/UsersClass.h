//
//  UsersClass.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersClass : NSObject
/**
 *  用户单例类
 *
 *  @return 返回一个用户对象
 */
+ (UsersClass *)userInfoShareInstance;

/** 账号登录次数 */
@property (nonatomic, copy) NSString *loginError;

/** 手机号码 */
@property (nonatomic, copy) NSString *iphoneNumber;

/** 用户ID */
@property (nonatomic, copy) NSString *usersID;

/** 在线状态: 上线或者离线*/
@property (nonatomic, copy) NSString *lineState;

/** 当前订单ID:  地图等单页0  聊天页－1  默认－1*/
@property (nonatomic, copy) NSString *currentID;

/** 初始化状态: 未完成0 已完成为1*/
@property (nonatomic, copy) NSString *initializeState;

/** 受处罚:状态数组 －－> 描述  时长 */
@property (nonatomic, copy) NSArray *punish;

/** 头像图片地址 */
@property (nonatomic, copy) NSString *imagePath;

/** 用户名 */
@property (nonatomic, copy) NSString *usersName;

/** 评价等级 */
@property (nonatomic, copy) NSString *commentGrade;

/** 车辆品牌 */
@property (nonatomic, copy) NSString *carsBrand;

/** 车辆型号 */
@property (nonatomic, copy) NSString *carsNumber;

/** 车辆登记ID */
@property (nonatomic, copy) NSString *carsRegisterID;

/** 省份 */
@property (nonatomic, copy) NSString *province;

/** 城市 */
@property (nonatomic, copy) NSString *citycode;

/** 区 */
@property (nonatomic, copy) NSString *district;

/** 街道 */
@property (nonatomic, copy) NSString *town;

/** 位置（特殊名称） */
@property (nonatomic, copy) NSString *address;

/** 经度 */
@property (nonatomic, copy) NSString *latitude;

/** 纬度 */
@property (nonatomic, copy) NSString *longitude;

/** 方向 */
@property (nonatomic, copy) NSString *direction;

/** 海拔 */
@property (nonatomic, copy) NSString *altitude;

/** 时间 */
@property (nonatomic, copy) NSString *time;

@end
