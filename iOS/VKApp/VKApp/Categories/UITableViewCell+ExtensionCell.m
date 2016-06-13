//
//  UITableViewCell+ExtensionCell.m
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "UITableViewCell+ExtensionCell.h"
#import "ThemeService.h"

@implementation UITableViewCell (ExtensionCell)

- (void)setupAppearance {
    [self setupBackgroundView];
    [self setupSelectionView];
}

- (void)setupSelectionView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupBackgroundView {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
}

- (void)drawRect:(CGRect)rect {
    CGRect insetRect = CGRectInset(rect, 10.0, 5.0);
    [self drawGradientInRect:insetRect
                 withContext:UIGraphicsGetCurrentContext()];
}

- (void)drawGradientInRect:(CGRect)rect withContext:(CGContextRef)context {
    CGFloat colors[] = {
        35.0/255.0, 45.0/255.0, 62.0/255.0, 1.0,
        35.0/255.0, 45.0/255.0, 62.0/255.0, 1.0
    };
    
    CGFloat locations[] = {
        0.0,
        1.0
    };
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                          cornerRadius:4.0];
    
    CGContextSaveGState(context);
    [bezierPath fill];
    [bezierPath addClip];
    
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(spaceRef, colors, locations, 2);
    CGColorSpaceRelease(spaceRef);
    spaceRef = NULL;
    
    CGPoint startPoint = CGPointMake(0, CGRectGetMaxY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
    
    CGGradientRelease(gradientRef);
    gradientRef = NULL;
    
    CGContextRestoreGState(context);
}

@end
