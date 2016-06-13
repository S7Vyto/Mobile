//
//  AudioViewCell.h
//  VKApp
//
//  Created by Semyon Vyatkin on 13/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
