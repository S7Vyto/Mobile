//
//  AdditionalTable.m
//  CustomPopover
//
//  Created by Semyon Vyatkin on 17.09.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "AdditionalTable.h"
#import "GradientView.h"

@interface AdditionalTable () <UITableViewDataSource>

@end

@implementation AdditionalTable
@synthesize popoverTable, content, delegate, style;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.popoverTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableView *)popoverTable
{
    if (popoverTable == nil)
    {
        CGRect rect = self.view.bounds;
        
        popoverTable = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        popoverTable.backgroundColor = [UIColor clearColor];
        popoverTable.delegate = delegate;
        popoverTable.dataSource = self;
        popoverTable.scrollEnabled = NO;
    }
    
    return popoverTable;
}

#pragma mark - AdditionalTable Events
- (void)reloadData
{
    [self.popoverTable reloadData];
}

- (void)setFrame:(CGRect)frame
{
    self.popoverTable.frame = frame;
    
    [self.popoverTable setNeedsDisplay];
}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PopoverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[GradientView alloc] init];
    }
    
    if ([content count] > 0 && [content count] >= indexPath.row)
    {
        cell.tag = indexPath.row;
        cell.textLabel.text = content[indexPath.row];
    }
    
    if (style == PopoverCheckMark)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = (indexPath.row == 0) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)dealloc
{
    self.content = nil;
    self.popoverTable = nil;
    self.delegate = nil;
}

@end
