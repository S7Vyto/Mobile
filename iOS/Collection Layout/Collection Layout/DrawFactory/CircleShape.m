//
//  CircleShape.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "CircleShape.h"

@implementation CircleShape


- (void)drawRect:(CGRect)rect {
    CGRect shapeRect = CGRectInset(rect, 15, 60);
    CGPoint center = CGPointMake(CGRectGetMidX(shapeRect), CGRectGetMidY(shapeRect));
    CGFloat radius = CGRectGetMidX(shapeRect) * 0.85;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:0
                                                            endAngle:M_PI * 2
                                                           clockwise:YES];
    
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
