//
//  ViewController.h
//  Collection
//
//  Created by Semyon Vyatkin on 20.01.15.
//  Copyright (c) 2015 Semyon Vyatkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@end
