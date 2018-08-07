//
//  UITextView+Help.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


typedef struct UIPlaceInsets {
    CGFloat left ,top, right, bottom ;  //placeholderLabel 到指定边缘的距离
} UIPlaceInsets;

UIKIT_STATIC_INLINE UIPlaceInsets UIPlaceInsetsMake( CGFloat left, CGFloat top, CGFloat right, CGFloat bottom) {
    UIPlaceInsets insets = {left ,top, right, bottom};
    return insets;
}

@interface UITextView (Help)


-(instancetype)initWithfram:(CGRect)fram placeholder:(NSString *)placeholder;
-(instancetype)initWithJNFrame:(CGRect)fram placeholder:(NSString *)placeholder;

XH_ATTRIBUTE_NSSTRING(placeholder);
XH_ATTRIBUTE_RETURN(UILabel, placeholderLabel);

XH_ATTRIBUTE_NSSTRING(titleholder);
XH_ATTRIBUTE_RETURN(UILabel, titlederLabel);

-(void)setPlaceholderLabelWithPlaceInsets:(UIPlaceInsets)placeInsets;

-(void)dw_setTitlederText:(NSString *)text;




@end

NS_ASSUME_NONNULL_END
