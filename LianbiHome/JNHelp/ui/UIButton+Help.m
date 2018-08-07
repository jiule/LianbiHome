//
//  UIButton+Help.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UIButton+Help.h"

@implementation UIButton (Help)

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text Target:(nullable id)target action:(nullable SEL)action
{
    self = [self initWithFrame:frame];
    if (self) {
        [self setTitle:text forState:0];
        if (target && action) {
            [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
        return self;
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(nullable UIColor *)textColor bgColor:(nullable UIColor *)bgColor  textsize:(float)textsize Target:(nullable id)target action:(nullable SEL)action
{
    self = [self initWithFrame:frame];
    if (self) {
        [self setTitle:text forState:0];
        if (target && action) {
            [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
        [self setTitleColor:textColor forState:0];
        [self setBackgroundColor:bgColor];
        [[self titleLabel] setFont:[UIFont systemFontOfSize:textsize]];
        return self;
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text type:(JNButton_TYPE)type Target:(nullable id)target action:(nullable SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:text forState:0];
        if (target && action) {
            [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
        if (type == Button_0) {
            [self setTitleColor:Button_NORMAL_TEXTCOLOR forState:0];
            [self setBackgroundColor:Button_NORMAL_BACKCOLOR];
        }else  if (type == Button_1) {
            [self setTitleColor:Button_TEXT_TEXTCOLOR forState:0];
            [self setBackgroundColor:Button_TEXT_BACKCOLOR];
        }else  if (type == Button_2) {
            [self setTitleColor:Button_DESCRIBE_TEXTCOLOR forState:0];
            [self setBackgroundColor:Button_DESCRIBE_BACKCOLOR];
        }else if (type == Button_3)
        {
            [self setTitleColor:Button_DESCRIBE_TEXTCOLOR1 forState:0];
            [self setBackgroundColor:Button_DESCRIBE_BACKCOLOR1];
        }
        return self;
    }
    return nil;
}


-(instancetype)initWithJnFrame:(CGRect)Jnframe text:(NSString *)text type:(JNButton_TYPE)type Target:(nullable id)target action:(nullable SEL)action
{
    return  [self initWithFrame:CGFrameWithJNFrame(Jnframe) text:text type:type Target:target action:action];
}

-(instancetype)initWithJnFrame:(CGRect)Jnframe text:(NSString *)text Target:(id)target action:(SEL)action
{
    return  [self initWithFrame:CGFrameWithJNFrame(Jnframe) text:text Target:target action:action];
}
-(instancetype)initWithJnFrame:(CGRect)Jnframe text:(NSString *)text textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor textsize:(float)textsize Target:(id)target action:(SEL)action
{
    return  [self initWithFrame:CGFrameWithJNFrame(Jnframe) text:text textColor:textColor bgColor:bgColor textsize:textsize Target:target action:action];
}

-(instancetype)initWithFrame:(CGRect)frame backImage:(nullable UIImage *)backImage Target:(nullable id)target action:(nullable SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:backImage forState:0];
        if (target && action) {
            [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
        return self;
    }
    return nil;
}
-(instancetype)initWithJnFrame:(CGRect)Jnframe backImage:(nullable UIImage *)backImage Target:(nullable id)target action:(nullable SEL)action
{
    return  [self initWithFrame:CGFrameWithJNFrame(Jnframe) backImage:backImage Target:target action:action];
}

// 重写高亮的方法。在这个方法中，我们忽略按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted
{

}


@end

@implementation UIButton (Image)

-(void)setBackgroundImage:(nullable UIImage *)image withUrl:(NSString *)url
{
    if (![self backgroundImageForState:0] && image) {
        [self setBackgroundImage:image forState:0];
    }else if(!image)
    {
        //需要设置 下载站位图片
      //  [self setBackgroundImage:BackImage_Button forState:0];
    }
    __block  UIActivityIndicatorView * activ = [UIImage downloadingImageActivityIndicatorView:CGRectMake(self.bounds.size.width/2-5,self.bounds.size.height/2-5 , 10, 10)];
    dispatch_queue_t   queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage * Backgroundimage = [UIImage setimageWithURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (Backgroundimage != nil) {
                [self setBackgroundImage:Backgroundimage forState:0];
            }else {
                //设置下载失败的破土
                //  [self setBackgroundImage:image forState:0];
            }
            [activ removeFromSuperview];
        });
    });
}

-(void)setBackgroundImage:(UIImage *)image withUrl:(NSString *)url size:(CGSize)size
{
    if (![self backgroundImageForState:0] && image) {
        [self setBackgroundImage:image forState:0];
    }else if(!image)
    {
        //需要设置 下载站位图片
        //  [self setBackgroundImage:BackImage_Button forState:0];
    }
    __block  UIActivityIndicatorView * activ = [UIImage downloadingImageActivityIndicatorView:CGRectMake(self.bounds.size.width/2-5,self.bounds.size.height/2-5 , 10, 10)];
    dispatch_queue_t   queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage * Backgroundimage = [UIImage setimageWithURL:url size:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (Backgroundimage != nil) {
                [self setBackgroundImage:Backgroundimage forState:0];
            }else {
                //设置下载失败的破土
                //  [self setBackgroundImage:image forState:0];
            }
            [activ removeFromSuperview];
        });
    });
}
-(void)setBackimageWithUrl:(NSString *)url
{
    [self setBackgroundImage:[self backgroundImageForState:0] withUrl:url];
}

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled withtimer:(int)timer
{
    self.userInteractionEnabled = NO;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        sleep(timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES ;
        });
    });
}

@end


