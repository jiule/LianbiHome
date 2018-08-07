//
//  JNHelp.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "JNHelp.h"

@implementation JNHelp

FOUNDATION_EXPORT CGRect  CGFrameWithJNFrame(CGRect JNFrame)
{
    return [JNHelp frameWithJNFrame:JNFrame];
}

FOUNDATION_EXPORT CGRect  JNFrameWithFrame(CGRect frame)
{
    return [JNHelp SiziFrameWithframe:frame];
}

+(CGRect)SiziFrameWithframe:(CGRect)Frame{
    return CGRectMake(JN_HHH(Frame.origin.x), JN_HHH(Frame.origin.y), JN_HHH(Frame.size.width), JN_HHH(Frame.size.height));
}

+(CGRect)frameWithJNFrame:(CGRect)Frame{
    return CGRectMake(JN_HH(Frame.origin.x), JN_HH(Frame.origin.y), JN_HH(Frame.size.width), JN_HH(Frame.size.height));
}

FOUNDATION_EXPORT  double   CGNavView_h(void){
    if (isIPhoneX)
        return 88;
    return 64 ;
}

FOUNDATION_EXPORT  double   CGNavView_20h(void){
    if (isIPhoneX)
        return 44;
    return 20 ;
}

FOUNDATION_EXPORT  double   Tabbar_49h(void){
    if (isIPhoneX)
        return 83;
    return 49;
}

FOUNDATION_EXPORT double   CGSCREEN_HEIGHT(void)
{
    if (isIPhoneX)
        return SCREEN_HEIGHT - 49;
    return SCREEN_HEIGHT;
}
//---------------------------------------------快速创建一个uiview------------------------------------------
FOUNDATION_EXPORT UIView * JnUIView(CGRect Frame,UIColor * BgColor){
    return [[UIView alloc]initWithFrame:Frame BgColor:BgColor];
}

FOUNDATION_EXPORT UIView * JNUIView(CGRect JNFrame,UIColor * BgColor){
    return [[UIView alloc]initWithSizi_Frame:JNFrame BgColor:BgColor];
}

//---------------------------------------------快速创建一个label------------------------------
FOUNDATION_EXPORT UILabel * JnLabel(CGRect Frame,NSString * _Nullable text,float fontSize,UIColor * _Nullable textColor , int index){
    return [[UILabel alloc]initWithFrame:Frame text:text textColor:textColor textSize:fontSize index:index];
}

FOUNDATION_EXPORT UILabel * JNLabel(CGRect JNFrame,NSString * _Nullable text,float fontSize,UIColor * _Nullable textColor , int index){
    return [[UILabel alloc]initWithFrame:CGFrameWithJNFrame(JNFrame) text:text textColor:textColor textSize:fontSize index:index];
}

FOUNDATION_EXPORT UILabel * JNLabelType(CGRect JNFrame,JNLabel_TYPE type,NSString *   text,int index){
    return [[UILabel alloc]initWithJNFrame:JNFrame text:text type:type index:index];
}
FOUNDATION_EXPORT UILabel * JnLabelType(CGRect frame,JNLabel_TYPE type,NSString * _Nullable text,int index)
{
    return [[UILabel alloc]initWithFrame:frame text:text type:type index:index];
}

//---------------------------快速创建一个button-----------------------------------
FOUNDATION_EXPORT UIButton * JNButton(CGRect JNFrame,NSString * _Nullable text , float fontSize,UIColor * textColor,UIColor * BgColor,id tager,SEL action){
    return [[UIButton alloc]initWithJnFrame:JNFrame text:text textColor:textColor bgColor:BgColor textsize:fontSize Target:tager action:action];
}

FOUNDATION_EXPORT UIButton * JNButtonIndexSize(CGRect JNFrame,NSString * _Nullable text,float fontSize,UIColor * textColor,UIColor * BgColor, int index, id tager,SEL action){
    UIButton * btn = [[UIButton alloc]initWithJnFrame:JNFrame text:text textColor:textColor bgColor:BgColor textsize:fontSize Target:tager action:action];
    if (index == 0) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    }else if(index == 2)
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight ;
    }else {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    }
    return btn;
}

