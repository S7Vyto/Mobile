//
//  PreferencesService.h
//  VKApp
//
//  Created by Semyon Vyatkin on 24/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const PSAuthorizationData;

@interface PreferencesService : NSObject

+ (instancetype)sharedInstance;
- (void)deleteCookieWithDomain:(NSString *)domain;
- (void)updateData:(id)data withKey:(NSString *)key;
- (id)loadDataWithKey:(NSString *)key;

@end
