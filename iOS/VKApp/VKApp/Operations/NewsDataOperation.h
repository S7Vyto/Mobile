//
//  NewsDataOperation.h
//  VKApp
//
//  Created by Semyon Vyatkin on 07/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsEntity;
typedef void(^DataCompletionBlock)(NSArray <NewsEntity *> *entityList);

@interface NewsDataOperation : NSOperation

@property (nonatomic, copy) DataCompletionBlock dataCompletionBlock;

- (instancetype)initWithResponse:(id)response entitList:(NSMutableArray *)entityList;

@end
