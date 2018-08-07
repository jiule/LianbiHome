//
//  UIKitAdditions.h
//  T1
//
//  Created by simon on 6/19/14.
//  Copyright (c) 2014 simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIKitAdditions : NSObject

/*
 * imageView快捷初始化方法
 */
+ (UIImageView *)imageViewWithImageName:(NSString *)name;

/*
 * button快捷初始化方法
 */
+ (UIButton *)buttonWithText:(NSString*)text backGroundColor:(UIColor*)bColor
                   textColor:(UIColor*)color
                    fontSize:(float)fontSize
                      target:(id)target
                    selector:(SEL)selector;

+ (UIButton *)buttonWithImage:(UIImage *)image
                highlightImage:(UIImage *)hiImage
                        target:(id)target
                    selector:(SEL)selector;
+ (UIButton *)buttonSetImage:(NSString *)imageName
                      target:(id)target
                    selector:(SEL)selector;
/*
 * label快捷初始化方法
 */
+ (UILabel*)labelWithText:(NSString*)text
                  fontSize:(float)fontSize;

+ (UILabel*)labelWithBlackText:(NSString*)text
                  fontSize:(float)fontSize;

+ (UILabel*)labelWithText:(NSString*)text
                 textColor:(UIColor*)textColor
                 alignment:(NSTextAlignment)alignment
                  fontSize:(float)fontSize;

+ (UILabel*)labelWithText:(NSString*)text leftTextColor:(UIColor*)leftColor rightTextColor:(UIColor*)rightColor fromIndex:(NSInteger)index fontSize:(float)fontSize;
+ (UILabel*)mutableLabel:(UILabel *)label content:(NSString*)text leftTextColor:(UIColor*)leftColor rightTextColor:(UIColor*)rightColor fromIndex:(NSInteger)index fontSize:(float)fontSize;

/*
 * 计算多行文字的高度
 */
+(float)calculateTextHeightWithFont:(UIFont*)font
                            content:(NSString*)content
                     constraintSize:(CGSize)constraintSize;

/*
 * 计算文本有几行文字
 */
+(int)calculateNumberOfLinesWithFont:(UIFont*)font content:(NSString*)content constraintSize:(CGSize)constraintSize;

/*
 * 计算单行文字的宽度
 * font:字体
 */
+(float)calculateTextWidthWithFont:(UIFont*)font
                           content:(NSString*)content;

/*
 * 计算单行文字的宽度
 * fontSize:系统字体大小
 */
+(float)calculateTextWidthWithSystemFontSize:(CGFloat)fontSize
                                     content:(NSString*)content;

@end



//////////////////////////////////////////////////
//一个为了计算文本高度的对象
@interface ObjectForTextCalculate : NSObject
@property(nonatomic,retain) UITextView *textView;
+ (ObjectForTextCalculate*) shared;
-(float)calculateTextHeightWithFont:(UIFont*)font content:(NSString*)content constraintSize:(CGSize)constraintSize;
@end
