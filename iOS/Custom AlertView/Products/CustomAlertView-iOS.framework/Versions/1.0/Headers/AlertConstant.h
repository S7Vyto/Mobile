//
//  AlertConstant.h
//  CustomAlertView
//
//  Created by Semyon Vyatkin on 24.11.14.
//  Copyright (c) 2014 prognoz. All rights reserved.
//

typedef enum : NSUInteger {
    DefaultAlertView,
    PasswordAlertView,
    ImageAlertView,
    TextAlertView,
} AlertViewType;

typedef enum : NSInteger {
    NoInternetConnection = 1,
    NotEnoughUserRights = 2,
} ErrorCodes;

typedef enum : NSUInteger {
    CancelButton,
    DoneButton,
} AlertByttonType;

