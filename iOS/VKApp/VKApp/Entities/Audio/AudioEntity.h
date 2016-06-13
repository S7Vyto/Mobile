//
//  AudioEntity.h
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioEntity : NSObject

@property (assign, nonatomic) NSInteger entityId;
@property (assign, nonatomic) NSInteger ownerId;
@property (assign, nonatomic) NSTimeInterval date;
@property (assign, nonatomic) NSTimeInterval duration;
@property (assign, nonatomic) NSInteger genreId;
@property (assign, nonatomic) NSInteger lyricsId;
@property (copy, nonatomic) NSString *artist;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *url;

@end
