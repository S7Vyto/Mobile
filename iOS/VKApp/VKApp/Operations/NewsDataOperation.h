//
//  NewsDataOperation.h
//  VKApp
//
//  Created by Semyon Vyatkin on 07/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsEntity;
@interface NewsDataOperation : NSOperation

@property (strong, nonatomic) NSArray <NewsEntity *> *entityList;

- (instancetype)initWithResponse:(id)response;

@end
