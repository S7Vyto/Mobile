//
//  NetworkService.h
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^exceptionBlock)(void);
typedef void (^completionBlock)(void);

@interface NetworkService : NSObject

+ (instancetype)sharedInstance;
- (BOOL)hasInternetConnection;

- (NSURLRequest *)requestWithURL:(NSString *)stringURL;

@end
