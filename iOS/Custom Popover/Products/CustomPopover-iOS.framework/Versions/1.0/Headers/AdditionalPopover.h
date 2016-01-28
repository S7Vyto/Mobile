//
//  AdditionalPopover.h
//  CustomPopover
//  Version 1.5
//
//  Created by Semyon Vyatkin on 17.09.14.
//  Copyright (c) 2014 prognoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "PopoverEvent.h"

@interface AdditionalPopover : UIPopoverController

@property (strong, nonatomic) NSArray *events;
@property (assign, nonatomic) PopoverStyle style;


- (id)init;

@end
