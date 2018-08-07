//
//  UIImageView+Help.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UIImageView+Help.h"

@implementation UIImageView (Help)

-(instancetype)initWithFrame:(CGRect)frame image:(nullable UIImage *)image
{
    if (self = [self initWithFrame:frame]) {
        if (image) {
            self.image = image;
        }else
        {
            self.image = [UIImage imageNamed:@"yoxi_icon"];
        }
    }
    return  self;
}

-(instancetype)initWithJnFrame:(CGRect)Jnframe image:(UIImage *)image
{
    return  [self initWithFrame:CGFrameWithJNFrame(Jnframe) image:image];
}
-(void)setimage:(nullable UIImage *)image withurl:(NSString *)url
{
    __block  UIActivityIndicatorView *activ = [UIImage downloadingImageActivityIndicatorView:CGRectMake(self.bounds.size.width/2-5,self.bounds.size.height/2-5 , 10, 10)];
    [self addSubview:activ];
    if (self.image == nil) {
        if (image) {
            self.image = image;
        }else {
             self.image = [UIImage imageNamed:@"yoxi_icon"];
        }
    }
    dispatch_queue_t  queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage *image = [UIImage setimageWithURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                self.image = image;
            }else
            {
                self.image = [UIImage imageNamed:@"yoxi_icon"];
            }

            [activ removeFromSuperview];
        });
    });
}

-(void)setimage:(nullable UIImage *)image withurl:(NSString *)url size:(CGSize)size
{
    __block  UIActivityIndicatorView *activ = [UIImage downloadingImageActivityIndicatorView:CGRectMake(self.bounds.size.width/2-5,self.bounds.size.height/2-5 , 10, 10)];
    [self addSubview:activ];
    if (self.image == nil) {
        if (image) {
            self.image = image;
        }else {
            // self.image = [UIImage imageNamed:UIIMAGEVIEW_ZHANWEIIMAGE];
        }
    }
    dispatch_queue_t  queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage *image = [UIImage setimageWithURL:url size:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                self.image = image;
            }else
            {
                self.image = [UIImage imageNamed:@""];
            }

            [activ removeFromSuperview];
        });
    });
}


-(void)setimageWithurl:(NSString *)url{
    [self setimage:[UIImage imageNamed:@""] withurl:url];
}

-(void )makeImageWithView:(UIView *)view
{
    self.image = [UIImage makeImageWithView:view withSize:self.bounds.size];
}

-(void)setgifImageUrl:(NSString *)url
{
    __block  UIActivityIndicatorView *activ = [UIImage downloadingImageActivityIndicatorView:CGRectMake(self.bounds.size.width/2-5,self.bounds.size.height/2-5 , 10, 10)];
    [self addSubview:activ];
    dispatch_queue_t queue = dispatch_queue_create("downimage", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // UIImage *image = [UIImage imageWithContentsOfFile:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            //创建webview 添加image
            UIWebView *webView = [self viewWithTag:20000];
            if (!webView) {
                webView = [[UIWebView alloc] initWithFrame:self.bounds];
                webView.tag = 20000;
                webView.scalesPageToFit = YES;
                webView.backgroundColor = [UIColor clearColor];
                webView.opaque = YES;
                [self addSubview:webView];
            }
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

            [activ removeFromSuperview];
        });
    });
}


@end
