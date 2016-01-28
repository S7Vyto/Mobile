//
//  PopoverEvent.m
//  CustomPopover
//
//  Created by Semyon Vyatkin on 18.09.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "PopoverEvent.h"

@interface PopoverEvent ()

@end

@implementation PopoverEvent
@synthesize name = _name, target = _target, action = _action, arguments = _arguments;

- (id)initWithName:(id)name target:(id)target action:(SEL)action arguments:(id)argument, ...
{
    self = [super init];
    if (self)
    {
        _name = name;
        _target = target;
        _action = action;
        _arguments = [[NSMutableArray alloc] init];
        
        if (argument)
        {           
            va_list args;
            va_start(args, argument);
            
            for (id arg = argument; arg != nil; arg = va_arg(args, id))
                [_arguments addObject:arg];
            
            va_end(args);
        }
    }
    
    return self;
}

- (void)dealloc
{
    _name = nil;
    _target = nil;
    _action = nil;
    
    [_arguments removeAllObjects];
    _arguments = nil;
}

@end
