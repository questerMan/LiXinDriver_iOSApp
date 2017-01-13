//
//  ReservationCell.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationCell : UITableViewCell

/** 头像图标 */
@property (nonatomic, strong) UIImageView *headIMG;
/** 名字 */
@property (nonatomic, strong) UILabel *name;
/** 电话 */
@property (nonatomic, strong) UILabel *number;
/** 上车图标 */
@property (nonatomic, strong) UIImageView *tCarIMG;
/** 下车图标 */
@property (nonatomic, strong) UIImageView *bCarIMG;
/** 预约时间图标 */
@property (nonatomic, strong) UIImageView *timeIMG;
/** 上车点 */
@property (nonatomic, strong) UILabel *tCarLab;
/** 下车点 */
@property (nonatomic, strong) UILabel *bCarLab;
/** 预约时间 */
@property (nonatomic, strong) UILabel *timeLab;
/** 上车点文本 */
@property (nonatomic, strong) UILabel *tCarText;
/** 下车点文本 */
@property (nonatomic, strong) UILabel *bCarText;
/** 预约时间文本 */
@property (nonatomic, strong) UILabel *timeText;
/** 打电话按钮 */
@property (nonatomic, strong) UIButton *callBtn;
/** 订单状态标签 */
@property (nonatomic, strong) UILabel *satus;


@end
