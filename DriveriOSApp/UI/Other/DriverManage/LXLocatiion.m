//
//  LXLocatiion.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LXLocatiion.h"

@implementation LXLocatiion
- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, cityCode:%@, address:%@, coordinate:%f, %f", self.name, self.cityCode, self.address, self.coordinate.latitude, self.coordinate.longitude];
}
@end
