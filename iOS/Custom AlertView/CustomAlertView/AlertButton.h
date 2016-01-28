//
//  AlertButton.h
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertEvent.h"
#import "AlertConstant.h"

@protocol AlertButtonProtocol;

@interface AlertButton : UIButton

@property (weak) id <AlertButtonProtocol> delegate;
@property (assign) AlertByttonType type;

- (id)initWith:(AlertEvent *)event frame:(CGRect)rect;

@end

@protocol AlertButtonProtocol <NSObject>

- (void)executeAlertEvent:(AlertEvent *)event;

@end