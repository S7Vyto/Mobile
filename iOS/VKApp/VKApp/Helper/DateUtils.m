//
//  DateUtils.m
//  VKApp
//
//  Created by Semyon Vyatkin on 08/06/16.
//  Copyright © 2016 Semyon-Vyatkin. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSCalendar *)currentCalendar {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    calendar.locale = [NSLocale currentLocale];
    
    return calendar;
}

+ (NSDateFormatter *)dateFormatterWith:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [NSLocale currentLocale];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = format;
    
    return formatter;
}

+ (NSTimeInterval)currentUnixTime {
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSString *)dateUnixTime:(NSTimeInterval)timeInterval withDateFormat:(NSString *)dateFormat {
    NSDate *sourceDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [self dateFormatterWith:dateFormat];
    
    return [formatter stringFromDate:sourceDate];
}

@end