FOUNDATION_EXPORT UIButton * JNButtonColorIndexSize(CGRect JNFrame,NSString * _Nullable text,float fontSize,UIColor * textColor,UIColor * BgColor, int index, id tager,SEL action,int tag){
    UIButton * btn = JNButtonIndexSize(JNFrame, text, fontSize, textColor, BgColor, index, tager, action);
    btn.tag = tag;
    return  btn;
}

FOUNDATION_EXPORT UIButton * JNButton_tag(CGRect JNFrame,UIColor * BgColor, id tager,SEL action,int tag){
    UIButton * btn = [[UIButton alloc]initWithJnFrame:JNFrame text:nil Target:tager action:action];
    [btn setBackgroundColor:BgColor];
    btn.tag = tag;
    return btn;
}
FOUNDATION_EXPORT UIButton * JnButton_tag(CGRect frame,UIColor * BgColor, id tager,SEL action,int tag)
{
    return JNButton_tag(JNFrameWithFrame(frame), BgColor, tager, action, tag);
}

FOUNDATION_EXPORT UIButton * JnButtonColorIndexSize(CGRect Frame,NSString * _Nullable text , float fontSize,UIColor * textColor,UIColor * BgColor, int index, id tager,SEL action,int tag){
    return JNButtonColorIndexSize(JNFrameWithFrame(Frame), text, fontSize, textColor, BgColor, index, tager, action, tag);
}

FOUNDATION_EXPORT UIButton * JnButtonImageTag(CGRect frame,UIImage * _Nullable image,id tager ,SEL action,int tag){
    UIButton * btn = [[UIButton alloc]initWithFrame:frame backImage:image Target:tager action:action];
    btn.tag = tag ;
    return  btn;
}


FOUNDATION_EXPORT UIButton * JNButtonImageTag(CGRect JNFrame,UIImage * _Nullable  image,id tager ,SEL action ,int tag){
    return JnButtonImageTag(CGFrameWithJNFrame(JNFrame), image, tager, action, tag);

}

FOUNDATION_EXPORT UIButton * JNButtonImageTagCornerRadius( CGRect JNFrame,UIImage * _Nullable image,id tager ,SEL action,int tag , float cornerRadius){
    UIButton * btn = [[UIButton alloc]initWithFrame:CGFrameWithJNFrame(JNFrame) backImage:image Target:tager action:action];
    btn.tag = tag ;
    btn.layer.cornerRadius = JN_HH(cornerRadius);
    btn.clipsToBounds = YES;
    return  btn;
}

FOUNDATION_EXPORT  UIButton * JnButtonImageTagCornerRadius( CGRect frame,UIImage * _Nullable image,id tager ,SEL action , float cornerRadius){
    UIButton * btn = [[UIButton alloc]initWithFrame:frame backImage:image Target:tager action:action];
    btn.layer.cornerRadius = cornerRadius;
    btn.clipsToBounds = YES;
    return  btn;
}

FOUNDATION_EXPORT UIButton * JNButtonTextType(CGRect JNframe ,NSString * text , JNButton_TYPE  type ,id tager ,SEL action)
{
    return JnButtonTextType(CGFrameWithJNFrame(JNframe), text, type, tager, action);
}
FOUNDATION_EXPORT UIButton * JnButtonTextType(CGRect frame ,NSString * text , JNButton_TYPE  type ,id tager ,SEL action)
{
    return [[UIButton alloc]initWithFrame:frame text:text type:type Target:tager action:action];
}

FOUNDATION_EXPORT void JNViewStyle(UIView * view, float cornerRadius , UIColor * corderColor , float BorderWidth){
    [view setCornerRadius:cornerRadius BorderColor:corderColor BorderWidth:BorderWidth];
}

