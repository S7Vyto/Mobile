//
//  PreferencesService.h
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const PSExistsUserKey;
extern NSString *const PSIsUserAuthorized;

@interface PreferencesService : NSObject

+ (instancetype)sharedInstance;

@end
