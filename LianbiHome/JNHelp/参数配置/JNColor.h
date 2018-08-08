//
//  JNColor.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#ifndef JNColor_h
#define JNColor_h


#define SXRGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define SXRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define RGB_R(r,g,b) [UIColor colorWithRed:r/255.00 green:g/255.00 blue:b/255.00 alpha:1.0f]

#define COLOR_A1 SXRGB16Color(0xff7147)   //色调  蓝色  z1
#define COLOR_A2 SXRGB16Color(0X4d4d4d)   //色调  浅紫色  z2
#define COLOR_A3 SXRGB16Color(0XEC4C37)   //色调   z3
#define COLOR_A4 SXRGB16Color(0xbfbfca)   //色调   H1

#define COLOR_B1 SXRGB16Color(0X4C4C4C)    //用于重要级文字信息:大标题
#define COLOR_B2 SXRGB16Color(0Xa0a0a1)    //用户普通段落信息:小标题
#define COLOR_B3 SXRGB16Color(0X999999)    //用户辅助,次要的文字信息

#define COLOR_B4 SXRGB16Color(0XE5E5E5)    //分割线 用户tab控件底部
#define COLOR_B5 SXRGB16Color(0XEAEEF1)    //用户主页内容区域
#define COLOR_B6 SXRGB16Color(0Xf5f5f5)    //用户分割模块的底色  背景色

#define COLOR_T1 SXRGB16Color(0x8f8fae)   


#define COLOR_WHITE   [UIColor whiteColor]    //白色
#define COLOR_BLACK   [UIColor blackColor]    //黑色
#define COLOR_RED     [UIColor redColor]      //红色
#define COLOR_H1      SXRGB16Color(0Xbfbfca)  //
#define COLOR_H3      SXRGB16Color(0Xf1f2f6)  //


#define COLOR_W(h)  [COLOR_WHITE colorWithAlphaComponent:h]    //白色
#define COLOR_B(h)  [COLOR_BLACK colorWithAlphaComponent:h]    //黑色
#define COLOR_R(h)  [COLOR_RED colorWithAlphaComponent:h]    //黑色


#endif /* JNColor_h */
