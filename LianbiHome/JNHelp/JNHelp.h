//
//  JNHelp.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JNViewHelp.h"
#import "JNHelpMacro.h"

NS_ASSUME_NONNULL_BEGIN
@interface JNHelp : NSObject

FOUNDATION_EXPORT CGRect  CGFrameWithJNFrame(CGRect JNFrame);
FOUNDATION_EXPORT CGRect  JNFrameWithFrame(CGRect frame);

FOUNDATION_EXPORT double   CGNavView_h(void);
FOUNDATION_EXPORT double   CGNavView_20h(void);
FOUNDATION_EXPORT double   Tabbar_49h(void);
FOUNDATION_EXPORT double   CGSCREEN_HEIGHT(void);



//---------------------------------------------快速创建一个uiview------------------------------------------
FOUNDATION_EXPORT UIView * JnUIView(CGRect Frame,UIColor * BgColor);
FOUNDATION_EXPORT UIView * JNUIView(CGRect JNFrame,UIColor * BgColor);

FOUNDATION_EXPORT void JNViewStyle(UIView * view, float cornerRadius , UIColor * _Nullable corderColor , float BorderWidth);

//---------------------------------------------快速创建一个label------------------------------------------
FOUNDATION_EXPORT UILabel * JnLabel(CGRect Frame,NSString * _Nullable text,float fontSize,UIColor * _Nullable textColor , int index);

FOUNDATION_EXPORT UILabel * JNLabel(CGRect JNFrame,NSString * _Nullable text,float fontSize,UIColor * _Nullable textColor , int index);

FOUNDATION_EXPORT UILabel * JNLabelType(CGRect JNFrame,JNLabel_TYPE type,NSString * _Nullable text,int index);

FOUNDATION_EXPORT UILabel * JnLabelType(CGRect frame,JNLabel_TYPE type,NSString * _Nullable text,int index);

//---------------------------快速创建一个button-----------------------------------
//创建一个button
FOUNDATION_EXPORT UIButton * JNButton(CGRect JNFrame,NSString * _Nullable text , float fontSize,UIColor * textColor,UIColor * BgColor,id tager,SEL action);

FOUNDATION_EXPORT UIButton * JNButtonIndexSize(CGRect JNFrame,NSString * _Nullable text,float fontSize,UIColor * textColor,UIColor * BgColor, int index, id tager,SEL action);


FOUNDATION_EXPORT UIButton * JNButtonColorIndexSize(CGRect JNFrame,NSString * _Nullable text,float fontSize,UIColor * textColor,UIColor * BgColor, int index, id tager,SEL action,int tag);

FOUNDATION_EXPORT UIButton * JNButton_tag(CGRect JNFrame,UIColor * BgColor, id tager,SEL action,int tag);
FOUNDATION_EXPORT UIButton * JnButton_tag(CGRect frame,UIColor * BgColor, id tager,SEL action,int tag);

FOUNDATION_EXPORT UIButton * JnButtonColorIndexSize(CGRect Frame,NSString * _Nullable text , float fontSize,UIColor * textColor,UIColor * BgColor, int index, id tager,SEL action,int tag);


FOUNDATION_EXPORT UIButton * JnButtonImageTag(CGRect frame,UIImage * _Nullable image,id tager ,SEL action,int tag);

FOUNDATION_EXPORT UIButton * JNButtonImageTag(CGRect JNFrame,UIImage * _Nullable image,id tager ,SEL action,int tag);

FOUNDATION_EXPORT UIButton * JNButtonImageTagCornerRadius( CGRect JNFrame,UIImage * _Nullable image,id tager ,SEL action,int tag , float cornerRadius);
FOUNDATION_EXPORT  UIButton * JnButtonImageTagCornerRadius( CGRect frame,UIImage * _Nullable image,id tager ,SEL action , float cornerRadius);
FOUNDATION_EXPORT UIButton * JNButtonTextType(CGRect JNframe ,NSString * text , JNButton_TYPE  type ,id tager ,SEL action);
FOUNDATION_EXPORT UIButton * JnButtonTextType(CGRect frame ,NSString * text , JNButton_TYPE  type ,id tager ,SEL action);



//----------------------------------- UIScrollView --------------------------------
FOUNDATION_EXPORT UIScrollView * JNScrollView(CGRect JNFrame , UIColor * BgColor);

FOUNDATION_EXPORT UIScrollView * JnScrollViewDelegate(CGRect Frame , UIColor * BgColor ,BOOL ScrollIndicator,id <UIScrollViewDelegate> _Nullable delegate);

FOUNDATION_EXPORT UIScrollView * JnScrollView(CGRect Frame , UIColor * BgColor);

FOUNDATION_EXPORT UIScrollView * JNScrollViewDelegate(CGRect JNFrame , UIColor * BgColor , BOOL ScrollIndicator,id <UIScrollViewDelegate> _Nullable delegate);

//-------------------------------UIImageView---------------------------------------
FOUNDATION_EXPORT UIImageView * JnImageView(CGRect frame , UIImage * _Nullable image);

FOUNDATION_EXPORT UIImageView * JnImageViewCornerRadius(CGRect frame , UIImage * _Nullable image,float cornerRadius);

FOUNDATION_EXPORT UIImageView * JNImageViewCornerRadius(CGRect JNFrame , UIImage * _Nullable image,float cornerRadius);

FOUNDATION_EXPORT UIImageView * JNImageView(CGRect JNFrame , UIImage * _Nullable image);

//------------------------------UITextField------------------------------------------
FOUNDATION_EXPORT UITextField * JNTextFiled(CGRect Jnframe , NSString * placeholder , UITextBorderStyle borderStyle);
FOUNDATION_EXPORT UITextField * JnTextFiled(CGRect frame , NSString * placeholder , UITextBorderStyle borderStyle);
FOUNDATION_EXPORT UITextField * JnTextFiledColor(CGRect frame , NSString * placeholder , UITextBorderStyle borderStyle, UIColor * placeholderClolor );
FOUNDATION_EXPORT UITextField * JNTextFiledPassWord(CGRect Jnframe , NSString * placeholder , UITextBorderStyle borderStyle);
FOUNDATION_EXPORT UITextField * JnTextFiledPassWord(CGRect frame , NSString * placeholder , UITextBorderStyle borderStyle);

@end

NS_ASSUME_NONNULL_END
