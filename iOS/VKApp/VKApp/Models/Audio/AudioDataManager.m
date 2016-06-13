//
//  AudioDataManager.m
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AudioDataManager.h"
#import "NetworkService.h"
#import "AuthService.h"
#import "Constants.h"
#import "AudioDataOperation.h"

static NSString *const kAudioList = @"audio.get";
static NSString *const kAudioListById = @"audio.getById";
static NSInteger const kAudioCount = 50;

@interface AudioDataManager ()

@property(strong, nonatomic, getter=netService) NetworkService *netService;
@property(strong, nonatomic) NSOperationQueue *pendingOperations;

@end

@implementation AudioDataManager
@synthesize delegate = _delegate, pendingOperations = _pendingOperations;

#pragma mark - ManagerLifeCycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.pendingOperations = [NSOperationQueue mainQueue];
        self.pendingOperations.name = @"AudioDataOperation";
        self.pendingOperations.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

-(NetworkService *)netService {
    if (_netService == nil) {
        _netService = [NetworkService new];
    }
    
    return _netService;
}

- (void)dealloc {
    [_pendingOperations cancelAllOperations];
    _pendingOperations = nil;
    
    _netService = nil;
    _delegate = nil;
}

#pragma mark - OperationLifeCycle
- (void)stopOperations {
    [_pendingOperations cancelAllOperations];
}

- (void)suspendOperations {
    if (_pendingOperations != nil && _pendingOperations.operationCount > 0) {
        _pendingOperations.suspended = YES;
    }
}

- (void)resumeOperations {
    if (_pendingOperations != nil && _pendingOperations.operationCount > 0) {
        _pendingOperations.suspended = NO;
    }
}

#pragma mark - ManagerMethods
- (void)fetchAudioWithUserId:(NSInteger)userId {
    NSString *token = [[AuthService sharedInstance] token];
    NSString *rawURL = [NSString stringWithFormat:@"%@/%@/%@?owner_id=%li&access_token=%@&count=%li&v=%@", CNSApiHost, CNSApiMethod, kAudioList, (long)userId, token, (long)kAudioCount, CNSApiVersion];
    NSURL *URL = [NSURL URLWithString:rawURL];
    [self.netService executeGetRequestWithURL:URL
                                   completion:^(id response) {
                                       if (response != nil) {
                                           __weak AudioDataManager *weakManager = self;
                                           __block AudioDataOperation *operation = [[AudioDataOperation alloc] initWithResponse:response];
                                           operation.queuePriority = NSOperationQueuePriorityHigh;
                                           operation.qualityOfService = NSOperationQualityOfServiceUserInitiated;
                                           operation.completionBlock = ^{
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   AudioDataManager *strongManager = weakManager;
                                                   if (strongManager.delegate != nil) {
                                                       [strongManager.delegate didRecievedAudio:operation.entityList];
                                                   }
                                                   
                                                   operation = nil;
                                                   strongManager = nil;
                                               });
                                           };
                                           
                                           [_pendingOperations addOperation:operation];
                                       }
                                   }
                                    exception:^(NSError *exception) {
                                        if (_delegate != nil) {
                                            [_delegate didRecievedAudioWithError:exception];
                                        }
                                    }];
}

- (void)fetchAudioById:(NSInteger)audioId forUserId:(NSInteger)userId {
    
}

@end
