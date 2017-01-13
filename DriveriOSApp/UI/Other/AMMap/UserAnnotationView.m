//
//  UserAnnotationView.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/4.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "UserAnnotationView.h"

@implementation UserAnnotationView


#define kCalloutWidth   MATCHSIZE(280)
#define kCalloutHeight  MATCHSIZE(100)


- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}



- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override



- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            /* Construct custom callout. */
            self.calloutView = [[UserCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
            if (_block) {
                self.calloutView.titleLable.text = @"正在获取...";
                _block(self.calloutView.titleLable);
            }
            
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

-(void)getDataWithBlock:(UserAnnotationViewBlock)block{
    _block = block;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}



@end
