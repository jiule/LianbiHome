//
//  NSDictionary+Helpr.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "NSDictionary+Helpr.h"

@implementation NSDictionary (Helpr)

+ (NSDictionary *)getTodayDate
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay|kCFCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond|kCFCalendarUnitWeekOfYear;

    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year  = [NSString stringWithFormat:@"%ld", (long)[components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld", (long)[components month]];
    NSString *day   = [NSString stringWithFormat:@"%02ld", (long)[components day]];
    NSString * hour = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
    NSString * min = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
    NSString * second = [NSString stringWithFormat:@"%02ld", (long)[components second]];
    NSString * weekOfYear = [NSString stringWithFormat:@"%02ld", (long)[components weekOfYear]];

    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    [todayDic setObject:hour forKey:@"hour"];
    [todayDic setObject:min forKey:@"min"];
    [todayDic setObject:second forKey:@"second"];
    [todayDic setObject:weekOfYear forKey:@"weekOfYear"];
    return todayDic;
}

@end
