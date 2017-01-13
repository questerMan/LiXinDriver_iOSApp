//
//  LXRequest.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXLocatiion.h"

@interface LXRequest : NSObject

@property (nonatomic, strong) LXLocatiion * start;

@property (nonatomic, strong) LXLocatiion * end;

@property (nonatomic, strong) NSString * info;

+ (instancetype)requestFrom:(LXLocatiion *)start to:(LXLocatiion *)end;

- (id)initWithStart:(LXLocatiion *)start to:(LXLocatiion *)end;

@end
