//
//  Helpr.h
//  XM
//
//  Created by Macintosh HD on 16/4/16.
//  Copyright © 2016年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>   //网络请求wifi


typedef void (^SelectQuxiao)(void);

@interface Helpr : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (BOOL)BoolWithNum:(NSNumber *)num;

+ (void)Initialize;

+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate ;

+ (NSString *)getCurrentTime;

+ (NSString *)getCurrentTimeHHSSMM;

+ (NSString *)getCurrentTimeHHSS;

+(NSDictionary *)getCurTimer;

//将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString;
//获取wifi名称
+ (nullable NSString *)getWifiName;
/**
 *  删除 fromArray 中 toArray 包含的元素  例如 fromArray = @[@"1",@"2"]
 *
 *  @param fromArray Large arrays
 *  @param toArray   Small array
 *
 *  @return 数array
 */
+ (NSMutableArray *)arrayWith:(NSArray *)fromArray toArray:(NSArray *)toArray;

/**
 *  查找plist
 *
 *  @param str 文件名称
 *
 *  @return 类型
 */
+ (NSArray *)arraywithstr:(NSString *)str;

/*
 *   系统权限的提示框  
 */
+ (void)addPrefsAlertControllerMessage:(NSString *)message;
+ (void)addaddPrefsAlertControllerWiFiMessage:(NSString *)message;

+ (nullable UIAlertController *)addPrefsAlertMessage:(NSString *)message;

+ (void)addAlertViewMessage:(NSString *)message;
/*
 *   确认的提示框
 */
+ (void)setAlertControllermessage:(NSString *)message;
/*
 *   确认的提示框 并返回点击确认按钮
 */
+ (void)setAlertControllermessage:(NSString *)message  cancelAction:(nullable UIAlertAction *)cancelAction;
/*
 *   确认 取消的提示框 并返回点击确认按钮
 */
+ (void)setAlertControllermessage:(NSString *)message  cancelAction:(nullable UIAlertAction *)cancelAction otherAction:(nullable UIAlertAction *)otherAction;

+ ( id )readPlistName:(NSString * )plistName;

+ (void)dispatch_queue_t_timer:(int)timer send:(nullable void (^)(void))send;
+(void)dispatch_queue_t_send:(nullable void (^)(void))send;
//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (int)timeInterValWithTime:(NSString *)time;
//读取缓存大小  返回的是mb 大小
+ ( float )readCacheSize;
+ (void)clearFile;
//改变屏幕的亮度
+ (void)setBrightness:(float)value;



NS_ASSUME_NONNULL_END
@end
