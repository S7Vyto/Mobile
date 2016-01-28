//
//  AlertView.h
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView

@property (weak) NSString *title;
@property (weak) NSString *message;
@property (assign) NSInteger buttonCount;

@end
