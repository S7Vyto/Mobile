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
#import "NewsViewCell.h"
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
    [self setupContent];
    [self setupNewsTableView];
    [self fetchUserNews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.dataManager resumeOperations];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];    
    [self.dataManager suspendOperations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _newsTableView.delegate = nil;
    _newsTableView.dataSource = nil;
    _dataManager.delegate = nil;
}

#pragma mark - SetupContent
- (void)setupContent {
    self.newsData = @[];
    
    self.dataManager = [NewsDataManager new];
    self.dataManager.delegate = self;
    
    self.authService = [AuthService sharedInstance];
}

#pragma mark - SetupAppearance
- (void)setupNewsTableView {
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    
    _newsTableView.backgroundView = nil;
    _newsTableView.backgroundColor = [UIColor clearColor];
    
    _newsTableView.rowHeight = 85.0;
    _newsTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _newsTableView.contentInset = UIEdgeInsetsZero;
    _newsTableView.separatorInset = UIEdgeInsetsZero;
    _newsTableView.separatorColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"NewsViewCell"
                                bundle:[NSBundle mainBundle]];
    
    [_newsTableView registerNib:nib
         forCellReuseIdentifier:kNewsCellId];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_newsData count];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewsCellId
                                                         forIndexPath:indexPath];
    
    NewsEntity *entity = _newsData[indexPath.row];
    cell.textLabel.text = entity.text;
    
    return cell;
}

#pragma mark - NewsControllerMethods
- (void)fetchUserNews {
    [_dataManager fetchNewsWithUserId:[_authService userId]];
}

#pragma mark - NewsDataManagerDelegate
- (void)didRecievedNews:(NSArray<NewsEntity *> *)newsData {
    [self setNewsData:newsData];
    [self.newsTableView reloadData];
}

- (void)didRecievedNewsWithError:(NSError *)error {
    
}

@end
