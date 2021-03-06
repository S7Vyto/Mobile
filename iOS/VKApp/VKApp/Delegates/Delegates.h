//
//  Delegates.h
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#ifndef Delegates_h
#define Delegates_h
@class NewsEntity;
@class AudioEntity;
@protocol NewsDataManagerDelegate <NSObject>

- (void)didRecievedNews:(NSArray <NewsEntity *> *)newsData;
- (void)didRecievedNewsWithError:(NSError *)error;

@end

@protocol AudioDataManagerDelegate <NSObject>

- (void)didRecievedAudio:(NSArray <AudioEntity *> *)audioData;
- (void)didRecievedAudioWithError:(NSError *)error;

@end

#endif /* Delegates_h */
