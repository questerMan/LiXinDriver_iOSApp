//
//  LimitDataClass.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/26.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

/**
 *  本地公共缓存常量数据
 */
#ifndef LimitDataClass_h
#define LimitDataClass_h
/*  用户类型 */
static NSString *userType = @"";//专车司机
/*  随机验证码显示限制 */
static NSInteger codeLimit_Count = 3;//3次
/*  地图默认状态 */
static NSString *mapState_Default = @"";//等单
/*  等待接单时长 */
static NSTimeInterval acceptIndent_Time = 15;//15s
/*  下拉显示框显示时长 */
static NSTimeInterval dropdownBox_Time = 5;//5s
/*  等待抢单时长 */
static NSTimeInterval robIndent_Time = 15;//15s
/*  等待录入短信验证码时长 */
static NSTimeInterval code_Time = 15;//15s
/*  拒改单相片大小限制 */
                    //500k


/*  拒改单相片文件本地存放目录 */
static NSString *pic_Patch = @"/UserFiles/Images/";//图片路径
/*  获取定位间隔时长 */
static NSTimeInterval getLocation_Time = 60*10;//60s
/*  订单间隔时长 */
static NSTimeInterval indentInterval_Time = 3*60*60;//3小时
/*  本地保存文件路径 */
static NSString *file_Patch = @"files";//文件路径
/*  本地保存文件名字符串类型 */
static NSString *string_Type = @"z";
/*  本地保存文件名字字符串长度 */
static NSInteger fileName_lenght = 32;//字符串长度
/*  记录变化最短距离 */
static CGFloat recordChanges_minDistance = 10.0;//10米
/*  记录变化最小角度 */
           //20度


/*  紧急救援取消时限 */
static NSTimeInterval emergency_Time = 10;//10s



#endif /* LimitDataClass_h */
