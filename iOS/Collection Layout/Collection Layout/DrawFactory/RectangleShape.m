//
//  RectangleShape.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 24/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "RectangleShape.h"

@implementation RectangleShape

- (void)drawRect:(CGRect)rect {
    CGRect shapeRect = CGRectInset(rect, 25, 25);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:shapeRect
                                                          cornerRadius:5.0];
    
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
