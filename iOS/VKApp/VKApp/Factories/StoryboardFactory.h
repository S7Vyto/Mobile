//
//  StoryboardFactory.h
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StoryboardType) {
    LoginStoryboard,
    MainStoryboard
};

@interface StoryboardFactory : NSObject

+ (UIStoryboard *)storyboardWithType:(StoryboardType)type;
+ (UIViewController *)rootController:(StoryboardType)type;
+ (UIViewController *)controllerWithName:(NSString *)name withStoryboardType:(StoryboardType)type;

@end
