//
//  ShapeFactory.h
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShapeType) {
    ShapeTriangle,
    ShapeCircle
};

@interface ShapeFactory : UIView

+ (ShapeFactory *)drawShapeInRect:(CGRect)rect withType:(ShapeType)shapeType;

@property(nonatomic, strong) UIColor *shapeColor;
@property(nonatomic, strong) UIColor *shapeBorderColor;

@end
