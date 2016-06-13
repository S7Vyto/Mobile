//
//  AttachmentEntity.h
//  VKApp
//
//  Created by Semyon Vyatkin on 10/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AttachmentType) {
    AttachmentPhoto = 0,
    AttachmentVideo
};

@interface AttachmentEntity : NSObject

@property (assign, nonatomic) AttachmentType type;
@property (assign, nonatomic) NSInteger entityId;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger ownerId;

@end
