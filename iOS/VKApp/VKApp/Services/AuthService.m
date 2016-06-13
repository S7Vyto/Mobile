//
//  AuthService.m
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AuthService.h"
#import "Constants.h"
#import "NetworkService.h"
#import "PreferencesService.h"
#import "ParserUtils.h"

static NSString *kAuthURL = @"https://oauth.vk.com/authorize";
static NSString *kLogoutURL = @"https://oauth.vk.com/logout";
static NSString *kRedirectURL = @"https://oauth.vk.com/blank.html";
static NSString *kDisplay =@"mobile";
static NSString *kScope =@"wall,photo,audio,offline";
static NSString *kResponsType =@"token";
static NSString *kApiRevoke = @"1";

static NSString *kAuthUserId = @"AuthUserId";
static NSString *kAuthToken = @"AuthToken";
static NSString *kAuthExpires = @"AuthExpires";
static NSString *kAuthStatus = @"AuthStatus";
static NSString *kAuthError = @"AuthError";
static NSString *kAuthErrorDescription = @"AuthErrorDescription";

@interface AuthResponse : NSObject <NSCoding>

@property(strong, nonatomic) NSString *token;
@property(assign, nonatomic) NSInteger userId;
@property(assign, nonatomic) NSInteger authExpires;
@property(assign, nonatomic) AuthStatus authStatus;
@property(strong, nonatomic) NSString *authError;
@property(strong, nonatomic) NSString *authErrorDescription;

@end

@interface AuthService ()

@property(strong, nonatomic) AuthResponse *authResponse;

@end

@implementation AuthService

#pragma mark - ServiceLifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.authResponse = [self loadAuthorizationData];
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static AuthService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

#pragma mark - AuthMethods
- (BOOL)isUserAuthorized {
    return _authResponse.authStatus == AuthSuccess;
}

- (void)confirmAuthorizationResponse:(NSString *)response {
    NSDictionary *authData = [ParserUtils parseAuthorizationResponse:response];
    AuthStatus authStatus = [authData[@"AuthStatus"] integerValue];
    switch (authStatus) {
        case AuthSuccess:
            _authResponse.token = authData[@"access_token"];
            _authResponse.userId = [authData[@"user_id"] integerValue];
            _authResponse.authExpires = [authData[@"expires_in"] integerValue];
            _authResponse.authStatus = AuthSuccess;
            _authResponse.authError = nil;
            _authResponse.authErrorDescription = nil;
            break;
            
        case AuthFailed:
        case AuthRequired:
            _authResponse.authError = authData[@"error"];
            _authResponse.authErrorDescription = authData[@"error_description"];
            _authResponse.authStatus = AuthFailed;
            break;
    }
    
    [self updateAuthorizationData:_authResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:@""
                                                        object:self
                                                      userInfo:@{@"" :_authResponse}];
}

- (void)deauthorizeUser {
    _authResponse.token = nil;
    _authResponse.userId = -1;
    _authResponse.authStatus = AuthRequired;
    _authResponse.authExpires = 0;
    _authResponse.authError = nil;
    _authResponse.authErrorDescription = nil;
    
    [[PreferencesService sharedInstance] deleteCookieWithDomain:@"vk.com"];
    [self updateAuthorizationData:_authResponse];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@""
                                                        object:self
                                                      userInfo:@{@"" :_authResponse}];
}

- (NSURLRequest *)authorizationURL {
    NSString *authQueryString = @"%@?client_id=%@&display=%@&redirect_uri=%@&scope=%@&response_type=%@&v=%@&revoke=%@";
    NSString *authRawURL = [NSString stringWithFormat:authQueryString,kAuthURL, CNSAppId, kDisplay, kRedirectURL, kScope, kResponsType, CNSApiVersion, kApiRevoke];
    
    return [[NetworkService sharedInstance] requestWithURL:authRawURL];
}

- (NSInteger)userId {
    if ([self isUserAuthorized]) {
        return _authResponse.userId;
    }
    
    return -1;
}

- (NSString *)token {
    if ([self isUserAuthorized]) {
        return _authResponse.token;
    }
    
    return nil;
}

#pragma mark - StoringMethods
- (void)updateAuthorizationData:(AuthResponse *)authData {
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:authData];
    [[PreferencesService sharedInstance] updateData:encodedData withKey:PSAuthorizationData];
}

- (AuthResponse *)loadAuthorizationData {
    NSData *encodedData = [[PreferencesService sharedInstance] loadDataWithKey:PSAuthorizationData];
    AuthResponse *authResponse = nil;
    
    if (encodedData == nil) {
        authResponse = [AuthResponse new];
        [self updateAuthorizationData:authResponse];
    }
    else {
        authResponse = [NSKeyedUnarchiver unarchiveObjectWithData:encodedData];
    }
    
    return authResponse;
}

@end

@implementation AuthResponse
@synthesize token = _token, userId = _userId, authExpires = _authExpires, authStatus = _authStatus, authError = _authError, authErrorDescription = _authErrorDescription;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userId = -1;
        self.authExpires = 0;
        self.authStatus = AuthRequired;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_token forKey:kAuthToken];
    [aCoder encodeInteger:_userId forKey:kAuthUserId];
    [aCoder encodeInteger:_authExpires forKey:kAuthExpires];
    [aCoder encodeInteger:_authStatus forKey:kAuthStatus];
    [aCoder encodeObject:_authError forKey:kAuthError];
    [aCoder encodeObject:_authErrorDescription forKey:kAuthErrorDescription];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.token = [aDecoder decodeObjectForKey:kAuthToken];
        self.userId = [aDecoder decodeIntegerForKey:kAuthUserId];
        self.authExpires = [aDecoder decodeIntegerForKey:kAuthExpires];
        self.authStatus = [aDecoder decodeIntegerForKey:kAuthStatus];
        self.authError = [aDecoder decodeObjectForKey:kAuthError];
        self.authErrorDescription = [aDecoder decodeObjectForKey:kAuthErrorDescription];
    }
    
    return self;
}


@end
