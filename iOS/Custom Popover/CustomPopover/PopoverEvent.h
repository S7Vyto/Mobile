//
//  PopoverEvent.h
//  CustomPopover
//
//  Created by Semyon Vyatkin on 18.09.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define pEvent(n,t,s,a, ...) ([[PopoverEvent alloc] initWithName:(n) target:(t) action:(s) arguments:a, ##__VA_ARGS__])

@interface PopoverEvent : NSObject

@property (copy, nonatomic) id name;
@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;
@property (strong, nonatomic) NSMutableArray *arguments;

- (id)initWithName:(id)name target:(id)target action:(SEL)action arguments:(id)argument, ... NS_REQUIRES_NIL_TERMINATION;

@end
