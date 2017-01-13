//
//  LYKLeftMainHeadView.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/27.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMainHeadView : UITableViewCell
/** 用户头像 */
@property (nonatomic, strong) UIImageView *userIMG;
/** 用户手机号 */
@property (nonatomic, strong) UILabel *userNumber;
/** 用户星级 */
@property (nonatomic, strong) StarsView *userStars;

@end
