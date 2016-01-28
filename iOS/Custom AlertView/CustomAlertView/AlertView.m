//
//  AlertView.m
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "AlertView.h"
#import "AlertEvent.h"
#import "AlertConstant.h"

@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.title = @"";
        self.message = @"";
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Drawing view
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    NSInteger corner_radius = 10;
    NSInteger inset = 5;
    
    NSInteger x = bounds.origin.x + inset;
    NSInteger y = bounds.origin.y + inset;
    CGFloat width = bounds.size.width - 2 * inset;
    CGFloat height = bounds.size.height - 2 * inset;
    
    CGSize titleSize = CGSizeZero;
    CGRect titleRect = CGRectZero;
    
    if (_title && ![_title isEqualToString:@""]) {
        titleSize = [_title sizeWithFont:[UIFont systemFontOfSize:18]
                       constrainedToSize:CGSizeMake(bounds.size.width, bounds.size.height)
                           lineBreakMode:NSLineBreakByWordWrapping];
        
        titleRect = CGRectMake(20, 20, bounds.size.width - 40, titleSize.height);
        [_title drawInRect:titleRect
                  withFont:[UIFont boldSystemFontOfSize:16]
             lineBreakMode:NSLineBreakByWordWrapping
                 alignment:NSTextAlignmentCenter];
    }
    
    CGSize messageSize = CGSizeZero;
    CGRect messageRect = CGRectZero;
    
    if (_message && ![_message isEqualToString:@""]) {
        messageSize = [_message sizeWithFont:[UIFont systemFontOfSize:16]
                           constrainedToSize:CGSizeMake(bounds.size.width, bounds.size.height)
                               lineBreakMode:NSLineBreakByWordWrapping];
        
        messageRect = CGRectMake(20, titleRect.origin.y + titleRect.size.height + 5, bounds.size.width - 40, messageSize.height);
    }
    
    CGRect bezierRect = CGRectMake(x, y, width, height);
    CGPathRef bezierPath = [UIBezierPath bezierPathWithRoundedRect:bezierRect cornerRadius:corner_radius].CGPath;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, bezierPath);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(1.0, 1.0), 6.0, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, bezierPath);
    CGContextClip(context);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t count = 2;
    CGFloat locations[3] = {0.0, 1.0};
    CGFloat components[8] =
    {
        11.0/255.0, 19.0/255.0, 52.0/255.0, 1.0,
        11.0/255.0, 19.0/255.0, 52.0/255.0, 1.0
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(bounds), CGRectGetMinY(bounds));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(bounds), CGRectGetMaxY(bounds));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, .0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    CGContextSaveGState(context);
    CGFloat glossRadius = 950;
    CGPoint glossCenterPoint = CGPointMake(CGRectGetMidX(bezierRect), 40.0 - glossRadius);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, glossCenterPoint.x, glossCenterPoint.y);
    CGContextAddArc(context, glossCenterPoint.x, glossCenterPoint.y, glossRadius, 0.0, M_PI, 0
                    );
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGFloat locations2[2] = {0.0, 1.0};
    CGFloat components2[8] = {1.0, 1.0, 1.0, 0.35, 1.0, 1.0, 1.0, 0.1};
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGGradientRef glossGradient = CGGradientCreateWithColorComponents(colorSpace2, components2, locations2, 2);
    CGPoint topCenter = CGPointMake(CGRectGetMidX(bezierRect), 0.0);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(bezierRect), 40.0);
    CGContextDrawLinearGradient(context, glossGradient, topCenter, midCenter, 0);
    CGColorSpaceRelease(colorSpace2);
    CGGradientRelease(glossGradient);
    CGContextRestoreGState(context);
    
    if (!CGRectEqualToRect(messageRect, CGRectZero)) {
        NSInteger buttonOffset = messageRect.origin.y + messageSize.height + 10;
        
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGFloat linePathY = (buttonOffset - 0.5);
        CGPathMoveToPoint(linePath, NULL, 0.0, linePathY);
        CGPathAddLineToPoint(linePath, NULL, bounds.size.width, linePathY);
        CGContextAddPath(context, linePath);
        CGPathRelease(linePath);
        CGContextSetLineWidth(context, 1.0);
        CGContextSaveGState(context);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.6].CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 0.0, [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2].CGColor);
        CGContextDrawPath(context, kCGPathStroke);
        CGContextRestoreGState(context);
    }
    
    CGContextAddPath(context, bezierPath);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 6.0, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);
    CGContextAddPath(context, bezierPath);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 0.0, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.1].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    [[UIColor colorWithWhite:1.0 alpha:1.0] setFill];
    if (_title && ![_title isEqualToString:@""]) {
        [_title drawInRect:titleRect
                  withFont:[UIFont boldSystemFontOfSize:16]
             lineBreakMode:NSLineBreakByWordWrapping
                 alignment:NSTextAlignmentCenter];
    }
    
    if (_message && ![_message isEqualToString:@""]) {
        [_message drawInRect:messageRect
                    withFont:[UIFont systemFontOfSize:14]
               lineBreakMode:NSLineBreakByWordWrapping
                   alignment:NSTextAlignmentCenter];
    }
}

#pragma mark - Drawing gradient
- (UIImage *)radialGradientImage:(CGSize)size start:(float)start end:(float)end centre:(CGPoint)centre radius:(float)radius
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    
    size_t count = 2;
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {start, start, start, .0, end, end, end, 1};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad = CGGradientCreateWithColorComponents (colorSpace, components, locations, count);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(), grad, centre, 0, centre, radius, kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(grad);
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)addGradient
{
    CGSize size = self.bounds.size;
    CGPoint centre = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    float startColor = 1;
    float endColor = 0;
    float radius = MIN(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    UIImageView *gradient = [[UIImageView alloc] initWithImage:[self radialGradientImage:size
                                                                                   start:startColor
                                                                                     end:endColor
                                                                                  centre:centre
                                                                                  radius:radius]];
    
    [gradient setBackgroundColor:[UIColor clearColor]];
    [gradient setUserInteractionEnabled:YES];
    [gradient setAlpha:.25];
    
    [self addSubview:gradient];
    
}

#pragma mark - Dealloc
- (void)dealloc
{
    _title = nil;
    _message = nil;
}

@end
