//
//  GradientView.m
//  CustomPopover
//
//  Created by Semyon Vyatkin on 19.09.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "GradientView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef color = CGColorSpaceCreateDeviceRGB();
    
    CGFloat location[2] = {.0, 1.0};
    CGFloat colors[8] = {1.0, 1.0, 1.0, 1.0, 0.9, 0.9, 0.9, 1.0};
    
    CGPoint begin = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint end = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(color, colors, location, 2);
    CGContextDrawLinearGradient(context, gradient, begin, end, 0);
    
    CGColorSpaceRelease(color);
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
}


@end
