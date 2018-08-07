//
//  UITextView+Help.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UITextView+Help.h"

@implementation UITextView (Help)

+(void)load
{
    if ( ![self jn_hookOrigMenthod:@selector(initWithFrame:) NewMethod:@selector(RunTime_initWithFrame:)]) {
        NSLog(@"uitextView 方法交换失败");
            Method InitWith = class_getInstanceMethod(self, @selector(initWithFrame:));
            Method RunTime_initWith = class_getInstanceMethod(self, @selector(RunTime_initWithFrame:));
            method_exchangeImplementations(InitWith, RunTime_initWith);
    }
    if (![self jn_hookOrigMenthod:@selector(isSelectable) NewMethod:@selector(HK_isSelectable)]) {
          NSLog(@"uitextView 方法交换失败");
            Method viewWill = class_getInstanceMethod(self, @selector(isSelectable));
            Method HK_viewWill = class_getInstanceMethod(self, @selector(HK_isSelectable));
            method_exchangeImplementations(viewWill, HK_viewWill);  //交换成功
    }
}

-(instancetype)RunTime_initWithFrame:(CGRect)frame
{
    if (self == [self RunTime_initWithFrame:frame]) {
     //   NSLog(@"asdfasdfsdf");
        self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, JN_HH(7), frame.size.width,[NSString heightOfString:self.placeholder font:[UIFont systemFontOfSize:JN_HH(14)] width:frame.size.width])];
        self.placeholderLabel.text = self.placeholder;
        self.placeholderLabel.font = [UIFont systemFontOfSize:JN_HH(16)];
        self.placeholderLabel.textColor = TEXTVIEW_PLICEHOLDER_COLOR ;
        self.placeholderLabel.numberOfLines = 0;
        [self addSubview:self.placeholderLabel];
    }
    return self;
}

-(instancetype)initWithfram:(CGRect)fram placeholder:(NSString *)placeholder
{
    self.placeholder = placeholder;
    return [self initWithFrame:fram] ;
}

-(instancetype)initWithJNFrame:(CGRect)fram placeholder:(NSString *)placeholder
{
    return [self initWithfram:CGFrameWithJNFrame(fram) placeholder:placeholder];
}

-(void)setPlaceholderLabelWithPlaceInsets:(UIPlaceInsets)placeInsets
{
    self.placeholderLabel.frame = CGRectMake(placeInsets.right, placeInsets.top, self.bounds.size.width - placeInsets.right - placeInsets.right, self.bounds.size.height - placeInsets.bottom - placeInsets.top);
}

-(BOOL)HK_isSelectable
{
    if (self.text.length > 0) {
        self.placeholderLabel.alpha = 0;
    }else {
        self.placeholderLabel.alpha = 1;
    }
    return  [self HK_isSelectable];
}

-(void)dw_setTitlederText:(NSString *)text
{
    self.titleholder = text ;
    [self.titlederLabel removeFromSuperview];
    self.titlederLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, [self getH] - 25, [self getW] - 20, 20)];
    self.titlederLabel.textColor = COLOR_B4;
    self.titlederLabel.text = text;
    self.titlederLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.titlederLabel];
}

XM_SEL(OBJC_ASSOCIATION_RETAIN_NONATOMIC, UILabel, placeholderLabel,PlaceholderLabel)
XM_SEL(OBJC_ASSOCIATION_COPY_NONATOMIC, NSString, placeholder,Placeholder)

XM_SEL(OBJC_ASSOCIATION_RETAIN_NONATOMIC, UILabel, titlederLabel,TitlederLabel)
XM_SEL(OBJC_ASSOCIATION_COPY_NONATOMIC, NSString, titleholder,Titleholder)

@end
