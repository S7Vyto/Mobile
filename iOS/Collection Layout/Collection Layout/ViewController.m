//
//  ViewController.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "ViewController.h"
#import "CollectionFlowLayout.h"
#import "RectangleCollectionCell.h"
#import "CircleCollectionCell.h"
#import "TriangleCollectionCell.h"

static int const kSectionsCount = 1;
static int const kItemsCount = 6;

static NSString *const kRectangleCellId = @"RectangleCell";
static NSString *const kCircleCellId = @"CircleCell";
static NSString *const kTriangleCellId = @"TriangleCell";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) CollectionFlowLayout *flowLayout;

@end

@implementation ViewController
@synthesize collectionView = _collectionView, flowLayout = _flowLayout;

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.flowLayout = [CollectionFlowLayout new];
    
    [_collectionView registerClass:[RectangleCollectionCell class]
        forCellWithReuseIdentifier:kRectangleCellId];
    
    [_collectionView registerClass:[CircleCollectionCell class]
        forCellWithReuseIdentifier:kCircleCellId];
    
    [_collectionView registerClass:[TriangleCollectionCell class]
        forCellWithReuseIdentifier:kTriangleCellId];
    
    [_collectionView setCollectionViewLayout:_flowLayout
                                    animated:YES];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setContentInset:UIEdgeInsetsZero];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation Changes
- (void)orientationDidChange:(NSNotification *)notifiaction {
    [_flowLayout updateLayout];
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
    UICollectionViewCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRectangleCellId
                                                                                 forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0) {
        contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCircleCellId
                                                                forIndexPath:indexPath];
    }
    
    return contentCell;
}

@end
