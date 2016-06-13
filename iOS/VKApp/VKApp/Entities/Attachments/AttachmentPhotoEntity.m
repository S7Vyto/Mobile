//
//  AttachmentPhotoEntity.m
//  VKApp
//
//  Created by Semyon Vyatkin on 10/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AttachmentPhotoEntity.h"
#import "DateUtils.h"

@implementation AttachmentPhotoEntity
@synthesize accessKey = _accessKey, albumId = _albumId, date = _date, width = _width, height = _height, photo75 = _photo75, photo130 = _photo130, photo604 = _photo604, photo807 = _photo807,
postId = _postId, text = _text;

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

@end
