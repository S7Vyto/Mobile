//
//  AlertManager.h
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 prognoz. All rights reserved.
//  Version 1.0 

#import <Foundation/Foundation.h>
#import "AlertConstant.h"
#import "AlertEvent.h"

@interface AlertManager : NSObject

+ (AlertManager *)instance;
- (id)createAlertWithMessage:(NSString *)message;
- (id)createAlertWithCode:(ErrorCodes)errorCode;
- (id)createAlertWithName:(NSString *)name message:(NSString *)message type:(AlertViewType)type cancelEvent:(AlertEvent *)cancelEvent otherEvents:(AlertEvent *)event, ... NS_REQUIRES_NIL_TERMINATION;

- (void)addEscapeWindows:(id)window, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show:(NSString *)ident;
- (void)restoreEvents;
- (void)cleanStack;

@end
