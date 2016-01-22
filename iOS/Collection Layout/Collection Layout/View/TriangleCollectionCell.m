//
//  TriangleCollectionCell.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "TriangleCollectionCell.h"
#import "ShapeFactory.h"

@implementation TriangleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        ShapeFactory *shapeLayer = [ShapeFactory drawShapeInRect:self.frame
                                                        withType:ShapeTriangle];
        
        shapeLayer.shapeBorderColor = [UIColor blackColor];
        shapeLayer.shapeColor = [UIColor greenColor];
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = shapeLayer;
    }
    
    return self;
}

@end
