//
//  AuthService.m
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AuthService.h"
#import "NetworkService.h"
#import "PreferencesService.h"

static NSString *kAuthURL = @"https://oauth.vk.com/authorize";
static NSString *kClientId = @"";
static NSString *kRedirectURL = @"https://oauth.vk.com/blank.html";
static NSString *kDisplay =@"mobile";
static NSString *kScope =@"wall,photo,audio,offline";
static NSString *kResponsType =@"token";
static NSString *kApiVersion =@"5.52";

@implementation AuthService


#pragma mark - ServiceLifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static AuthService *authService = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        authService = [self new];
    });
    
    return authService;
}

#pragma mark - ServiceMethods
- (BOOL)isUserAuthorized {
    return NO;
}

- (NSURLRequest *)requestAuthorization {
    NSString *authStringURL = [NSString stringWithFormat:@"%@?client_id=%@&display=%@&redirect_uri=%@&scope=%@&response_type=%@&v=%@",
                               kAuthURL,
                               kClientId,
                               kDisplay,
                               kRedirectURL,
                               kScope,
                               kResponsType,
                               kApiVersion];
    
    return [[NetworkService sharedInstance] requestWithURL:authStringURL];
}

@end
