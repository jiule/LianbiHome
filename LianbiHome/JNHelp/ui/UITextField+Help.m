//
//  UITextField+Help.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UITextField+Help.h"

@implementation UITextField (Help)


+(instancetype)TextFieldWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle {
    return [self TextFieldWithframe:frame placeholder:placeholder borderStyle:borderStyle placeholderColor:PLICEHOLDER_COLOR];
}


+(instancetype)TextFieldWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle placeholderColor:(UIColor *)placeholderColor
{
    UITextField  *useryanzhengma = [[UITextField alloc]initWithFrame:frame];
    useryanzhengma.keyboardType = UIKeyboardTypeDefault;
    useryanzhengma.borderStyle = borderStyle ;
//    useryanzhengma.leftViewMode = UITextFieldViewModeAlways;
    useryanzhengma.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    useryanzhengma.backgroundColor = [UIColor whiteColor];
    NSMutableAttributedString  * str = [[NSMutableAttributedString alloc]initWithString:placeholder];
    [str addAttribute:NSForegroundColorAttributeName value:placeholderColor range:NSMakeRange(0, str.length)];
    useryanzhengma.attributedPlaceholder = str ;
    useryanzhengma.font = [UIFont systemFontOfSize:JN_HH(14.5)] ;
    useryanzhengma.textColor = SXRGB16Color(0xb2b2b2) ;
    useryanzhengma.clearButtonMode = UITextFieldViewModeWhileEditing ;
    return useryanzhengma ;
}


+(instancetype)TextFieldWithJnframe:(CGRect)Jnframe placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle{
    return [self TextFieldWithframe:CGFrameWithJNFrame(Jnframe) placeholder:placeholder borderStyle:borderStyle];
}

//密码输入框
+(instancetype)TextFieldPassWordWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle{
    UITextField  *useryanzhengma = [self TextFieldWithframe:frame placeholder:placeholder borderStyle:borderStyle];
    useryanzhengma.secureTextEntry = YES;
    return useryanzhengma;
}
+(instancetype)TextFieldPassWordWithframe:(CGRect)frame placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle placeholderColor:(UIColor *)placeholderColor
{
    UITextField  *useryanzhengma = [self TextFieldWithframe:frame placeholder:placeholder borderStyle:borderStyle placeholderColor:placeholderColor];
    useryanzhengma.secureTextEntry = YES;
    return useryanzhengma;
}

+(instancetype)TextFieldPassWordJnframe:(CGRect)Jnframe placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle )borderStyle{
    return [self TextFieldPassWordWithframe:CGFrameWithJNFrame(Jnframe) placeholder:placeholder borderStyle:borderStyle];
}

@end
