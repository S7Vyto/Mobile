//
//  AudioViewCell.m
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AudioViewCell.h"
#import "UITableViewCell+ExtensionCell.h"
#import "ThemeService.h"

@implementation AudioViewCell
@synthesize artistLabel = _artistLabel, songLabel = _songLabel, durationLabel = _durationLabel, playButton = _playButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupAppearance];
    [self setupContentAppearance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _playButton.selected = selected;
}

- (void)setupContentAppearance {
    _songLabel.font = [ThemeService cellTitleFont];
    _songLabel.textColor = [ThemeService cellTitleColor];
    _songLabel.textAlignment = [ThemeService cellTextAligment];
    _songLabel.numberOfLines = [ThemeService cellNumberOfLines];
    _songLabel.lineBreakMode = [ThemeService cellLineBreakMode];
    
    _artistLabel.font = [ThemeService cellSubTitleFont];
    _artistLabel.textColor = [ThemeService cellSubTitleColor];
    _artistLabel.textAlignment = [ThemeService cellTextAligment];
    _artistLabel.numberOfLines = [ThemeService cellNumberOfLines];
    _artistLabel.lineBreakMode = [ThemeService cellLineBreakMode];
    
    _durationLabel.font = [ThemeService cellAdditionalFont];
    _durationLabel.textColor = [ThemeService cellAdditionalColor];
    _durationLabel.textAlignment = [ThemeService cellAdditionalTextAligment];
    _durationLabel.numberOfLines = [ThemeService cellAdditionalNumberOfLines];
    _durationLabel.lineBreakMode = [ThemeService cellLineBreakMode];        
    
    [_playButton setExclusiveTouch:YES];
    [_playButton setTitle:nil forState:UIControlStateNormal];
    [_playButton setTitle:nil forState:UIControlStateSelected];
    [_playButton setImage:IMAGE_NAME(@"play-audio") forState:UIControlStateNormal];
    [_playButton setImage:IMAGE_NAME(@"pause-audio") forState:UIControlStateSelected];
}

@end
