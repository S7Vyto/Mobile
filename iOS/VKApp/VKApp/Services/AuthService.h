//
//  AuthService.h
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AuthStatus) {
    AuthRequired = 0,
    AuthSuccess,
    AuthFailed
};

typedef NS_ENUM(NSInteger, LogoutStatus) {
    LogoutSuccess = 0,
    LogoutFailed
};

@interface AuthService : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isUserAuthorized;
- (NSURLRequest *)authorizationURL;
- (void)confirmAuthorizationResponse:(NSString *)response;
- (void)deauthorizeUser;

- (NSInteger)userId;
- (NSString *)token;

@end
