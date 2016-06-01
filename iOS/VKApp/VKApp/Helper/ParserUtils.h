//
//  ParserUtils.h
//  VKApp
//
//  Created by Semyon Vyatkin on 30/05/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserUtils : NSObject

+ (NSDictionary *)parseAuthorizationResponse:(NSString *)response;

@end
