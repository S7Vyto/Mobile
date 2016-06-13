//
//  UIViewController+ExtensionContoller.m
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "UIViewController+ExtensionContoller.h"
#import "ThemeService.h"

@implementation UIViewController (ExtensionContoller)

- (void)setupAppearance {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self setupTabBarColors];
    [self setupTabBarColors];
    [self setupNavigationBarColors];
    [self setupBackgroundColor];
}

- (void)setupBackgroundColor {
     self.view.backgroundColor = [ThemeService controllerBackgroundColor];
}

- (void)setupNavigationBarColors {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [ThemeService navigationBarBackgroundColor];
    self.navigationController.navigationBar.tintColor = [ThemeService navigationBarTintColor];
}

- (void)setupToolBarColors {
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.translucent = YES;
    self.navigationController.toolbar.barTintColor = [ThemeService navigationBarBackgroundColor];
    self.navigationController.toolbar.tintColor = [ThemeService navigationBarTintColor];
}

- (void)setupTabBarColors {
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.tabBarController.tabBar.translucent = YES;
    self.tabBarController.tabBar.barTintColor = [ThemeService navigationBarBackgroundColor];
    self.tabBarController.tabBar.tintColor = [ThemeService navigationBarTintColor];
}

@end
