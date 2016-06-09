//
//  NewsViewController.m
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDatamanager.h"
#import "AuthService.h"
#import "NewsEntity.h"
#import "UIViewController+ExtensionContoller.h"

static NSString *const kNewsCellId = @"NewsCell";

@interface NewsViewController () <UITableViewDataSource, UITableViewDelegate, NewsDataManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (strong, nonatomic) NSArray <NewsEntity *> *newsData;
@property (strong, nonatomic) NewsDataManager *dataManager;
@property (strong, nonatomic) AuthService *authService;

@end

@implementation NewsViewController
@synthesize newsTableView = _newsTableView, dataManager = _dataManager, authService = _authService, newsData = _newsData;

#pragma mark - ViewControllerLifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.newsData = @[];
    
    self.dataManager = [NewsDataManager new];
    self.dataManager.delegate = self;
    
    self.authService = [AuthService sharedInstance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
    [self setupNewsTableView];
    [self fetchUserNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _dataManager.delegate = nil;
}

#pragma mark - SetupAppearance
- (void)setupNewsTableView {
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    
    _newsTableView.contentInset = UIEdgeInsetsMake(-66.0, 0, 0, 0);
    _newsTableView.separatorInset = UIEdgeInsetsZero;
    
    _newsTableView.estimatedRowHeight = 85.0;
    _newsTableView.rowHeight = UITableViewAutomaticDimension;
    
    [_newsTableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kNewsCellId];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_newsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewsCellId
                                                            forIndexPath:indexPath];
    
    NewsEntity *entity = _newsData[indexPath.row];
    cell.textLabel.text = entity.text;
    
    return cell;
}

- (void)fetchUserNews {
    [_dataManager fetchNewsWithUserId:[_authService userId]];
}

#pragma mark - NewsDataManagerDelegate
- (void)didRecievedNews:(NSArray<NewsEntity *> *)newsData {
    [self setNewsData:newsData];
    [_newsTableView reloadData];
}

- (void)didRecievedNewsWithError:(NSError *)error {
    
}

@end
