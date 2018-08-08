//
//  UIImageView+Help.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Help)
/**
 *  设置位子  图片
 *
 *  @param frame 位子
 *  @param image 图片
 *
 *  @return UIImageView
 */
-(instancetype)initWithFrame:(CGRect)frame image:(nullable UIImage *)image;
-(instancetype)initWithJnFrame:(CGRect)Jnframe image:(nullable UIImage *)image;
/**
 *  设置背景图片
 *
 *  @param image 展位图片
 *  @param url   图片地址
 */
-(void)setimage:(nullable UIImage *)image withurl:(NSString *)url;
-(void)setimage:(nullable UIImage *)image withurl:(NSString *)url size:(CGSize)size;
/**
 *  设置背景图片  默认站位图片
 *
 *  @param url 图片地址
 */
-(void)setimageWithurl:(NSString *)url;
/**
 *  设置背景图片  view截 成图片
 *
 */
-(void)makeImageWithView:(UIView *)view;
/**
 *  设置网络gif图片
 *
 */
-(void)setgifImageUrl:(NSString *)url;


-(void)setGifimageName:(NSString *)name;
@end
NS_ASSUME_NONNULL_END
