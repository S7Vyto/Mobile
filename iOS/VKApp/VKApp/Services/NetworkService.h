//
//  NetworkService.h
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^exceptionBlock)(NSError *exception);
typedef void (^completionBlock)(id response);

@interface NetworkService : NSObject

+ (instancetype)sharedInstance;
- (BOOL)hasInternetConnection;

- (NSURLRequest *)requestWithURL:(NSString *)stringURL;
- (void)executeGetRequestWithURL:(NSURL *)URL completion:(completionBlock)completion exception:(exceptionBlock)exception;
- (void)executePostRequestWithURL:(NSURL *)URL completion:(completionBlock)completion exception:(exceptionBlock)exception;

@end
