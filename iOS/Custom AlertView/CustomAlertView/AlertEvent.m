//
//  AlertEvent.m
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "AlertEvent.h"

@implementation AlertEvent

- (id)initWithName:(NSString *)name target:(id)target selector:(SEL)selector args:(id)arg, ...
{
    self = [super init];
    if (self)
    {
        if (name == nil || [name isEqualToString:@""]) {
            _name = @"OK";
        }
        else {
            _name = name;
        }
        
        _target = target;
        _selector = selector;
        
        if (arg) {
            va_list args;
            va_start(args, arg);
            _args = [[NSMutableArray alloc] init];
            
            for (id argument = arg; argument != nil; argument = va_arg(args, id))
                [_args addObject:argument];
            
            va_end(args);
        }
    }
    
    return self;
}

- (void)dealloc
{
    _name = nil;
    _target = nil;
    _selector = nil;
    
    [_args removeAllObjects];
    _args = nil;
}

@end
