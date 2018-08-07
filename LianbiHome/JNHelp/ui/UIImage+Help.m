//
//  UIImage+Help.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UIImage+Help.h"
#import "FileManager.h"

@implementation UIImage (Help)

//下载图片
+(nullable UIImage *)setimageWithURL:(NSString *)url{
    NSString * urlStr = url;
    NSData *data = [self images][urlStr];
    if (data) {
        return [UIImage imageWithData:data];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self ImagePath]])
    {
        NSFileManager * fileManager = [[NSFileManager alloc] init];
        [fileManager createDirectoryAtPath:[self ImagePath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //判断有没有文件路径 没有就创建
    NSString *filename = [NSString stringWithFormat:@"%@/%@",[self ImagePath],[urlStr lastPathComponent]];
    data = [NSData dataWithContentsOfFile:filename ];
    if (!data) {
       
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if (data == nil) {
            return nil;
        }
        if ([self sd_contentTypeForImageData:data] == nil) {
            return nil;
        }
        dispatch_queue_t   queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            if(  [data writeToFile:filename atomically:YES]){
                [self images][urlStr] = data;
            }
        });
    }else{
        [self images][urlStr] = data;
    }
    return [UIImage imageWithData:data];
}

+(UIImage *)setimageWithURL:(NSString *)url size:(CGSize)size
{
    NSData *data = [self images][url];
    if (data) {
        return [UIImage imageWithData:data];
    }
    //判断有没有文件路径 没有就创建
    NSString *filename = [NSString stringWithFormat:@"%@/%@",[self ImagePathWithSize:size],[self feilNameWithUrl:url]];
    [FileManager createDirectoryAtPath:filename];
    data = [NSData dataWithContentsOfFile:filename ];
    if (!data) {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (data == nil) {
            return nil;
        }
        if ([self sd_contentTypeForImageData:data] == nil) {
            return nil;
        }
        dispatch_queue_t   queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            if(  [data writeToFile:filename atomically:YES]){
                [self images][url] = data;
            }
        });
    }else{
        [self images][url] = data;
    }
    return [UIImage imageWithData:data];
}

//删除指定图片
+(void)removeimageWithURL:(NSString *)url
{
    NSString *filename = [NSString stringWithFormat:@"%@/%@",[self ImagePath],[self feilNameWithUrl:url]];
    [[NSFileManager defaultManager]removeItemAtPath:filename error:nil];
    [[self images ]removeObjectForKey:url];
}
+(void)removeimageWithURL:(NSString *)url size:(CGSize)size
{
    NSString *filename = [NSString stringWithFormat:@"%@/%@",[self ImagePathWithSize:size],[self feilNameWithUrl:url]];
    [[NSFileManager defaultManager]removeItemAtPath:filename error:nil];
    [[self images ]removeObjectForKey:url];
}

//删除全部图片
+(void)removeAllimage{
    [[NSFileManager defaultManager]removeItemAtPath:[self ImagePath] error:nil];
}
//缓存图片字典
+(NSMutableDictionary  *)images{
    static NSMutableDictionary * dict = nil;
    if (dict == nil) {
        dict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return dict;
}
//判断是不是图片
+ (NSString *)sd_contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            if ([data length] < 12) {
                return @"";
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            return @"";
    }
    return @"";
}
#pragma mark----下载图片的圈圈
+(UIActivityIndicatorView *)downloadingImageActivityIndicatorView:(CGRect)frame
{
    UIActivityIndicatorView *activ = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activ.frame = frame;
    activ.hidesWhenStopped = YES;
    [activ startAnimating];
    return activ;
}

+(UIActivityIndicatorView *)downLoad
{
    return   [self downloadingImageActivityIndicatorView:CGRectMake(SCREEN_WIDTH / 2 - 5,SCREEN_HEIGHT /  2 - 5 , 10, 10)];
}

+(NSString *)ImagePath
{
    return [FileManager imagePath];
}
+(NSString *)ImagePathWithSize:(CGSize)size
{
    NSString * path = [NSString stringWithFormat:@"%@/%d-%d",[self ImagePath],(int)size.width,(int)size.height];
    if ([FileManager createDirectoryAtPath:path]) {
        return path;
    }
    return nil;
}


+(NSString *)feilNameWithUrl:(NSString *)url
{
    return [url lastPathComponent];
}

@end

@implementation UIImage (scale)

- (UIImage *)scaleImagetoSize:(CGSize)size {
    if (self.size.width > size.width) {
        UIGraphicsBeginImageContext(size);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        return self;
    }
}
#pragma mark 生成image
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    //设置长宽
    CGRect rect = CGRectMake(0.0f, 0.0f, 5.0f, 5.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius
{
    UIImage *original = self;
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // 绘制图片
    [original drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image
{
    if (radius < 0) radius = 0;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}
-(NSString *)codeIdentify
{
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    //2. 扫描获取的特征组
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:self.CGImage]];
    if (features.count > 0) {
        //3. 获取扫描结果
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedResult = feature.messageString;
        return scannedResult;
    }
    return  nil;
}

/**
   *  根据CIImage生成指定大小的UIImage
   *
   *  @param image CIImage
   *  @param size  图片宽度
   */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
 {
         CGRect extent = CGRectIntegral(image.extent);
         CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

     // 1.创建bitmap;
         size_t width = CGRectGetWidth(extent) * scale;
         size_t height = CGRectGetHeight(extent) * scale;
         CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
         CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
         CIContext *context = [CIContext contextWithOptions:nil];
         CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
         CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
         CGContextScaleCTM(bitmapRef, scale, scale);
         CGContextDrawImage(bitmapRef, extent, bitmapImage);

         // 2.保存bitmap到图片
         CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
         CGContextRelease(bitmapRef);
         CGImageRelease(bitmapImage);
         return [UIImage imageWithCGImage:scaledImage];
}

@end

