//
//  NSObject+Helpr.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helpr)
//方法交换
+ (BOOL)jn_hookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel;
+ (BOOL)jn_instancehookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel;

/**
 *  快速创建一个类 调用 alloc  init 方法
 *
 */
+(instancetype)sharedInstance;

/**
 *  获取当前类的 所有属性
 *  @return 数组
 */
- (NSArray *)getAllProperties;

@end
