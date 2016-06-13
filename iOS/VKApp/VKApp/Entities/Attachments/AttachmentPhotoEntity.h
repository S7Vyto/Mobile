//
//  AttachmentPhotoEntity.h
//  VKApp
//
//  Created by Semyon Vyatkin on 10/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AttachmentEntity.h"

@interface AttachmentPhotoEntity : AttachmentEntity

@property (copy, nonatomic) NSString *accessKey;
@property (assign, nonatomic) NSInteger albumId;
@property (assign, nonatomic) NSTimeInterval date;
@property (assign, nonatomic) NSInteger width;
@property (assign, nonatomic) NSInteger height;
@property (copy, nonatomic) NSString *photo75;
@property (copy, nonatomic) NSString *photo130;
@property (copy, nonatomic) NSString *photo604;
@property (copy, nonatomic) NSString *photo807;
@property (assign, nonatomic) NSInteger postId;
@property (copy, nonatomic) NSString *text;

@end
