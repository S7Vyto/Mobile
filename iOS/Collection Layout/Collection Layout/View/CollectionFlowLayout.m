//
//  CollectionFlowLayout.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 23/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "CollectionFlowLayout.h"

@interface CollectionFlowLayout ()

@property (nonatomic, strong) NSMutableArray *cache;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation CollectionFlowLayout
@synthesize cache = _cache, contentHeight = _contentHeight;

- (void)updateLayout {
    self.contentHeight = 0.0;
    
    [self.cache removeAllObjects];
    [self invalidateLayout];
}

- (CGSize)collectionViewContentSize {
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    
    return CGSizeMake(contentWidth, _contentHeight);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _cache[indexPath.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in _cache) {
        if (CGRectIntersectsRect(attr.frame, rect)) {
            [attributes addObject:attr];
        }
    }
    
    return attributes;
}

- (void)prepareLayout {
    if (_cache == nil || _cache.count == 0) {
        self.cache = [NSMutableArray array];
        
        CGRect appStatusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        CGRect appStatusNavFrame = [[UINavigationBar appearance] frame];
        
        CGRect appRect = [UIScreen mainScreen].bounds;
        CGSize cellSize = CGSizeMake(appRect.size.width, appRect.size.height - 2 * (appStatusBarFrame.size.height + appStatusNavFrame.size.height));
        
        CGFloat yOffset = 0.0;
        
        for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i
                                                         inSection:0];
            
            CGRect frame = CGRectMake(0, yOffset, cellSize.width, cellSize.height);
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = frame;
            
            [self.cache addObject:attributes];
            
            self.contentHeight = MAX(_contentHeight, CGRectGetMaxY(frame));
            yOffset += cellSize.height;
        }
    }
}

@end