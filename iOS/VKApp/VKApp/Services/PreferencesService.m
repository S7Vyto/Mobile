//
//  PreferencesService.m
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "PreferencesService.h"

NSString *const PSExistsUserKey = @"ExistsUser";
NSString *const PSIsUserAuthorized = @"IsUserAuthorized";

@implementation PreferencesService

#pragma mark - ServiceLifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static PreferencesService *prefService = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        prefService = [self new];
    });
    
    return prefService;
}

- (void)dealloc {
    
}

#pragma mark - ServiceMethods

@end
