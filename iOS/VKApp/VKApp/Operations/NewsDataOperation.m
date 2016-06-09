//
//  NewsDataOperation.m
//  VKApp
//
//  Created by Semyon Vyatkin on 07/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NewsDataOperation.h"
#import "NewsEntity.h"

@interface NewsDataOperation ()

@property (copy, nonatomic) id response;

@end

@implementation NewsDataOperation
@synthesize response = _response, entityList = _entityList;

#pragma mark - OperationLifeCycle
- (instancetype)initWithResponse:(id)response {
    self = [super init];
    if (self) {
        self.response = [response copy];
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
    id jsonResponse = nil;
    
    if ([_response isKindOfClass:[NSDictionary class]]) {        
        if ([NSJSONSerialization isValidJSONObject:_response]) {
            isJsonWithError = NO;
            jsonResponse = _response;
        }
    }
    else if ([_response isKindOfClass:[NSData class]]) {
        NSError *jsonError = nil;
         jsonResponse = [NSJSONSerialization JSONObjectWithData:_response
                                                        options:NSJSONReadingAllowFragments
                                                          error:&jsonError];
        
        if (jsonError == nil) {
            if ([NSJSONSerialization isValidJSONObject:jsonResponse]) {
                isJsonWithError = NO;
            }
        }
    }
    
    if (isJsonWithError) {
        [self cancel];
    }
    else {
        if ([self isCancelled]) {
            return;
        }
        
        id jsonObject = jsonResponse[@"response"];
        id jsonItems = jsonObject[@"items"];
        if ([jsonItems isKindOfClass:[NSArray class]]) {
            NSMutableArray *entityList = [NSMutableArray new];
            for (id jsonItem in jsonItems) {
                NewsEntity *entity = [NewsEntity new];
                entity.entityId = [jsonItem[@"id"] integerValue];
                entity.ownerId = [jsonItem[@"owner_id"] integerValue];
                entity.fromId = [jsonItem[@"from_id"] integerValue];
                entity.postDate = [jsonItem[@"date"] doubleValue];
                entity.text = jsonItem[@"text"];
                
                [entityList addObject:entity];
            }
            
            self.entityList = entityList;
        }
    }
}

- (void)cancel {
    [super cancel];
    
    _entityList = nil;
    _response = nil;
}

@end
