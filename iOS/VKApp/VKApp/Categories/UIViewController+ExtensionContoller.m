//
//  UIViewController+ExtensionContoller.m
//  VKApp
//
//  Created by Semyon Vyatkin on 01/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "UIViewController+ExtensionContoller.h"

@implementation UIViewController (ExtensionContoller)

- (void)setupAppearance {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end
