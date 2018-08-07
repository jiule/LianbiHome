//
//  UIButton+Help.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@interface UIButton (Help)

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text Target:(nullable id)target action:(nullable SEL)action;

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor bgColor:(nullable UIColor *)bgColor  textsize:(float)textsize Target:(nullable id)target action:(nullable SEL)action;


-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text type:(JNButton_TYPE)type Target:(nullable id)target action:(nullable SEL)action;

-(instancetype)initWithJnFrame:(CGRect)Jnframe text:(nullable NSString *)text type:(JNButton_TYPE)type Target:(nullable id)target action:(nullable SEL)action;

-(instancetype)initWithJnFrame:(CGRect)Jnframe text:(nullable NSString *)text Target:(nullable id)target action:(nullable SEL)action;

-(instancetype)initWithJnFrame:(CGRect)Jnframe text:(nullable NSString *)text textColor:(nullable UIColor *)textColor bgColor:(nullable UIColor *)bgColor  textsize:(float)textsize Target:(nullable id)target action:(nullable SEL)action;

-(instancetype)initWithFrame:(CGRect)frame backImage:(nullable UIImage *)backImage Target:(nullable id)target action:(nullable SEL)action;
-(instancetype)initWithJnFrame:(CGRect)Jnframe backImage:(nullable UIImage *)backImage Target:(nullable id)target action:(nullable SEL)action;


@end

@interface UIButton (Image)
/**
 *  设置背景图片 保持沙盒 缓存
 *
 *  @param image 占位图片
 *  @param url   图片地址
 */
-(void)setBackgroundImage:(nullable UIImage *)image withUrl:(NSString *)url;
-(void)setBackgroundImage:(UIImage *)image withUrl:(NSString *)url size:(CGSize)size;
/**
 *  设置背景图片 保存沙盒  缓存  默认展位图片
 *
 *  @param url 图片地址
 */
-(void)setBackimageWithUrl:(NSString *)url;

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled withtimer:(int)timer;
@end


NS_ASSUME_NONNULL_END
