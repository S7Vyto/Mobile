//
//  PreferencesService.m
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "PreferencesService.h"

NSString *const PSAuthorizationData = @"AuthorizationData";

@implementation PreferencesService

#pragma mark - ServiceLifecycle
+ (instancetype)sharedInstance {
    static PreferencesService *prefService = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        prefService = [self new];
    });
    
    return prefService;
}

#pragma mark - ServiceMethods
- (void)deleteCookieWithDomain:(NSString *)domain {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        if ([[cookie domain] rangeOfString:domain options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

- (void)updateData:(id)data withKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}

- (id)loadDataWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
