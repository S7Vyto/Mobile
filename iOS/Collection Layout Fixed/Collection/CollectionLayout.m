//
//  CollectionLayout.m
//  Collection
//
//  Created by Semyon Vyatkin on 20.01.15.
//  Copyright (c) 2015 Semyon Vyatkin. All rights reserved.
//

#import "CollectionLayout.h"

static NSInteger const kColumnCount = 10;

@interface CollectionLayout ()

@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSMutableArray *sizes;
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation CollectionLayout


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attr = [NSMutableArray new];
    for (NSArray *section in self.attributes)
    {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            return CGRectIntersectsRect(rect, [evaluatedObject frame]);
        }];
        
        [attr addObjectsFromArray:[section filteredArrayUsingPredicate:predicate]];
    }
    
    return attr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.attributes[indexPath.section][indexPath.row];
}

- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (void)calculateSize
{
    for (NSUInteger index = 0; index < kColumnCount; index++)
    {
        if (self.sizes.count <= index)
        {
            CGSize size = CGSizeMake(10, 10);
            
            if (self.delegate) {
                CGFloat width = [self.delegate columnWidthForIndex:index];
                CGFloat height = [self.delegate columnHeightForIndex:index];
                
                size = CGSizeMake(width, height);
            }
            
            NSValue *sizeValue = [NSValue valueWithCGSize:size];
            
            [self.sizes addObject:sizeValue];
        }
    }
}

- (void)prepareLayout
{
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    
    NSUInteger column = 0;
    CGFloat xOffset = 0.0;
    CGFloat yOffset = 0.0;
    CGFloat contentWidth = 0.0;
    CGFloat contentHeight = 0.0;
    
    if ([self.attributes count] > 0)
    {
        for (int section = 0; section < [self.collectionView numberOfSections]; section++)
        {
            NSUInteger count = [self.collectionView numberOfItemsInSection:section];
            for (NSUInteger index = 0; index < count; index++)
            {
                if (section != 0 && index != 0) {
                    continue;
                }
                
                UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section]];
                
                if (section == 0) {
                    CGRect rect = attr.frame;
                    rect.origin.y = self.collectionView.contentOffset.y;
                    
                    attr.frame = rect;
                }
                
                if (index == 0) {
                    CGRect rect = attr.frame;
                    rect.origin.x = self.collectionView.contentOffset.x;
                    
                    attr.frame = rect;
                }
            }
        }
        
        return;
    }
    
    self.attributes = [NSMutableArray new];
    self.sizes = [NSMutableArray new];
    
    if (self.sizes.count != kColumnCount) {
        [self calculateSize];
    }
    
    for (int section = 0; section < [self.collectionView numberOfSections]; section++)
    {
        NSMutableArray *sectionAttrs = [NSMutableArray new];
        for (NSUInteger index = 0; index < kColumnCount; index++)
        {
            CGSize size = [self.sizes[index] CGSizeValue];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            
            UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attrs.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, size.width, size.height));
            
            if (section == 0 && index == 0) {
                attrs.zIndex = 1024;
            }
            else if (section == 0 || index == 0) {
                attrs.zIndex = 1023;
            }
            
            if (section == 0)
            {
                CGRect rect = attrs.frame;
                rect.origin.y = self.collectionView.contentOffset.y;
                
                attrs.frame = rect;
            }
            
            if (index == 0) {
                CGRect rect = attrs.frame;
                rect.origin.x = self.collectionView.contentOffset.x;
                
                attrs.frame = rect;
            }
            
            [sectionAttrs addObject:attrs];
            xOffset += size.width;
            column++;
            
            if (column == kColumnCount)
            {
                if (xOffset > contentWidth) {
                    contentWidth = xOffset;
                }
                
                column = 0;
                xOffset = 0;
                yOffset += size.height;
            }
        }
        
        [self.attributes addObject:sectionAttrs];
    }
    
    UICollectionViewLayoutAttributes *attr = [[self.attributes lastObject] lastObject];
    contentHeight = attr.frame.origin.y + attr.frame.size.height;
    
    self.contentSize = CGSizeMake(contentWidth, contentHeight);
}

@end
