//
//  NetworkService.m
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NetworkService.h"
#import <AFNetworking/AFNetworking.h>

@interface NetworkService()

@property(assign, nonatomic) BOOL hasInternetConnection;

@end

@implementation NetworkService
@synthesize hasInternetConnection = _hasInternetConnection;

#pragma mark - ServiceLifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
             NSLog(@"Reachability status: %@", AFStringFromNetworkReachabilityStatus(status));
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                case AFNetworkReachabilityStatusNotReachable:
                    self.hasInternetConnection = NO;
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    self.hasInternetConnection = YES;
            }
        }];
     
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static NetworkService *netService = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        netService = [self new];
    });
    
    return netService;
}

- (void)dealloc {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

#pragma mark - ServiceMethods
- (BOOL)hasInternetConnection {
    return _hasInternetConnection;
}

- (NSURLRequest *)requestWithURL:(NSString *)stringURL {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
}

- (void)executeGetRequestWithURL:(NSURL *)URL completion:(completionBlock)completion exception:(exceptionBlock)exception {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                                    if (error == nil) {
                                                        if (completion) {
                                                            completion(responseObject);
                                                        }
                                                    }
                                                    else {
                                                        if (exception) {
                                                            exception(error);
                                                        }
                                                    }
    }];
    
    [dataTask resume];
    // Optimization trick
    [manager invalidateSessionCancelingTasks:NO];
}

- (void)executePostRequestWithURL:(NSURL *)URL completion:(completionBlock)completion exception:(exceptionBlock)exception {
    
}

@end
