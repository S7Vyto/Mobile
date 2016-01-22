//
//  CircleCollectionCell.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "CircleCollectionCell.h"
#import "ShapeFactory.h"

@implementation CircleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        ShapeFactory *shapeLayer = [ShapeFactory drawShapeInRect:self.frame
                                                        withType:ShapeCircle];
        
        shapeLayer.shapeBorderColor = [UIColor blackColor];
        shapeLayer.shapeColor = [UIColor purpleColor];
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = shapeLayer;
    }
    
    return self;
}

@end