FOUNDATION_EXPORT UIScrollView * JNScrollView(CGRect JNFrame , UIColor * BgColor){
    return JnScrollViewDelegate(CGFrameWithJNFrame(JNFrame), BgColor, NO ,nil);
}

FOUNDATION_EXPORT UIScrollView * JnScrollViewDelegate(CGRect Frame , UIColor * BgColor ,BOOL ScrollIndicator ,id <UIScrollViewDelegate>delegate){
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:Frame BgColor:BgColor];
    scrollView.showsVerticalScrollIndicator = ScrollIndicator ;
    scrollView.showsHorizontalScrollIndicator = ScrollIndicator;
//    if (delegate) {
//        scrollView.delegate = delegate;
//    }
    return scrollView ;
}

FOUNDATION_EXPORT UIScrollView * JnScrollView(CGRect Frame , UIColor * BgColor){
    return JnScrollViewDelegate(Frame, BgColor, NO,nil);
}

FOUNDATION_EXPORT UIScrollView * JNScrollViewDelegate(CGRect JNFrame , UIColor * BgColor  ,BOOL ScrollIndicator ,id <UIScrollViewDelegate>delegate){
    return JnScrollViewDelegate(CGFrameWithJNFrame(JNFrame), BgColor, ScrollIndicator,delegate);
}
//----------------------------uiimageview-------------------------------------
FOUNDATION_EXPORT UIImageView * JnImageView(CGRect frame,UIImage * _Nullable image){
    return [[UIImageView alloc]initWithFrame:frame image:image];
}

FOUNDATION_EXPORT UIImageView * JnImageViewCornerRadius(CGRect frame , UIImage * _Nullable image,float cornerRadius){
    UIImageView * imageView = JnImageView(frame, image);
    imageView.layer.cornerRadius = cornerRadius;
    imageView.clipsToBounds = YES;
    return imageView;
}

FOUNDATION_EXPORT UIImageView * JNImageViewCornerRadius(CGRect JNFrame , UIImage * _Nullable image,float cornerRadius){
    return JnImageViewCornerRadius(CGFrameWithJNFrame(JNFrame), image, JN_HH(cornerRadius));
}

FOUNDATION_EXPORT UIImageView * JNImageView(CGRect JNFrame,UIImage * _Nullable image){
    return JnImageView(CGFrameWithJNFrame(JNFrame), image);
}
//----------------------- 创建一个uitextfield
FOUNDATION_EXPORT UITextField * JNTextFiled(CGRect Jnframe , NSString * placeholder , UITextBorderStyle borderStyle)
{
    return JnTextFiled(CGFrameWithJNFrame(Jnframe), placeholder, borderStyle);
}
FOUNDATION_EXPORT UITextField * JnTextFiled(CGRect frame , NSString * placeholder , UITextBorderStyle borderStyle)
{
    return [UITextField TextFieldWithframe:frame placeholder:placeholder borderStyle:borderStyle];
}
FOUNDATION_EXPORT UITextField * JnTextFiledColor(CGRect frame , NSString * placeholder , UITextBorderStyle borderStyle, UIColor * placeholderClolor )
{
    return [UITextField TextFieldWithframe:frame placeholder:placeholder borderStyle:borderStyle placeholderColor:placeholderClolor];
}
FOUNDATION_EXPORT UITextField * JNTextFiledPassWord(CGRect Jnframe , NSString * placeholder , UITextBorderStyle borderStyle)
{
    return JnTextFiledPassWord(CGFrameWithJNFrame(Jnframe), placeholder, borderStyle);
}
FOUNDATION_EXPORT UITextField * JnTextFiledPassWord(CGRect frame , NSString * placeholder , UITextBorderStyle borderStyle)
{
    return [UITextField TextFieldPassWordWithframe:frame placeholder:placeholder borderStyle:borderStyle];
}
@end
