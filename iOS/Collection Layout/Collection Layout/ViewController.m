//
//  ViewController.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "ViewController.h"
#import "CircleCollectionCell.h"
#import "TriangleCollectionCell.h"

static int const kSectionsCount = 1;
static int const kItemsCount = 5;

static NSString *const kCircleCellId = @"CircleCell";
static NSString *const kTriangleCellId = @"TriangleCell";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController
@synthesize collectionView = _collectionView;

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_collectionView registerClass:[CircleCollectionCell class]
        forCellWithReuseIdentifier:kCircleCellId];
    
    [_collectionView registerClass:[TriangleCollectionCell class]
        forCellWithReuseIdentifier:kTriangleCellId];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [_collectionView setCollectionViewLayout:flowLayout
                                    animated:YES];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kItemsCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kSectionsCount;
}

#pragma mark - CollectionView Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:kTriangleCellId
                                                                                 forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0) {
        contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCircleCellId
                                                                forIndexPath:indexPath];
    }
    
    return contentCell;
}

@end
