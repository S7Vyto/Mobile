//
//  AuthService.h
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthService : NSObject

+ (instancetype)sharedInstance;
- (BOOL)isUserAuthorized;
- (NSURLRequest *)requestAuthorization;

@end
