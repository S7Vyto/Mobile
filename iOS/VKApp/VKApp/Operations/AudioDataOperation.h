//
//  AudioDataOperation.h
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AudioEntity;
@interface AudioDataOperation : NSOperation

@property (strong, nonatomic) NSArray <AudioEntity *> *entityList;

- (instancetype)initWithResponse:(id)response;

@end
