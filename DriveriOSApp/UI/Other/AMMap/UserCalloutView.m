//
//  UserCalloutView.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/4.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "UserCalloutView.h"
#define kArrorHeight    10

@implementation UserCalloutView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self creatUI];
    }
    return self;
}


-(void)creatUI{
    self.timeBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(0), MATCHSIZE(80), MATCHSIZE(80)) Title:@"2" backGround:[UIColor clearColor] tintColor:[UIColor greenColor] cornerRadius:MATCHSIZE(40)];
    [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"timeAnno"] forState:UIControlStateNormal];
    
    [self addSubview:self.timeBtn];
    
    self.titleLable = [FactoryClass labelWithFrame:CGRectMake(MATCHSIZE(80), MATCHSIZE(10), MATCHSIZE(180), MATCHSIZE(60)) TextColor:[UIColor whiteColor] fontBoldSize:MATCHSIZE(30)];
    self.titleLable.text = @"";
    [self addSubview:self.titleLable];
    
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
