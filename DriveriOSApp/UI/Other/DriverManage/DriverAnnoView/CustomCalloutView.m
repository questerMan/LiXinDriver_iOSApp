//
//  CustomCalloutView.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/21.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "CustomCalloutView.h"

#define kArrorHeight    10

@implementation CustomCalloutView

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
    
    self.headIMG = [FactoryClass imageViewWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(10), MATCHSIZE(60), MATCHSIZE(60)) Image:[UIImage imageNamed:@"usersIMG"] cornerRadius:MATCHSIZE(30)];
    [self addSubview:self.headIMG];
    
    self.carIDLab = [FactoryClass labelWithFrame:CGRectMake(MATCHSIZE(80), MATCHSIZE(10), MATCHSIZE(180), MATCHSIZE(60)) TextColor:[UIColor whiteColor] fontBoldSize:MATCHSIZE(30)];
    self.carIDLab.text = @"粤 A168";
    [self addSubview:self.carIDLab];
    
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
