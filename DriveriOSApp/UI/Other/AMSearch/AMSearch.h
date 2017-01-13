//
//  AMSearch.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/1.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ AMSearchBlock) (AMLocationModel *model);
@interface AMSearch : UIViewController

@property (nonatomic, copy) AMSearchBlock block;
/** 搜索结果回调 */
-(void)getSearchResultWithAMSearchBlock:(AMSearchBlock)block;

@end
