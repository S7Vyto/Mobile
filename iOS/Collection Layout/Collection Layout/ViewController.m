//
//  ViewController.m
//  Collection Layout
//
//  Created by Semyon Vyatkin on 22/01/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

#import "ViewController.h"
#import "ShapeFactory.h"

@interface ViewController ()

@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController
@synthesize collectionView = _collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ShapeFactory *shapeLayer = [ShapeFactory drawShapeInRect:self.view.frame
                                                    withType:ShapeTriangle];
    
    shapeLayer.shapeBorderColor = [UIColor blackColor];
    shapeLayer.shapeColor = [UIColor greenColor];
    
    [self.view addSubview:shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
