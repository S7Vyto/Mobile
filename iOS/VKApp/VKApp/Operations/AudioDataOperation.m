//
//  AudioDataOperation.m
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AudioDataOperation.h"
#import "AudioEntity.h"

@interface AudioDataOperation ()

@property (copy) id response;

@end

@implementation AudioDataOperation
@synthesize response = _response, entityList = _entityList;

#pragma mark - OperationLifeCycle
- (instancetype)initWithResponse:(id)response {
    self = [super init];
    if (self) {
        self.response = response;
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
    
    if (_response == nil) {
        [self cancel];
        return;
    }
    
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
                AudioEntity *entity = [AudioEntity new];
                entity.entityId = [jsonItem[@"id"] integerValue];
                entity.ownerId = [jsonItem[@"owner_id"] integerValue];
                entity.date = [jsonItem[@"date"] doubleValue];
                entity.duration = [jsonItem[@"duration"] doubleValue];
                entity.genreId = [jsonItem[@"genre_id"] integerValue];
                entity.lyricsId = [jsonItem[@"lyrics_id"] integerValue];
                entity.artist = jsonItem[@"artist"];
                entity.title = jsonItem[@"title"];
                entity.url = jsonItem[@"url"];
                
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
