//
//  NewsEntity.h
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EntityType) {
    EntityPost = 0,
    EntityCopy,
    EntityReply,
    EntityPostPone,
    EntitySuggest
};

@interface NewsEntity : NSOperation

@property (assign, nonatomic) NSInteger entityId;
@property (assign, nonatomic) NSInteger ownerId;
@property (assign, nonatomic) NSInteger fromId;
@property (assign, nonatomic) double postDate;
@property (copy, nonatomic) NSString *text;



@end
