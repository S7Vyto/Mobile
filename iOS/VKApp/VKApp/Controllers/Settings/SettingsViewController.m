//
//  SettingsViewController.m
//  VKApp
//
//  Created by Semyon Vyatkin on 09/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIViewController+ExtensionContoller.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end

@implementation SettingsViewController
@synthesize settingsTableView = _settingsTableView;

#pragma mark - ViewControllerLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
    [self setupSettingsTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _settingsTableView.delegate = nil;
    _settingsTableView.dataSource = nil;
}

#pragma mark - SetupAppearance
- (void)setupSettingsTableView {
    _settingsTableView.dataSource = self;
    _settingsTableView.delegate = self;
    
    _settingsTableView.backgroundView = nil;
    _settingsTableView.backgroundColor = [UIColor clearColor];
    
    _settingsTableView.rowHeight = 85.0;
    _settingsTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _settingsTableView.contentInset = UIEdgeInsetsZero;
    _settingsTableView.separatorInset = UIEdgeInsetsZero;
    
//    [_newsTableView registerClass:[NewsViewCell class]
//           forCellReuseIdentifier:kNewsCellId];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - SettingsContollerMethods

@end
