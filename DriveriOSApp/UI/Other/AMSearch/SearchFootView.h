//
//  SearchFootView.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SearchFootViewBlock) (void);

@interface SearchFootView : UITableViewCell

@property (nonatomic, copy) SearchFootViewBlock block;

-(void)clearAllHistoryDataWithBlock:(SearchFootViewBlock)searchFootBlock;

@end
