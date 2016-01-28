//
//  CollectionLayout.h
//  Collection
//
//  Created by Semyon Vyatkin on 20.01.15.
//  Copyright (c) 2015 Semyon Vyatkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionLayoutProtocol <NSObject>
@required
- (CGFloat)columnWidthForIndex:(NSUInteger)index;
- (CGFloat)columnHeightForIndex:(NSUInteger)index;

@end

@interface CollectionLayout : UICollectionViewLayout

@property (nonatomic, weak) id <CollectionLayoutProtocol> delegate;

@end
