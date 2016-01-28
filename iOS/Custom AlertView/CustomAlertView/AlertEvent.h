//
//  AlertEvent.h
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertEvent : NSObject

@property (weak) NSString *ident;
@property (weak, readonly) NSString *name;
@property (weak, readonly) id target;
@property (assign, readonly) SEL selector;
@property (strong, readonly) NSMutableArray *args;

- (id)initWithName:(NSString *)name target:(id)target selector:(SEL)selector args:(id)arg, ... NS_REQUIRES_NIL_TERMINATION;

@end
