//
//  MyUserDefaultsManager.h
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//




#define kEXPERSFILTERING_LISHI_ARRAY  @"LISHI_ARRAY_KEY"

#import <Foundation/Foundation.h>
#import "Danli.h"


NS_ASSUME_NONNULL_BEGIN
@interface MyUserDefaultsManager : NSObject 

XMGSingletoH

/**
 *  插入一个对象到 NSUserDefaults
 *
 *  @param value       值
 *  @param defaultName 键
 */
-(void)setObject:(nullable id)value forKey:(NSString *)defaultName;
+(void)setObject:(nullable id)value forkey:(NSString *)defaultName;
/**
 *  取 NSUserDefaults 对应的 defaultName 值
 *
 *  @param defaultName 建名称
 */
-(nullable id)objectForKey:(NSString *)defaultName;
+(nullable id)objectForKey:(NSString *)defaultName;
/**
 *  删除保存的值
 *
 *  @param defaultName nil
 */
-(void)removeKey:(NSString *)defaultName;
+(void)removeKey:(NSString *)defaultName;


NS_ASSUME_NONNULL_END
@end
