//
//  ParserUtils.m
//  VKApp
//
//  Created by Semyon Vyatkin on 30/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "ParserUtils.h"
#import "AuthService.h"

@implementation ParserUtils

+ (NSDictionary *)parseAuthorizationResponse:(NSString *)response {
    NSRange authRange = [response rangeOfString:@"#" options:NSCaseInsensitiveSearch];
    NSMutableDictionary *authData = [NSMutableDictionary dictionary];
    
    if (authRange.location != NSNotFound) {
        NSString *rawResponse = [response substringFromIndex:++authRange.location];
        NSArray *authParams = [rawResponse componentsSeparatedByString:@"&"];
        
        if (authParams != nil && authParams.count > 0) {
            for (NSString *authParam in authParams) {
                NSArray *authParamValue = [authParam componentsSeparatedByString:@"="];
                if (authParamValue != nil && authParamValue.count > 0) {
                    authData[authParamValue[0]] = authParamValue[1];
                }
            }
        }
    }
    
    if (authData.count == 0 || [[authData allKeys] containsObject:@"error"]) {
        authData[@"AuthStatus"] = @(AuthFailed);
        authData[@"error"] = @"error";
        authData[@"error_description"] = @"error_description";
    }
    else {
        authData[@"AuthStatus"] = @(AuthSuccess);
    }
    
    return authData;
}

@end
