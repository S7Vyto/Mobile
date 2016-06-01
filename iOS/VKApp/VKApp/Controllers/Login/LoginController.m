//
//  LoginController.m
//  VKApp
//
//  Created by Semyon Vyatkin on 22/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "LoginController.h"
#import "AuthService.h"
#import "AppDelegate.h"

@interface LoginController () <UIWebViewDelegate, AuthServiceDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) AuthService *authService;

@end

@implementation LoginController
@synthesize webView = _webView, authService = _authService;


#pragma mark - ControllerLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAppearance];
    [self setupWebView];
    [self setupAuthService];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_webView setDelegate:nil];
    [_webView stopLoading];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _authService.delegate = nil;
}

#pragma mark - SetupAppearance
- (void)setupAppearance {
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupWebView {
    [_webView setDelegate:self];
    [_webView setBackgroundColor:[UIColor clearColor]];
    
    [_webView.scrollView setContentInset:UIEdgeInsetsZero];
    [_webView.scrollView setBounces:NO];
    
    [_webView setOpaque:NO];
    [_webView setScalesPageToFit:YES];
    [_webView setClipsToBounds:NO];
}

#pragma mark - AuthServiceMethods
- (void)setupAuthService {
    self.authService = [AuthService new];
    
    [_authService setDelegate:self];    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [_authService requestAuthorization];
    });
}

- (IBAction)reloadAuthPage:(UIBarButtonItem *)sender {
    if ([_webView isLoading]) {
        [_webView stopLoading];
    }
    
    [_authService requestAuthorization];
}

#pragma mark - AuthServiceDelegate
- (void)didRequestUserAuthorization:(NSURLRequest *)authorizationRequest {
    if ([_webView isLoading]) {
        [_webView stopLoading];
    }
    
    [_webView loadRequest:authorizationRequest];
}

- (void)didUserAuthorizedWithStatus:(AuthStatus)authStatus {
    if (authStatus == AuthSuccess) {
        [self updateRootController];
    }
}

- (void)didUserLogout:(LogoutStatus)logoutStatus {
    if (logoutStatus == LogoutSuccess) {
        [self updateRootController];
    }
}

- (void)updateRootController {
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [app setupRootController];
}

#pragma mark - WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSURLRequest *request = [webView request];
    NSString *rawURL = [[request URL] absoluteString];
    
    if ([rawURL rangeOfString:@"access_token" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        [_authService confirmAuthorizationResponse:rawURL];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_webView stopLoading];
}

#pragma mark - AuthMethods

@end
