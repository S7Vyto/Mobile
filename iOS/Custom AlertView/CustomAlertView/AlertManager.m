//
//  AlertManager.m
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import "AlertManager.h"
#import "AlertViewBox.h"

@interface AlertManager () <AlertViewBoxProtocol>

@property (nonatomic, strong) NSMutableArray *stack;
@property (nonatomic, strong) NSMutableArray *escapeWindows;
@property (assign) NSInteger currentAlertViewIndex;

@end

@implementation AlertManager
static AlertManager *instance = nil;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.stack = [[NSMutableArray alloc] init];
        self.escapeWindows = [[NSMutableArray alloc] init];
        self.currentAlertViewIndex = -1;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resetCurrentWindow)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    
    return self;
}

+ (AlertManager *)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[AlertManager alloc] init];
        }
    });
    
    return instance;
}


#pragma mark - Alert initialization
- (id)createAlertWithMessage:(NSString *)message
{
    AlertViewBox *avc = [[AlertViewBox alloc] init];
    avc.header = @"Предупреждение";
    avc.message = message;
    avc.type = DefaultAlertView;
    avc.delegate = self;
    avc.cancelEvent = [[AlertEvent alloc] initWithName:@"OK" target:nil selector:nil args:nil];
    
    [self push:avc];
    
    return avc.ident;
}

- (id)createAlertWithCode:(ErrorCodes)errorCode
{
    return nil;
}

- (id)createAlertWithName:(NSString *)name message:(NSString *)message type:(AlertViewType)type cancelEvent:(AlertEvent *)cancelEvent otherEvents:(AlertEvent *)event, ...
{
    AlertViewBox *avc = [[AlertViewBox alloc] init];
    if (name && ![name isEqualToString:@""]) {
        avc.header = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    if (message && ![message isEqualToString:@""]) {
        avc.message = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    avc.type = type;
    avc.delegate = self;
    
    if (cancelEvent) {
        avc.cancelEvent = cancelEvent;
        avc.cancelEvent.ident = avc.ident;
    }
    
    if (event) {
        va_list args;
        va_start(args, event);
        NSMutableArray *events = [[NSMutableArray alloc] init];
        
        for (AlertEvent *arg = event; arg != nil; arg = va_arg(args, AlertEvent *)) {
            arg.ident = avc.ident;
            [events addObject:arg];
        }
        
        va_end(args);
        avc.otherEvents = events;
    }
    
    [self push:avc];
    
    return avc.ident;
}

#pragma mark - Manage escape windows
- (void)addEscapeWindows:(id)window, ...
{
    if (window) {
        va_list args;
        va_start(args, window);
        
        for (id arg = window; arg != nil; arg = va_arg(args, id)) {
            [self.escapeWindows addObject:arg];
        }
        
        va_end(args);
    }
}

#pragma mark - Manager stack
- (NSMutableArray *)stack
{
    if (_stack == nil) {
        _stack = [[NSMutableArray alloc] init];
    }
    
    return _stack;
}

- (void)cleanStack
{
    if (self.stack) {
        [self.stack removeAllObjects];
    }
}

- (void)pop:(NSInteger)index
{
    if (self.stack && [self.stack count] != 0 && [self.stack count] - 1 >= index) {
        [self.stack removeObjectAtIndex:index];

        [self resetCurrentWindow];
        [self restoreEvents];
    }
}

- (void)push:(AlertViewBox *)alertView
{
    if (self.stack) {
        [self.stack addObject:alertView];
    }
}

- (AlertViewBox *)getStackElement:(NSInteger)index
{
    if (self.stack && [self.stack count] != 0 && [self.stack count] - 1 >= index) {
        return [self.stack objectAtIndex:index];
    }
    
    return nil;
}

- (NSInteger)getElementIndex:(NSString *)ident
{
    NSInteger index = 0;
    for (AlertViewBox *avc in self.stack) {
        if ([avc.ident isEqualToString:ident]) {
            break;
        }
        
        index++;
    }
    
    return index;
}

- (void)show:(NSString *)ident
{
    UIViewController *presented = [[self rootController] presentedViewController];
    if ([self.escapeWindows containsObject:presented]) {
        return;
    }
    
    NSInteger objIndex = [self getElementIndex:ident];
    AlertViewBox *obj = [self getStackElement:objIndex];
    
    if (obj) {
        UIViewController *rootWindow = [self rootController];
        if (rootWindow && self.currentAlertViewIndex == -1) {
            self.currentAlertViewIndex = objIndex;

            [rootWindow.view addSubview:obj];
            [rootWindow.view bringSubviewToFront:obj];
            [obj updateView];
        }
    }
}

- (void)restoreEvents
{
    if (self.stack && [self.stack count] != 0) {
        AlertViewBox *av = [self.stack firstObject];
        
        [self show:av.ident];
    }
}

- (void)resetCurrentWindow
{
    self.currentAlertViewIndex = -1;
}

#pragma mark - Alert view controller protocol
- (void)popAlertViewBox:(NSString *)ident
{
    NSInteger objIndex = [self getElementIndex:ident];
    [self pop:objIndex];
}

#pragma mark - Presented controller
- (UIViewController *)rootController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootController = keyWindow.rootViewController;
    
    return rootController;
}

- (UIWindow *)keyWindow
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    return keyWindow;
}

# pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

@end
