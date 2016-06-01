//
//  AppDelegate.m
//  VKApp
//
//  Created by Semyon Vyatkin on 22/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthService.h"
#import "StoryboardFactory.h"

@class LoginController;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootController];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupRootController {
    if (self.window == nil) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    AuthService *authService = [AuthService new];
    UIViewController *sourceController = self.window.rootViewController;
    UIViewController *destinationController = nil;
    
    if ([authService isUserAuthorized]) {
        destinationController = [StoryboardFactory rootController:MainStoryboard];
    }
    else {
        destinationController = [StoryboardFactory rootController:LoginStoryboard];
    }
    
    [UIView transitionFromView:sourceController.view
                        toView:destinationController.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        [self.window setRootViewController:destinationController];
                        [self.window makeKeyAndVisible];
                    }];
}

@end
