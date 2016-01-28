//
//  ViewController.m
//  Collection
//
//  Created by Semyon Vyatkin on 20.01.15.
//  Copyright (c) 2015 Semyon Vyatkin. All rights reserved.
//

#import "ViewController.h"
#import "CollectionLayout.h"
static NSString *const cellIdentifier = @"CollectionCell";

@interface ViewController () <CollectionLayoutProtocol>

@end

@implementation ViewController
@synthesize collectionView = _collectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect barRect = self.navigationController.navigationBar.frame;
    CGRect rect = CGRectMake(barRect.origin.x, barRect.origin.y + barRect.size.height, barRect.size.width, 500);
    
    CollectionLayout *layout = [[CollectionLayout alloc] init];
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[UICollectionViewLayout new]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.collectionViewLayout = layout;
    _collectionView.backgroundColor = [UIColor grayColor];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:_collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection view datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor redColor];
        if (indexPath.row == 0) {
            cell.backgroundColor = [UIColor purpleColor];
        }
    }
    else if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

- (CGFloat)columnHeightForIndex:(NSUInteger)index
{
    return 45.0;
}

- (CGFloat)columnWidthForIndex:(NSUInteger)index
{
    return 100.0;
}

@end
