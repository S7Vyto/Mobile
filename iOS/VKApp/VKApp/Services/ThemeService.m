//
//  ThemeService.m
//  VKApp
//
//  Created by Semyon Vyatkin on 08/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "ThemeService.h"

@implementation ThemeService

#pragma mark - Colors
+ (UIColor *)navigationBarTintColor {
    return RGB(27.0, 180.0, 221.0);
}

+ (UIColor *)navigationBarBackgroundColor {
    return RGB(35.0, 45.0, 62.0);
}

+ (UIColor *)controllerBackgroundColor {
    return RGB(33.0, 54.0, 74.0);
}

+ (UIColor *)cellBackgroundColor {
    return RGB(78.0, 88.0, 108.0);
}

+ (UIColor *)cellTitleColor {
    return RGB(27.0, 180.0, 221.0);
}

+ (UIColor *)cellSubTitleColor {
    return RGB(111.0, 123.0, 147.0);
}

+ (UIColor *)cellAdditionalColor {
    return RGB(255.0, 255.0, 255.0);
}

+ (UIColor *)cellShadowColor {
    return RGBA(0.0, 0.0, 0.0, 0.75);
}

#pragma mark - Fonts
+ (UIFont *)cellTitleFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
}

+ (UIFont *)cellSubTitleFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
}

+ (UIFont *)cellAdditionalFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
}

#pragma mark - Aligment
+ (NSTextAlignment)cellTextAligment {
    return NSTextAlignmentLeft;
}

+ (NSTextAlignment)cellAdditionalTextAligment {
    return NSTextAlignmentNatural;
}

#pragma mark - LineBreakMode
+ (NSLineBreakMode)cellLineBreakMode {
    return NSLineBreakByWordWrapping;
}

#pragma mark - LinesNumber
+ (NSInteger)cellNumberOfLines {
    return 0;
}

+ (NSInteger)cellAdditionalNumberOfLines {
    return 1;
}


@end
