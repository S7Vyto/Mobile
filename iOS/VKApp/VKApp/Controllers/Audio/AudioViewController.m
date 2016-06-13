//
//  AudioViewController.m
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AudioViewController.h"
#import "AudioDataManager.h"
#import "AuthService.h"
#import "AudioEntity.h"
#import "AudioViewCell.h"
#import "DateUtils.h"
#import "UIViewController+ExtensionContoller.h"

static NSString *const kAudioCellId = @"AudioCell";

@interface AudioViewController () <UITableViewDataSource, UITableViewDelegate, AudioDataManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *audioTableView;
@property (strong, nonatomic) NSArray <AudioEntity *> *audioData;
@property (strong, nonatomic) AudioDataManager *dataManager;
@property (strong, nonatomic) AuthService *authService;

@end

@implementation AudioViewController
@synthesize audioTableView = _audioTableView, audioData = _audioData, dataManager = _dataManager, authService = _authService;

#pragma mark - ViewControllerLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
    [self setupContent];
    [self setupAudioTableView];
    [self fetchUserAudio];
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
    _audioTableView.delegate = nil;
    _audioTableView.dataSource = nil;
    _dataManager.delegate = nil;
}

#pragma mark - SetupContent
- (void)setupContent {
    self.audioData = @[];
    
    self.dataManager = [AudioDataManager new];
    self.dataManager.delegate = self;
    
    self.authService = [AuthService sharedInstance];
}

#pragma mark - Appearance
- (void)setupAudioTableView {
    _audioTableView.dataSource = self;
    _audioTableView.delegate = self;
    
    _audioTableView.backgroundView = nil;
    _audioTableView.backgroundColor = [UIColor clearColor];
    
    _audioTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _audioTableView.contentInset = UIEdgeInsetsMake(5.0, 0.0, 5.0, 0.0);
    _audioTableView.separatorInset = UIEdgeInsetsZero;
    _audioTableView.separatorColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"AudioViewCell"
                                bundle:[NSBundle mainBundle]];
    
    [_audioTableView registerNib:nib
          forCellReuseIdentifier:kAudioCellId];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_audioData count];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAudioCellId
                                                          forIndexPath:indexPath];
    
    AudioEntity *entity = _audioData[indexPath.row];
    cell.artistLabel.text = entity.artist;
    cell.songLabel.text = entity.title;
    cell.durationLabel.text = [DateUtils dateUnixTime:entity.duration
                                       withDateFormat:@"mm:ss"];
    
    cell.playButton.tag = indexPath.row;
    [cell.playButton addTarget:self
                        action:@selector(didSelectPlayButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <= [_audioData count] - 1) {
        AudioViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self didSelectPlayButton:cell.playButton];
    }
}

#pragma mark - AudioControllerMethods
- (void)fetchUserAudio {
    [_dataManager fetchAudioWithUserId:[_authService userId]];
}

- (void)didSelectPlayButton:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
    }
    else {
        [sender setSelected:YES];
    }
}

#pragma mark - AudoiDataManagerDelegate
- (void)didRecievedAudio:(NSArray<AudioEntity *> *)audioData {
    [self setAudioData:audioData];
    [self.audioTableView reloadData];
}

- (void)didRecievedAudioWithError:(NSError *)error {
    
}

@end
