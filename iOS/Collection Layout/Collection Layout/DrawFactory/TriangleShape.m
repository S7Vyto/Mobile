//
//  TriangleShape.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "TriangleShape.h"

@implementation TriangleShape

- (void)drawRect:(CGRect)rect {
    CGRect shapeRect = CGRectInset(rect, 25, 25);
    CGPoint center = CGPointMake(CGRectGetMidX(shapeRect), CGRectGetMinY(shapeRect));
    CGPoint cornerLeft = CGPointMake(CGRectGetMinX(shapeRect), CGRectGetMaxY(shapeRect));
    CGPoint cornerRight = CGPointMake(CGRectGetMaxX(shapeRect), CGRectGetMaxY(shapeRect));
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:center];
    [bezierPath addLineToPoint:cornerRight];
    [bezierPath addLineToPoint:cornerLeft];
    [bezierPath closePath];
    
    if (super.shapeBorderColor != nil) {
        [super.shapeBorderColor setStroke];
        [bezierPath stroke];
    }
    
    if (super.shapeColor != nil) {
        [super.shapeColor setFill];
        [bezierPath fill];
    }
}

@end
