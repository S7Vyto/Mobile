//
//  AlertViewController.m
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 Semyon Vyatkin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AlertViewBox.h"
#import "AlertButton.h"
#import "AlertView.h"

#define MAX_HEIGHT 500
#define MIN_HEIGHT 150

#define MAX_WIDTH 350
#define MIN_WIDTH 300

#define MIN_BUTTON_WIDTH 50
#define MIN_BUTTON_HEIGHT 42

@interface AlertViewBox () <AlertButtonProtocol>
{
    AlertView *av; // This is view contains: title + message + buttons
    UIView *bv; // And this is only buttons
}

@property (assign) BOOL appResignActive;

@end

@implementation AlertViewBox
@synthesize ident = _ident;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _ident = [AlertViewBox uuid];
        self.header = @"";
        self.message = @"";
        self.cancelEvent = nil;
        self.otherEvents = @[];
        self.type = DefaultAlertView;
        self.appResignActive = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];

    }
    
    return self;
}

+ (NSString *)uuid
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuidStringRef = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    NSString *uuidString = (__bridge NSString *)uuidStringRef;
    
    CFRelease(uuid);
    CFRelease(uuidStringRef);
    
    return uuidString;
}

#pragma mark - Update view
- (void)updateView
{
    [self initBackgroundView];
    [self performSelector:@selector(showView) withObject:nil afterDelay:0.2];
}

#pragma mark - Customize view
- (void)initBackgroundView
{
    self.backgroundColor = [UIColor clearColor];
    self.frame = [self applicationFrame];
    
    CGRect buttonRect = CGRectZero;
    
    av = [[AlertView alloc] initWithFrame:[self containerRect:&buttonRect]];
    av.title = self.header;
    av.message = self.message;
    av.alpha = 0.0;
    av.hidden = YES;
    
    [self addSubview:av];
    [self initButtonsView:buttonRect];
}

- (void)initButtonsView:(CGRect)rect
{
    NSInteger buttonsCount = 0;
    
    if (self.cancelEvent) {
        buttonsCount++;
    }
    
    if (self.otherEvents && [self.otherEvents count] > 0) {
        buttonsCount += [self.otherEvents count];
    }
    
    if (buttonsCount == 0) {
        buttonsCount++;
        
        self.cancelEvent = [[AlertEvent alloc] initWithName:nil
                                                     target:self
                                                   selector:nil
                                                       args:nil];
    }
    
    NSInteger x = rect.origin.x + 10;
    NSInteger y = rect.origin.y + 10;
    
    CGRect buttonRect = CGRectZero;
    
    for (int i = 0; i < buttonsCount; i++) {
        if (buttonsCount == 1) {
            buttonRect = CGRectMake(MIN_WIDTH / 2 - MIN_WIDTH / 5, y, MIN_WIDTH / 2.5, MIN_BUTTON_HEIGHT);
        }
        else if (buttonsCount == 2) {
            buttonRect = CGRectMake(x, y, MIN_WIDTH / 2.25, MIN_BUTTON_HEIGHT);
            x += buttonRect.size.width + 5;
        }
        else {
            buttonRect = CGRectMake(x, y, MIN_WIDTH - 2 * x, MIN_BUTTON_HEIGHT);
            y += MIN_BUTTON_HEIGHT + 5;
        }
        
        AlertButton *ab = nil;
        
        if ([self.otherEvents count] != 0 && [self.otherEvents count] - 1 >= i) {
            AlertEvent *ae = self.otherEvents[i];
            ab = [[AlertButton alloc] initWith:ae frame:buttonRect];
            ab.delegate = self;
        }
        else if (self.cancelEvent) {
            ab = [[AlertButton alloc] initWith:self.cancelEvent frame:buttonRect];
            ab.type = buttonsCount == 1 ? DoneButton : CancelButton;
            ab.delegate = self;
        }
        
        if (ab) {
            [av addSubview:ab];
        }
    }
}

#pragma mark - Customize frame
- (void)animateContainer
{
    if (av) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue = @1.5;
        animation.toValue = @1.0;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.34 :0.01 :0.69 :1.8];
        
        [av.layer addAnimation:animation forKey:@"zoomAnimation"];
    }
}

- (void)orientationChanged
{
    [self setNeedsDisplay];
}

