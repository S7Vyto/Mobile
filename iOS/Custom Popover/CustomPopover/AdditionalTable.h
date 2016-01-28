//
//  AdditionalTable.h
//  CustomPopover
//
//  Created by Semyon Vyatkin on 17.09.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface AdditionalTable : UIViewController

@property (strong, nonatomic) UITableView *popoverTable;
@property (strong, nonatomic) NSArray *content;
@property (assign, nonatomic) PopoverStyle style;
@property (weak, nonatomic) id <UITableViewDelegate> delegate;

- (void)reloadData;
- (void)setFrame:(CGRect)frame;

@end
