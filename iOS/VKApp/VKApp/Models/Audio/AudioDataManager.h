//
//  AudioDataManager.h
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Delegates.h"

@interface AudioDataManager : NSObject

@property(weak, nonatomic) id<AudioDataManagerDelegate> delegate;

- (void)fetchAudioWithUserId:(NSInteger)userId;
- (void)fetchAudioById:(NSInteger)audioId forUserId:(NSInteger)userId;

- (void)suspendOperations;
- (void)resumeOperations;
- (void)stopOperations;

@end
