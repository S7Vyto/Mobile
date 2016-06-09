//
//  SpinnerView.m
//  VKApp
//
//  Created by Semyon Vyatkin on 08/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "SpinnerView.h"

@implementation SpinnerView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        self.userInteractionEnabled = NO;
        self.tag = 10001;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
}

@end
