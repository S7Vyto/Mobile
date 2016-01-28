//
//  AlertButton.m
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "AlertButton.h"

@interface AlertButton ()

@property (assign) AlertEvent *event;
@property (assign, nonatomic) BOOL touched;

@end

@implementation AlertButton

static NSInteger const cornerRadius = 6;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = cornerRadius;
    }
    return self;
}

- (id)initWith:(AlertEvent *)event frame:(CGRect)rect
{
    self = [self initWithFrame:rect];
    if (self) {
        _event = event;
        _type = DoneButton;
    }
    
    return self;
}

#pragma mark - Drawing button

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = CGRectInset(rect, 2, 2);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius];
    [bezierPath addClip];
    
    [self drawBackgroundGradient:bounds];
    [self drawGlossyGradient:bounds];
    
    CGRect borderRect = CGRectMake(bounds.origin.x + 0.5, bounds.origin.y + 1.0, bounds.size.width - 1.0, bounds.size.height - 0.5);
    UIBezierPath *whiteborder = [UIBezierPath bezierPathWithRoundedRect:borderRect cornerRadius:cornerRadius];
    [[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:0.5] setStroke];
    [whiteborder setLineWidth:0.85];
    [whiteborder stroke];
    
    borderRect = CGRectMake(bounds.origin.x + 0.2, bounds.origin.y + 0.2, bounds.size.width - 0.4, bounds.size.height - 0.5);
    UIBezierPath *blackborder = [UIBezierPath bezierPathWithRoundedRect:borderRect cornerRadius:cornerRadius];
    [[UIColor blackColor] setStroke];
    [blackborder setLineWidth:0.5];
    [blackborder stroke];
    
    if (_event) {
        [[[UIColor whiteColor] colorWithAlphaComponent:.85] setFill];
        
        CGRect titleRect = CGRectMake(bounds.origin.x, bounds.origin.y + 8, bounds.size.width, bounds.size.height - 10);
        
        if (_event.name && ![_event.name isEqualToString:@""]) {
            [_event.name drawInRect:titleRect
                           withFont:[UIFont systemFontOfSize:16]
                      lineBreakMode:NSLineBreakByWordWrapping
                          alignment:NSTextAlignmentCenter];
        }
    }
    
    if (self.touched)
    {
        [[[UIColor blackColor] colorWithAlphaComponent:.45] setFill];
        [bezierPath fill];
    }
}

- (void)drawGlossyGradient:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    size_t count = 2;
    CGGradientRef gradient = nil;
    const CGFloat locations[2] = {0.0, 1.0};
    const CGFloat components[8] = {0.98, 0.98, 0.98, 0.35,
                                   0.98, 0.98, 0.98, 0.025};
    
    if (_type == CancelButton) {
        const CGFloat components[8] = {1.0, 0.0, 0.0, 0.5,
                                       1.0, 0.0, 0.0, 0.025};
        
        gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    }
    else {
        gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    }
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect)), CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

- (void)drawBackgroundGradient:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    size_t count = 2;
    CGGradientRef gradient = nil;
    const CGFloat locations[2] = {.0, 1.0};
    const CGFloat components[8] = {0.98, 0.98, 0.98, 0.35,
                                   0.98, 0.98, 0.98, 0.015};
    
    if (_type == CancelButton) {
        const CGFloat components[8] = {1.0, 0.0, 0.0, 0.35,
                                       1.0, 0.0, 0.0, 0.015};
        
        gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    }
    else {
        gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    }
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect)), CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect)), 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);

}


#pragma mark - Touch events

- (void)setTouched:(BOOL)touched
{
    _touched = touched;
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touched = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touched = NO;
    
    if (_delegate) {
        [_delegate executeAlertEvent:_event];
    }
}

#pragma mark - Dealloc
- (void)dealloc
{
    _event = nil;
    _delegate = nil;
}

@end
