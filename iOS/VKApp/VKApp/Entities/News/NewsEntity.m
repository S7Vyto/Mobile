//
//  NewsEntity.m
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NewsEntity.h"
#import "DateUtils.h"
#import "PhotoEntity.h"

@implementation NewsEntity
@synthesize entityId = _entityId, ownerId = _ownerId, fromId = _fromId, postDate = _postDate, text = _text, type = _type, attachments = _attachments, canDelete = _canDelete, canEdit = _canEdit, canPin = _canPin;

- (instancetype)init {
    self = [super init];
    if (self) {
        _entityId = -1;
        _ownerId = -1;
        _fromId = -1;
        _text = nil;
        _postDate = [DateUtils currentUnixTime];
        _attachments = [NSMutableArray new];
        _canDelete = YES;
        _canEdit = YES;
        _canPin = YES;
    }
    
    return self;
}

@end
