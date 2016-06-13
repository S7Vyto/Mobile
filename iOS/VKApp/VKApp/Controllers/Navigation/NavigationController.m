//
//  NavigationController.m
//  VKApp
//
//  Created by Semyon Vyatkin on 22/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "NavigationController.h"
#import "AppDelegate.h"
#import "AuthService.h"
#import "UIViewController+ExtensionContoller.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAppearance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AuthMethods
- (IBAction)didTouchedLogout:(UIBarButtonItem *)sender {
    [[AuthService sharedInstance] deauthorizeUser];
}

- (void)didUserLogout:(LogoutStatus)logoutStatus {
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [app setupRootController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
