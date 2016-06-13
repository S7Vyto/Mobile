//
//  NewsViewCell.m
//  VKApp
//
//  Created by Semyon Vyatkin on 08/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NewsViewCell.h"
#import "UITableViewCell+ExtensionCell.h"

@implementation NewsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAppearance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