- (CGRect)applicationFrame
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect sysRect = [[UIScreen mainScreen] bounds];
    CGRect appRect = CGRectMake(0.0, 0.0, sysRect.size.width, sysRect.size.height);
    
    if (UIInterfaceOrientationIsLandscape(orientation))
        appRect = CGRectMake(0.0, 0.0, sysRect.size.height, sysRect.size.width);
    
    return appRect;
}

- (CGRect)containerRect:(CGRect *)buttonFrame
{
    CGSize title = CGSizeZero;
    CGSize message = CGSizeZero;
    
    if (self.header && ![self.header isEqualToString:@""]) {
        title = [self.header sizeWithFont:[UIFont boldSystemFontOfSize:18]
                        constrainedToSize:CGSizeMake(MIN_WIDTH, MAX_HEIGHT)
                            lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    if (self.message && ![self.message isEqualToString:@""]) {
        message = [self.message sizeWithFont:[UIFont systemFontOfSize:16]
                           constrainedToSize:CGSizeMake(MIN_WIDTH, MAX_HEIGHT)
                               lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    NSInteger buttonsCount = 0;
    CGRect buttonRect = CGRectZero;
    
    if (self.cancelEvent) {
        buttonsCount++;
    }
    
    if (self.otherEvents && [self.otherEvents count] > 0) {
        buttonsCount += [self.otherEvents count];
    }
    
    if (buttonsCount <= 2) {
        buttonRect = CGRectMake(5, title.height + message.height + 40, MIN_WIDTH - 10, MIN_BUTTON_HEIGHT + 5);
    }
    else if (buttonsCount > 2) {
        buttonRect = CGRectMake(5, title.height + message.height + 40, MIN_WIDTH - 10, buttonsCount * MIN_BUTTON_HEIGHT + buttonsCount * 7);
    }
    
    if (buttonFrame) {
        *buttonFrame = buttonRect;
    }
    
    NSInteger offset = 60;
    
    NSInteger totalWidth = MIN_WIDTH;
    NSInteger totalHeight =  title.height + message.height + buttonRect.size.height + offset;
    
    if (totalHeight < MIN_HEIGHT) {
        totalHeight = MIN_HEIGHT;
    }
    
    CGRect appRect = [self applicationFrame];
    
    NSInteger x = CGRectGetMidX(appRect) - totalWidth / 2;
    NSInteger y = CGRectGetMidY(appRect) - totalHeight / 2;
    
    return CGRectMake(x, y, totalWidth, totalHeight);
}

- (CGRect)buttonRect
{
    return CGRectZero;
}

#pragma mark - View events
- (void)showView
{
    if (av) {
        av.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            av.alpha = 0.865;
            [self animateContainer];
        }];
    }
}

- (void)hideView
{    
    if (self.delegate && !self.appResignActive) {
        [self.delegate popAlertViewBox:self.ident];
    }
    
    if (av) {
        [UIView animateWithDuration:0.3 animations:^{
            av.alpha = 0.0;
        } completion:^(BOOL finished) {
            av.hidden = YES;
            
            [av removeFromSuperview];
            [self removeFromSuperview];
        }];
    }
}

- (void)appResignActive:(NSNotification *)nf
{
    if ([nf.name isEqualToString:UIApplicationWillResignActiveNotification]) {
        self.appResignActive = YES;
        [self hideView];
    }
}

- (void)appBecomeActive:(NSNotification *)nf
{
    if ([nf.name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        self.appResignActive = NO;
    }
}

#pragma mark - Alert button protocol
- (void)executeAlertEvent:(AlertEvent *)event
{
    if (event) {
        @try
        {
            NSMethodSignature *methodSignature = [event.target methodSignatureForSelector:event.selector];
            if (methodSignature)
            {
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                
                [invocation setTarget:event.target];
                [invocation setSelector:event.selector];
                
                if (event.args != nil && [event.args count] > 0)
                {
                    NSString *selector = NSStringFromSelector(event.selector);
                    NSString *args = [selector substringFromIndex:selector.length - 1];
                    if (args && [args isEqualToString:@":"])
                    {
                        for (int i = 0; i < [event.args count]; i++)
                        {
                            id arg = event.args[i];
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
    
    [self hideView];
}

#pragma mark - Remove notification
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark - Dealloc
- (void)dealloc
{    
    _ident = nil;
    _header = nil;
    _message = nil;
    _cancelEvent = nil;
    _otherEvents = nil;
    _delegate = nil;
    
    [self removeNotification];
}

@end
