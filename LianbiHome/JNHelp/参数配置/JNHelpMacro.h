//
//  JNHelpMacro.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#ifndef JNHelpMacro_h
#define JNHelpMacro_h

#import "JNViewHelp.h"



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)

#else

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#endif

#define SCREEN_JNWIDTH  360.000000
#define SCREEN_JNHEIGHT  667.00000

#define JN_HH(HH)    HH * SCREEN_WIDTH / SCREEN_JNWIDTH         //这个是适配的比例
#define JN_HHH(HH)   HH * SCREEN_JNWIDTH / SCREEN_WIDTH

#define JNVIEW_X0    JN_HH(14)
#define JNVIEW_X(HH) JN_HH((14+HH))
#define JNVIEW_W(HH) JN_HH((28+HH))

//-----------------------------------UIlabel--------------------------------------
//快速创建一个label的
typedef enum : NSUInteger
{
    UILABEL_0,        //默认  ……    文本显示的颜色
    UILABEL_1,        //文本显示   颜色 COLOR_BL_1   大小 UILABEL_BZ_1
    UILABEL_2,        //描述       COLOR_BL_2  UILABEL_BZ_2
    UILABEL_3,        //其他……
    UILABEL_4,        //白色字体
    UILABEL_5,
    UILABEL_6,
} JNLabel_TYPE;

//label上面字体颜色大小不一样
struct CGIndexColor {
    int startIndex;
    CGColorRef textColor;
    float textsize;
};

typedef   struct CGIndexColor CGIndexColor;

CG_INLINE CGIndexColor
CGIndexColorMake(int startIndex,CGColorRef textColor,float textsize)
{
    CGIndexColor CGIndexColor;
    CGIndexColor.startIndex = startIndex;
    CGIndexColor.textColor = textColor;
    CGIndexColor.textsize = textsize;
    return CGIndexColor ;
}

//快速创建一个label的 相关属性设置

#define UILABEL_INDEX 1                                         //UILABEL的文字默认位子

#define COLOR_BL_1             SXRGB16Color(0x4d4d4d)                //UILABEL_1的文字颜色    0
#define COLOR_BL_2         SXRGB16Color(0x4d4d4d)                 // UILABEL_2
#define COLOR_BL_3     SXRGB16Color(0xb3b3b3)                 //其他   4
#define COLOR_BL_4    SXRGB16Color(0xb3b3b3)              // 4
#define COLOR_BL_5    SXRGB16Color(0xb3b3b3)                 // 5
#define COLOR_BL_6    COLOR_B1                 // 1

#define UILABEL_BZ_1  JN_HH(18)                              //UILABEL_1的文字大小
#define UILABEL_BZ_2  JN_HH(15.5)                            //UILABEL_2 的字体大小
#define UILABEL_BZ_3  JN_HH(15.5)                       //其他
#define UILABEL_BZ_4  JN_HH(13.5)
#define UILABEL_BZ_5  JN_HH(13.5)
#define UILABEL_BZ_6  JN_HH(13.5)


//-----------------------------------UIButton--------------------------------------
typedef enum : NSUInteger
{
    Button_0,           //  Button_NORMAL_TEXTCOLOR , Button_NORMAL_BACKCOLOR
    Button_1,
    Button_2,
    Button_3,
} JNButton_TYPE;

#define Button_NORMAL_TEXTCOLOR  COLOR_WHITE   // 1
#define Button_NORMAL_BACKCOLOR  SXRGB16Color(0X539ccf)

#define Button_TEXT_TEXTCOLOR    SXRGB16Color(0X539ccf)      // 1
#define Button_TEXT_BACKCOLOR    COLOR_WHITE

#define Button_DESCRIBE_TEXTCOLOR  COLOR_WHITE
#define Button_DESCRIBE_BACKCOLOR  COLOR_A1

#define Button_DESCRIBE_TEXTCOLOR1 COLOR_A2
#define Button_DESCRIBE_BACKCOLOR1 [UIColor clearColor]

/*  这里是分割线的
 *  默认的分割线的颜色   DIVIDER_COLOR1
 *  默认的分割线的开始   X:DIVIDER_X  Y:view的高度 － DIVIDER_H  W: DIVIDER_W   H: DIVIDER_H
 */
#define DIVIDER_COLOR    SXRGB16Color(0Xb3b3b3)                       //分割线的颜色  输入框下面的颜色
#define DIVIDER_COLOR1   SXRGB16Color(0Xe5e5e5)                      //分割线的颜色  默认的颜色
#define DIVIDER_X       JN_HH(15)                      //分割线的默认x 开始位子
#define DIVIDER_H       1                              //分割线的默认高度
#define DIVIDER_W       [self getW] - DIVIDER_X        //分割线的宽度

#define DIVIDER_SPACING_H        JN_HH(10)           //控件之间的分割线
#define DIVIDER_SPACING_COLOR    DIVIDER_COLOR       //控件之间的分割线颜色

/*
 * uitextFild 提示字的默认颜色
 */
#define PLICEHOLDER_COLOR  SXRGB16Color(0Xb2b2b2)
#define TEXTVIEW_PLICEHOLDER_COLOR SXRGB16Color(0XC3C3C3)


#endif /* JNHelpMacro_h */
