//
//  Helpr.m
//  XM
//
//  Created by Macintosh HD on 16/4/16.
//  Copyright © 2016年 XM. All rights reserved.
//
#import "Helpr.h"




@implementation Helpr

+(BOOL)BoolWithNum:(NSNumber *)num
{
    if ([num intValue] == 0) {
        return NO;
    }
        return YES ;
}

+(void)Initialize
{
    [[Listeningkeyboard sharedInstance] startlistening];  //初始化键盘的监听


}

+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+(NSString *)getCurrentTimeHHSSMM
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+(NSString *)getCurrentTimeHHSS
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
+(NSDictionary *)getCurTimer
{
    return  [NSDictionary getTodayDate];
}

//将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)getWifiName
{
    NSString * wifiName ;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        [self addPrefsAlertControllerMessage:@"没有开启wifi请开启"];
        return wifiName;
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
           // NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return wifiName;
}


+(NSMutableArray *)arrayWith:(NSArray *)fromArray toArray:(NSArray *)toArray
{
    NSMutableArray * retuArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < fromArray.count; i++) {
        //添加每一个元素
        [retuArray addObject:fromArray[i]];
        for (int j = 0 ; j<toArray.count; j++) {
            //判断小元素有没有这个对象
            if ([fromArray[i] isEqual:toArray[j]]) {
                //有就删除这个对象
                [retuArray removeObject:fromArray[i]];
            }
        }
    }
    return  retuArray;
}

+(NSArray *)arraywithstr:(NSString *)str
{
    NSString *plistPath=[[NSBundle mainBundle] pathForResource:str  ofType:@"plist"];
    return  [NSArray arrayWithContentsOfFile:plistPath];
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"       //方法弃用
+(void)addPrefsAlertControllerMessage:(NSString *)message
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [self setAlertControllermessage:message cancelAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication  sharedApplication] openURL:url options:@{@"prefs":self} completionHandler:nil];
            }
        }] otherAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
    }else
    {
        [self addAlertViewMessage:message];
    }
}

+(void)addaddPrefsAlertControllerWiFiMessage:(NSString *)message
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [self setAlertControllermessage:message cancelAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) {
                [[UIApplication  sharedApplication] openURL:url options:@{} completionHandler:nil];
            }else {
                [[UIApplication  sharedApplication] openURL:url];
            }
        }] otherAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
    }else
    {
        [self addAlertViewMessage:message];
    }
}
#pragma clang diagnostic pop

+(UIAlertController *)addPrefsAlertMessage:(NSString *)message
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [self setAlertControllermessage:message cancelAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication  sharedApplication] openURL:url options:@{@"prefs":self} completionHandler:nil];
            }
        }] otherAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication  sharedApplication] openURL:url options:@{@"prefs":self} completionHandler:nil];
                }
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }]];
        return alertController;
        
    }else
    {
        [self addAlertViewMessage:message];
        return  nil ;
    }
    return  nil;
}

+(void)addAlertViewMessage:(NSString *)message
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"       //方法弃用
    UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [view show];
#pragma clang diagnostic pop
}
+(void)setAlertControllermessage:(NSString *)message{
    [self setAlertControllermessage:message cancelAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
}

+(void)setAlertControllermessage:(NSString *)message  cancelAction:(nullable UIAlertAction *)cancelAction
{
    [self setAlertControllermessage:message cancelAction:cancelAction otherAction:nil];
}

+(void)setAlertControllermessage:(NSString *)message  cancelAction:(nullable UIAlertAction *)cancelAction otherAction:(nullable UIAlertAction *)otherAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelAction) {
        [alertController addAction:cancelAction];
    }
    if (otherAction) {
        [alertController addAction:otherAction];
    }
    
    [[UIViewController getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}

+(id)readPlistName:(NSString *)plistName
{
    NSString *plistPath=[[NSBundle mainBundle] pathForResource:plistName  ofType:@"plist"];
    id json = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    if (json == nil) {
        json = [NSArray arrayWithContentsOfFile:plistPath];
    }
    return json;
}

+(void)dispatch_queue_t_timer:(int)timer send:(nullable void (^)(void))send
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        sleep(timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (send) {
                send();
            }
        });
    });
}

+(void)dispatch_queue_t_send:(nullable void (^)(void))send
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
            if (send) {
                send();
            }
    });
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+(int)timeInterValWithTime:(NSString *)time
{
    NSString * timeStr = time;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate * date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
   // MyLog(@"date====%@",timeStr);
   // NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
  //  NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
    return [date timeIntervalSinceNow];

}

+( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}

+ ( float ) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
}
+ ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

+ (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
}

+(void)setBrightness:(float)value
{
     [[UIScreen mainScreen] setBrightness: value];
}


@end
