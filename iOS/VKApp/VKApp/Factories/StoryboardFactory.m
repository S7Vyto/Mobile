//
//  StoryboardFactory.m
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "StoryboardFactory.h"

static NSString *const kLoginStoryboardName = @"Login";
static NSString *const kMainStoryboardName = @"Main";

@implementation StoryboardFactory

+ (UIStoryboard *)storyboardWithType:(StoryboardType)type {
    switch (type) {
        case LoginStoryboard:
            return [UIStoryboard storyboardWithName:kLoginStoryboardName
                                             bundle:[NSBundle mainBundle]];
        case MainStoryboard:
            return [UIStoryboard storyboardWithName:kMainStoryboardName
                                             bundle:[NSBundle mainBundle]];
    }
}

+ (UIViewController *)rootController:(StoryboardType)type {
    return [[StoryboardFactory storyboardWithType:type] instantiateInitialViewController];
}

+ (UIViewController *)controllerWithName:(NSString *)name withStoryboardType:(StoryboardType)type {
    return [[StoryboardFactory storyboardWithType:type] instantiateViewControllerWithIdentifier:name];
}

@end
