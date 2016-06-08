//
//  NewsDataManager.m
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NewsDataManager.h"
#import "NetworkService.h"
#import "AuthService.h"
#import "NewsDataOperation.h"
#import "Constants.h"

static NSString *const kNewsList = @"wall.get";
static NSString *const kNewsListById = @"wall.getById";
static NSString *const kNewsAdd = @"wall.post";
static NSString *const kNewsEdit = @"wall.edit";
static NSString *const kNewsDelete = @"wall.delete";
static NSInteger const kNewsCount = 50;

@interface NewsDataManager ()

@property(strong, nonatomic, getter=netService) NetworkService *netService;
@property(strong, nonatomic) NSOperationQueue *pendingOperations;

@end

@implementation NewsDataManager
@synthesize delegate = _delegate, pendingOperations = _pendingOperations;

#pragma mark - ManagerLifeCycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.pendingOperations = [NSOperationQueue new];
        self.pendingOperations.name = @"NewsDataOperation";
        self.pendingOperations.maxConcurrentOperationCount = 5;
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
    _netService = nil;
    _delegate = nil;
}

#pragma mark - ManagerMethods
- (void)fetchNewsWithUserId:(NSInteger)userId {
    __weak NewsDataManager *weakManager = self;
    NSString *token = [[AuthService sharedInstance] token];
    NSString *rawURL = [NSString stringWithFormat:@"%@/%@/%@?owner_id=%li&access_token=%@&count=%li&v=%@", CNSApiHost, CNSApiMethod, kNewsList, (long)userId, token, (long)kNewsCount, CNSApiVersion];
    NSURL *URL = [NSURL URLWithString:rawURL];
    [self.netService executeGetRequestWithURL:URL
                                   completion:^(id response) {
                                       NewsDataManager *strongManager = weakManager;
                                       
                                       if (response != nil) {
                                           __block NSMutableArray *entityList = [NSMutableArray new];
                                           NewsDataOperation *newsOperation = [[NewsDataOperation alloc] initWithResponse:response
                                                                                                                entitList:entityList];
                                           newsOperation.queuePriority = NSOperationQueuePriorityHigh;
                                           newsOperation.qualityOfService = NSOperationQualityOfServiceUserInitiated;
                                           newsOperation.completionBlock = ^{
                                               if (strongManager.delegate != nil) {
                                                   [strongManager.delegate didRecievedNews:entityList];
                                               }
                                           };
                                           
                                           [strongManager.pendingOperations addOperation:newsOperation];
                                       }
                                   }
                                    exception:^(NSError *exception) {
                                        if (_delegate != nil) {
                                            [_delegate didRecievedNewsWithError:exception];
                                        }
    }];
}

- (void)fetchNewsById:(NSInteger)newsId forUserId:(NSInteger)userId {
    
}

- (void)addNews:(NSString *)message forUserId:(NSInteger)userId {
    
}

- (void)editNews:(NSInteger)newsId withMessage:(NSString *)message {
    
}

-(void)deleteNews:(NSInteger)newsId {
    
}

@end
