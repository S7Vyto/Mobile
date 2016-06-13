//
//  NewsDataOperation.m
//  VKApp
//
//  Created by Semyon Vyatkin on 07/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NewsDataOperation.h"
#import "NewsEntity.h"
#import "AttachmentEntity.h"
#import "AttachmentPhotoEntity.h"

@interface NewsDataOperation ()

@property (copy) id response;

@end

@implementation NewsDataOperation
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
                NewsEntity *entity = [NewsEntity new];
                entity.entityId = [jsonItem[@"id"] integerValue];
                entity.ownerId = [jsonItem[@"owner_id"] integerValue];
                entity.fromId = [jsonItem[@"from_id"] integerValue];
                entity.postDate = [jsonItem[@"date"] doubleValue];
                entity.text = jsonItem[@"text"];
                entity.canDelete = [jsonItem[@"can_delete"] boolValue];
                entity.canEdit = [jsonItem[@"can_edit"] boolValue];
                entity.canPin = [jsonItem[@"can_pin"] boolValue];
                
                id jsonHistory = jsonItem[@"copy_history"];
                if (jsonHistory != nil) {
                    id jsonAttachments = jsonHistory[0][@"attachments"];
                    if (jsonAttachments != nil && [jsonAttachments isKindOfClass:[NSArray class]]) {
                        for (id jsonAttachment in jsonAttachments) {
                            AttachmentEntity *attachment = nil;
                            NSString *type = jsonAttachment[@"type"];
                            if ([type isEqualToString:@"photo"]) {
                                attachment = [self parsePhotoAttachment:jsonAttachment[@"photo"]];
                            }
                            
                            if (attachment != nil) {
                                [entity.attachments addObject:attachment];
                            }
                        }
                    }
                }
                
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

- (AttachmentEntity *)parsePhotoAttachment:(id)jsonAttachment {
    AttachmentPhotoEntity *photoEntity = [AttachmentPhotoEntity new];
    photoEntity.accessKey = jsonAttachment[@"access_key"];
    photoEntity.albumId = [jsonAttachment[@"album_id"] integerValue];
    photoEntity.date = [jsonAttachment[@"date"] doubleValue];
    photoEntity.width = [jsonAttachment[@"width"] integerValue];
    photoEntity.height = [jsonAttachment[@"height"] integerValue];
    photoEntity.entityId = [jsonAttachment[@"id"] integerValue];
    photoEntity.ownerId = [jsonAttachment[@"owner_id"] integerValue];
    photoEntity.userId = [jsonAttachment[@"user_id"] integerValue];
    photoEntity.photo75 = jsonAttachment[@"photo_75"];
    photoEntity.photo130 = jsonAttachment[@"photo_130"];
    photoEntity.photo604 = jsonAttachment[@"photo_604"];
    photoEntity.photo807 = jsonAttachment[@"photo_807"];
    photoEntity.text = jsonAttachment[@"text"];
    
    return photoEntity;
}

@end
