//
//  AudioEntity.m
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AudioEntity.h"
#import "DateUtils.h"

@implementation AudioEntity
@synthesize entityId = _entityId, ownerId = _ownerId, date = _date, duration = _duration, genreId = _genreId, lyricsId = _lyricsId, artist = _artist, title = _title, url = _url;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.entityId = -1;
        self.ownerId = -1;
        self.date = [DateUtils currentUnixTime];
        self.duration = 0;
        self.genreId = -1;
        self.lyricsId = -1;
        self.artist = nil;
        self.title = nil;
        self.url = nil;
    }
    
    return self;
}

@end
