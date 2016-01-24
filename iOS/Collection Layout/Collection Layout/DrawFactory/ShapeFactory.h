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
    ShapeRectangle,
    ShapeTriangle,
    ShapeCircle
};

@interface ShapeFactory : UIView

+ (ShapeFactory *)drawShapeInRect:(CGRect)rect withType:(ShapeType)shapeType;

@property (strong, nonatomic) UIColor *shapeColor;
@property (strong, nonatomic) UIColor *shapeBorderColor;

@end
