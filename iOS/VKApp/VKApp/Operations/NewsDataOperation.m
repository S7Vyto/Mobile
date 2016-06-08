//
//  NewsDataOperation.m
//  VKApp
//
//  Created by Semyon Vyatkin on 07/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NewsDataOperation.h"

@interface NewsDataOperation ()

@property(strong, nonatomic) NSMutableArray <NewsEntity *> *entityList;
@property(strong, nonatomic) id response;

@end

@implementation NewsDataOperation
@synthesize response = _response, entityList = _entityList, dataCompletionBlock = _dataCompletionBlock;

#pragma mark - OperationLifeCycle
- (instancetype)initWithResponse:(id)response entitList:(NSMutableArray *)entityList {
    self = [super init];
    if (self) {
        self.response = response;
        self.entityList = entityList;
    }
    
    return self;
}

#pragma mark - OperationMethods
- (void)main {
    [super main];
    
    if ([self isCancelled]) {
        return;
    }
    
    BOOL isJsonWithError = YES;
    NSJSONSerialization *jsonObject = nil;
    
    if ([_response isKindOfClass:[NSDictionary class]]) {
        if ([NSJSONSerialization isValidJSONObject:_response]) {
            isJsonWithError = NO;
            jsonObject = _response;
        }
    }
    else if ([_response isKindOfClass:[NSData class]]) {
        NSError *jsonError = nil;
         jsonObject = [NSJSONSerialization JSONObjectWithData:_response
                                                      options:NSJSONReadingAllowFragments
                                                        error:&jsonError];
        
        if (jsonError == nil) {
            if ([NSJSONSerialization isValidJSONObject:jsonObject]) {
                isJsonWithError = NO;
            }
        }
    }
    
    if (isJsonWithError) {
        [self cancel];
    }
    else {
        
    }
}

- (void)cancel {
    [_entityList removeAllObjects];
    
    _response = nil;
    _entityList = nil;
    _dataCompletionBlock = nil;
    
    [super cancel];
}

@end
