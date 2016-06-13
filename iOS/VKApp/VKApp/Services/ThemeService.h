//
//  ThemeService.h
//  VKApp
//
//  Created by Semyon Vyatkin on 08/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define IMAGE_NAME(n) [UIImage imageNamed:n]

@interface ThemeService : NSObject

+ (UIColor *)navigationBarTintColor;
+ (UIColor *)navigationBarBackgroundColor;
+ (UIColor *)controllerBackgroundColor;
+ (UIColor *)cellBackgroundColor;
+ (UIColor *)cellTitleColor;
+ (UIColor *)cellSubTitleColor;
+ (UIColor *)cellAdditionalColor;
+ (UIColor *)cellShadowColor;
+ (UIFont *)cellTitleFont;
+ (UIFont *)cellSubTitleFont;
+ (UIFont *)cellAdditionalFont;
+ (NSTextAlignment)cellTextAligment;
+ (NSTextAlignment)cellAdditionalTextAligment;
+ (NSLineBreakMode)cellLineBreakMode;
+ (NSInteger)cellNumberOfLines;
+ (NSInteger)cellAdditionalNumberOfLines;

@end
