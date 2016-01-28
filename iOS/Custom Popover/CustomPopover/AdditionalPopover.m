//
//  AdditionalPopover.m
//  CustomPopover
//
//  Created by Semyon Vyatkin on 17.09.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "AdditionalPopover.h"
#import "AdditionalTable.h"

@interface AdditionalPopover () <UITableViewDelegate>

@property (strong, nonatomic) AdditionalTable *additionalTable;

@end

@implementation AdditionalPopover
@synthesize additionalTable;

- (id)init
{
    self = [super initWithContentViewController:self.additionalTable];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dismissPopover)
                                                     name:kPopoverDismiss
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dismissPopover)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    
    return self;
}

- (AdditionalTable *)additionalTable
{
    if (additionalTable == nil)
    {
        additionalTable = [[AdditionalTable alloc] init];
        additionalTable.delegate = self;
    }
    
    return additionalTable;
}

- (void)setEvents:(NSArray *)events
{
    _events = events;

    [self.additionalTable setContent:[self content]];
    [self.additionalTable reloadData];
    
    [self setContentSize];
}

- (void)setStyle:(PopoverStyle)style
{
    _style = style;
    
    [self.additionalTable setStyle:style];
    [self.additionalTable reloadData];
    
    [self setContentSize];
}

- (void)setContentSize
{
    CGSize contentSize = [self contentSize];
    
    [self setPopoverContentSize:contentSize];
    [self.additionalTable setFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
}

- (NSArray *)content
{
    NSMutableArray *content = [[NSMutableArray alloc] init];
    
    for (id item in _events)
    {
        if ([item isKindOfClass:[PopoverEvent class]])
            [content addObject:((PopoverEvent *)item).name];
    }
    
    return content;
}

#pragma mark - Popover Events
- (void)dismissPopover
{    
    if (self.isPopoverVisible)
        [self dismissPopoverAnimated:NO];
}

- (void)executeEvent:(PopoverEvent *)event
{
    if (event != nil)
    {
        @try
        {
            NSMethodSignature *methodSignature = [event.target methodSignatureForSelector:event.action];
            if (methodSignature)
            {
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                
                [invocation setTarget:event.target];
                [invocation setSelector:event.action];
                
                if (event.arguments != nil && [event.arguments count] > 0)
                {
                    NSString *selector = NSStringFromSelector(event.action);
                    NSString *args = [selector substringFromIndex:selector.length - 1];
                    if ([args isEqualToString:@":"])
                    {
                        for (int i = 0; i < [event.arguments count]; i++)
                        {
                            id arg = event.arguments[i];
                            [invocation setArgument:&arg atIndex:i + 2];
                        }
                    }
                }
                
                [invocation invoke];
            }
        }
        @catch (NSException *exception)
        {
            NSLog(@"Error run handle event %@", exception.description);
        }
    }
}

#pragma mark - Content Size
- (CGSize)contentSize
{
    CGFloat width = 0;
    CGFloat height = 0;
    
    UITableView *table = self.additionalTable.popoverTable;
    
    for (int i = 0; i < [table numberOfRowsInSection:0]; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [table cellForRowAtIndexPath:indexPath];
        
        NSString *text = cell.textLabel.text;
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(1024.0, 44.0)];
        
        if (textSize.width > width)
            width = textSize.width + 44.0;
        
        CGRect sectionRect = [table rectForRowAtIndexPath:indexPath];
        height += sectionRect.size.height;
    }
    
    return CGSizeMake(width < 200 ? 200 : width, height - 2);
}

#pragma mark - UITable Events
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_events count] > 0 && [_events count] >= indexPath.row)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (self.style == PopoverCheckMark)
        {
            [self uncheckItems];
        
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        PopoverEvent *event = _events[indexPath.row];
        
        [self dismissPopover];
        [self executeEvent:event];
    }
}

- (void)uncheckItems
{
    UITableView *table = self.additionalTable.popoverTable;
    for (UITableViewCell *cell in [table visibleCells])
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
}

- (void)dealloc
{
    _events = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kPopoverDismiss
                                                  object:nil];
}

@end
