//
//  UITextField+Help.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Help)

/*
 *  普通输入框
 */
+(instancetype)TextFieldWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle;
+(instancetype)TextFieldWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle placeholderColor:(UIColor *)placeholderColor;

+(instancetype)TextFieldWithJnframe:(CGRect)Jnframe placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle;

/*
 *  密码输入框
 */
+(instancetype)TextFieldPassWordWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle;
+(instancetype)TextFieldPassWordWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle placeholderColor:(UIColor *)placeholderColor;
+(instancetype)TextFieldPassWordJnframe:(CGRect)Jnframe placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle;

@end
