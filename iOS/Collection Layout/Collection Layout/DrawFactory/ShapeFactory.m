//
//  ShapeFactory.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "ShapeFactory.h"
#import "RectangleShape.h"
#import "CircleShape.h"
#import "TriangleShape.h"

@implementation ShapeFactory
@synthesize shapeColor = _shapeColor, shapeBorderColor = _shapeBorderColor;

+ (ShapeFactory *)drawShapeInRect:(CGRect)rect withType:(ShapeType)shapeType {
    switch (shapeType) {
        case ShapeRectangle:
            return [[RectangleShape alloc] initWithFrame:rect];
            
        case ShapeTriangle:
            return [[TriangleShape alloc] initWithFrame:rect];
            
        case ShapeCircle:
            return [[CircleShape alloc] initWithFrame:rect];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect appRect = [UIScreen mainScreen].bounds;
    CGRect frame = self.frame;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        frame.size.width = frame.size.height;
        frame.origin.x = CGRectGetMidX(appRect) - CGRectGetMidX(frame);
    }
    else {
        frame.size.width = appRect.size.width;
        frame.origin.x = 0;
    }
    
    [self setFrame:frame];
    [self setNeedsDisplay];
}

- (void)dealloc {
    _shapeColor = nil;
    _shapeBorderColor = nil;
}

@end
