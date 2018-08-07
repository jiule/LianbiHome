//
//  MyUserDefaultsManager.m
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//

#import "MyUserDefaultsManager.h"

@interface MyUserDefaultsManager () 

@end

@implementation MyUserDefaultsManager

XMGSingletoM
//保存值
-(void)setObject:(nullable id)value forKey:(NSString *)defaultName
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:value forKey:defaultName];
    [df synchronize];
}
+(void)setObject:(nullable id)value forkey:(NSString *)defaultName
{
    [[MyUserDefaultsManager sharedInstance]setObject:value forKey:defaultName];
}
//取值
-(nullable id)objectForKey:(NSString *)defaultName
{
     NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    return  [df objectForKey:defaultName];
}
+(nullable id)objectForKey:(NSString *)defaultName
{
    return [[MyUserDefaultsManager sharedInstance]objectForKey:defaultName];
}
-(void)removeKey:(NSString *)defaultName{
     NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df removeObjectForKey:defaultName];
    [df synchronize];
}
+(void)removeKey:(NSString *)defaultName
{
    [[MyUserDefaultsManager sharedInstance]removeKey:defaultName];
}


@end
