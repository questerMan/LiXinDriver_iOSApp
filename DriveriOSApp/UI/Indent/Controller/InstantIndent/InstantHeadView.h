//
//  InstantHeadView.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstantHeadView : UIView

/** 出发地IMG */
@property (nonatomic, strong) UIImageView *startIMG;

/** 目的地IMG */
@property (nonatomic, strong) UIImageView *endIMG;

/** 出发地 */
@property (nonatomic, strong) UILabel *startAddress;

/** 目的地 */
@property (nonatomic, strong) UILabel *endAddress;


@end
