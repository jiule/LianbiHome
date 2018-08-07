//
//  UIImage+Help.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define MYimageNamed(name)  [UIImage imageNamed:[NSString stringWithFormat:@"%@",name]]

@interface UIImage (Help)

/**
 *  根据url 下载图片 获取本地缓存  沙盒也没有图片
 *
 *  @param url 图片url
 *
 *  @return 返回图片
 */
+(nullable UIImage *)setimageWithURL:(NSString *)url;

+(nullable UIImage *)setimageWithURL:(NSString *)url size:(CGSize)size;
/**
 *  根据指定连接地址  删除图片
 *
 *  @param url 图片的地址
 */
+(void)removeimageWithURL:(NSString *)url;
+(void)removeimageWithURL:(NSString *)url size:(CGSize)size;
/**
 *  删除所有下载的图片
 */
+(void)removeAllimage;
/**
 *  系统图片缓冲图片  以url连接地址保持
 *
 *  @return 返回一个字典对象
 */
+(NSMutableDictionary  *)images;
/**
 *  判断一个data是不是图片类型
 */
+ (NSString *)sd_contentTypeForImageData:(NSData *)data;
/**
 *  正在下载图片的动作
 */
+(UIActivityIndicatorView *)downloadingImageActivityIndicatorView:(CGRect)frame;
+(UIActivityIndicatorView *)downLoad;
/**
 *  下载图片保存的沙盒地址
 */
+(NSString *)ImagePath;

@end
//----------------------------------------------
//
//     剪切图片
//----------------------------------------------
@interface UIImage (scale)
/*
 *剪切图片
 */
- (UIImage *)scaleImagetoSize:(CGSize)size;

/**
 * 把view根据比例 生成图片
 */
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;
/**
 * 把image方向不对 转正
 */
- (UIImage *)fixOrientation;

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage *)createImageWithColor:(UIColor *)color;

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius;
//加模糊效果，image是图片，radius是模糊度
+ (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image;
//识别二维码
-(NSString *)codeIdentify;

@end
NS_ASSUME_NONNULL_END
