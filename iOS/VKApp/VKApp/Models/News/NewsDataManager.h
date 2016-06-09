//
//  NewsDataManager.h
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Delegates.h"

typedef NS_ENUM(NSInteger, ContentStatus) {
    AccessDenied = 15,
    PageDeleted = 18,
    ContentUnavailable = 19
};

@interface NewsDataManager : NSObject

@property(weak, nonatomic) id<NewsDataManagerDelegate> delegate;

- (void)fetchNewsWithUserId:(NSInteger)userId;
- (void)fetchNewsById:(NSInteger)newsId forUserId:(NSInteger)userId;
- (void)addNews:(NSString *)message forUserId:(NSInteger)userId;
- (void)editNews:(NSInteger)newsId withMessage:(NSString *)message;
- (void)deleteNews:(NSInteger)newsId;

- (void)suspendOperations;
- (void)resumeOperations;
- (void)stopOperations;


@end
