//
//  AlertViewBox.h
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertConstant.h"
#import "AlertEvent.h"

@protocol AlertViewBoxProtocol;
@interface AlertViewBox : UIView

@property (strong, readonly) NSString *ident;
@property (strong) NSString *header;
@property (strong) NSString *message;
@property (strong) AlertEvent *cancelEvent;
@property (strong) NSArray *otherEvents;
@property (assign) AlertViewType type;

@property (weak) id <AlertViewBoxProtocol> delegate;

- (void)updateView;

@end

@protocol AlertViewBoxProtocol <NSObject>

- (void)popAlertViewBox:(NSString *)ident;

@end
