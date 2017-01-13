//
//  LXRequest.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LXRequest.h"

@implementation LXRequest

+ (instancetype)requestFrom:(LXLocatiion *)start to:(LXLocatiion *)end
{
    return [[self alloc] initWithStart:start to:end];
}

- (id)initWithStart:(LXLocatiion *)start to:(LXLocatiion *)end
{
    if (self = [super init])
    {
        self.start = start;
        self.end = end;
    }
    
    return self;
}

@end
