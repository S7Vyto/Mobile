//
//  RectangleCollectionCell.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 24/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "RectangleCollectionCell.h"
#import "ShapeFactory.h"

@implementation RectangleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        ShapeFactory *shapeLayer = [ShapeFactory drawShapeInRect:self.frame
                                                        withType:ShapeRectangle];
        
        shapeLayer.shapeBorderColor = [UIColor grayColor];
        shapeLayer.shapeColor = [UIColor cyanColor];
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = shapeLayer;
    }
    
    return self;
}

@end
