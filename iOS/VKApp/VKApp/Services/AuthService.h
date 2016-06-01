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

@protocol AuthServiceDelegate <NSObject>

@optional
- (void)didRequestUserAuthorization:(NSURLRequest *)authorizationRequest;
- (void)didUserAuthorizedWithStatus:(AuthStatus)authStatus;
- (void)didUserLogout:(LogoutStatus)logoutStatus;

@end

@interface AuthService : NSObject

@property(weak, nonatomic) id<AuthServiceDelegate> delegate;

- (BOOL)isUserAuthorized;
- (void)requestAuthorization;
- (void)confirmAuthorizationResponse:(NSString *)response;
- (void)deauthorizeUser;

@end
