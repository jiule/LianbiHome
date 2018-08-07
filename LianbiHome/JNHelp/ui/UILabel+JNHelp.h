//
//  UILabel+JNHelp.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNColor.h"
#import "JNHelpMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (JNHelp)

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text;

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor;

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor textSize:(float)textSize index:(int)index;

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text type:(JNLabel_TYPE)type index:(int)index;


-(instancetype)initWithJNFrame:(CGRect)JnFrame text:(NSString *)text;
-(instancetype)initWithJNFrame:(CGRect)JnFrame text:(NSString *)text type:(JNLabel_TYPE)type index:(int)index;

/*
 * 这个是根据 x y w 来自动适配label的高度
 * 返回一个label
 */
+ (UILabel *)labelWithtext:(NSString *)text width:(float)width x:(float)x y:(float)y;
/*
 * line 行间距 para字间距
 */
+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font  Line:(float)line para:(float)para;
/*
 * line 行间距 para字间距
 */
-(void)setSpaceLine:(float)line para:(float)para;
/*
 * 获取label的高度  自定义行距 字间距
 */
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width Line:(float)line para:(float)para;

-(void)addTextArrays:(NSArray <NSString *>*)textArrays colorArrays:(NSArray <UIColor *>*)colorArrays numArrays:(NSArray <NSNumber *>*)numArrays up:(BOOL)up;

- (void)adjusts;
@end

NS_ASSUME_NONNULL_END
