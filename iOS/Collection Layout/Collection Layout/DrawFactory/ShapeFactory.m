//
//  ShapeFactory.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "ShapeFactory.h"
#import "CircleShape.h"
#import "TriangleShape.h"

@implementation ShapeFactory
@synthesize shapeColor = _shapeColor, shapeBorderColor = _shapeBorderColor;

+ (ShapeFactory *)drawShapeInRect:(CGRect)rect withType:(ShapeType)shapeType {
    switch (shapeType) {
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

- (void)dealloc {
    _shapeColor = nil;
    _shapeBorderColor = nil;
}

@end
