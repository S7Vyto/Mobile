//
//  LoginController.m
//  VKApp
//
//  Created by Semyon Vyatkin on 22/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "LoginController.h"
#import "AuthService.h"

@interface LoginController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LoginController
@synthesize webView = _webView;


#pragma mark - ControllerLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_webView stopLoading];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - SetupAppearance
- (void)setupWebView {
    [_webView stopLoading];
    [_webView loadRequest:[self requestAuthorizationURL]];
}

- (NSURLRequest *)requestAuthorizationURL {
    return [[AuthService sharedInstance] requestAuthorization];
}

@end
