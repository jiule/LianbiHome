//
//  UIView+Help.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UIView+Help.h"

@implementation UIView (Help)

//快速创建view
-(instancetype)initWithFrame:(CGRect)frame BgColor:(UIColor *)BgColor
{
    self = [self initWithFrame:frame];
    if (self) {
        self.backgroundColor = BgColor;
        self.userInteractionEnabled = YES;
        //  self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            return self;
    }
    return nil;
}

-(instancetype)initWithSizi_Frame:(CGRect)frame BgColor:(UIColor *)BgColor
{
    return [self initWithFrame:CGFrameWithJNFrame(frame) BgColor:BgColor];
}

-(instancetype)initWithSizi_Frame:(CGRect)frame
{
    return [self initWithSizi_Frame:frame BgColor:[UIColor clearColor]];
}

-(void)setSIZI_Frame:(CGRect)frame
{
    self.frame = CGFrameWithJNFrame(frame);
}

-(CGRect)getSizi_Frame
{
    return   JNFrameWithFrame(self.frame);
}

//获取当前的x坐标
-(CGFloat )getX
{
    return self.frame.origin.x;
}
-(CGFloat )getSizi_X
{
    return JN_HHH([self getX]);
}
//获取当前的y坐标
-(CGFloat)getY
{
    return self.frame.origin.y;
}
-(CGFloat )getSizi_Y
{
    return JN_HHH([self getY]);
}
//获取当前的宽度
-(CGFloat)getW{
    return self.frame.size.width ;
}
-(CGFloat )getSizi_W
{
    return JN_HHH([self getW]);
}
//获取当前的x高度
-(CGFloat)getH{
    return self.frame.size.height ;
}
-(CGFloat )getSizi_H
{
    return JN_HHH([self getH]);
}
//修改当前的x坐标
-(void)setX:(CGFloat)x{
    CGRect Frame = self.frame;
    Frame.origin.x = x;
    self.frame = Frame;
}

-(void)setSizi_X:(CGFloat)x
{
    [self setX:JN_HH(x)];
}
//修改当前的y坐标
-(void)setY:(CGFloat)y{
    CGRect Frame = self.frame;
    Frame.origin.y = y;
    self.frame = Frame;
}
-(void)setSizi_Y:(CGFloat)y
{
    [self setY:JN_HH(y)];
}
//修改当前的宽度
-(void)setW:(CGFloat)w{
    CGRect Frame = self.frame;
    Frame.size.width = w;
    self.frame = Frame;
}
-(void)setSizi_W:(CGFloat)w
{
    [self setW:JN_HH(w)];
}
//修改当前的高度
-(void)setH:(CGFloat)h{
    CGRect Frame = self.frame;
    Frame.size.height = h;
    self.frame = Frame;
}
-(void)setSizi_H:(CGFloat)h
{
    [self setH:JN_HH(h)];
}

-(void)setCornerRadius:(CGFloat)cornerRadius BorderColor:(nullable UIColor *)corderColor  BorderWidth:(CGFloat)width{
    if (corderColor) {
        [self.layer setBorderColor:corderColor.CGColor];
        [self.layer setBorderWidth:width];
    }
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES ;
}
/*
 * 设置 边框宽度  没有圆角 默认边框宽度
 */
-(void)setBorderColor:(nullable UIColor *)corderColor{
    [self setCornerRadius:0 BorderColor:corderColor BorderWidth:1];
}
/*
 * 设置 圆角大小 边框颜色 默认边框宽度
 */
-(void)setCornerRadius:(CGFloat)cornerRadius BorderColor:(nullable UIColor *)corderColor{
    [self setCornerRadius:cornerRadius BorderColor:corderColor BorderWidth:1];
}

#pragma mark----转圈
-(void)circles
{
    CABasicAnimation * animation = [CABasicAnimation  animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    animation.duration = 10;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 500;
    [self.layer addAnimation:animation forKey:nil];
}
-(void)oneCircles{
    CABasicAnimation * animation = [CABasicAnimation  animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    animation.duration = 1;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1;
    [self.layer addAnimation:animation forKey:nil];
}

@end

@implementation UIView (Underscore)

-(void)addUnderscore
{
    [self addUnderscoreWihtColor:DIVIDER_COLOR1 dividerFrame:CGRectMake(DIVIDER_X, [self getH] - DIVIDER_H, DIVIDER_W, DIVIDER_H)];
}

-(void)addUnderscoreBottomline
{
    [self addUnderscoreBottomlineWithColor:DIVIDER_COLOR1];
}

-(void)addUnderscoreBottomlineWithColor:(nullable UIColor *)linecolor
{
    [self addUnderscoreWihtColor:linecolor dividerFrame:CGRectMake(0, [self getH] - DIVIDER_H, SCREEN_WIDTH, DIVIDER_H)];
}

-(void)addUnderscoreWithColor:(nullable UIColor *)linecolor
{
    [self addUnderscoreWihtColor:linecolor dividerFrame:CGRectMake(DIVIDER_X, [self getH] - DIVIDER_H, DIVIDER_W, DIVIDER_H)];
}

-(void)addUnderscoreWithY:(CGFloat)y
{
    [self addUnderscoreWihtColor:DIVIDER_COLOR1 dividerFrame:CGRectMake(DIVIDER_X, y , DIVIDER_W, DIVIDER_H)];
}
-(void)addUnderscoreWithSizi_Y:(CGFloat)y
{
    [self addUnderscoreWithY:JN_HH(y)];
}

-(void)addUnderscoreWithColor:(nullable UIColor *)color Y:(CGFloat)y
{
    [self addUnderscoreWihtColor:color dividerFrame:CGRectMake(DIVIDER_X, y , DIVIDER_W, DIVIDER_H)];
}

-(void)addUnderscoreWithY:(CGFloat)y height:(CGFloat)height
{
    [self addUnderscoreWihtColor:DIVIDER_COLOR1 dividerFrame:CGRectMake(DIVIDER_X, y - height, DIVIDER_W, height)];
}

-(void)addUnderscoreWithColor:(nullable UIColor *)color Y:(CGFloat)y Height:(CGFloat)height
{
    [self addUnderscoreWihtColor:color dividerFrame:CGRectMake(DIVIDER_X, y , DIVIDER_W, height)];
}
-(void)addUnderscoreWihtFrame:(CGRect)frame
{
    [self addUnderscoreWihtColor:DIVIDER_COLOR1 dividerFrame:frame];
}
-(void)addUnderscoreWihtColor:(nullable UIColor *)color  dividerFrame:(CGRect)frame
{
    //这是添加在layer层
    CALayer * layer = [CALayer layer];
    layer.frame = frame ;
    if (color) {
        layer.backgroundColor = color.CGColor;
    }else {
        layer.backgroundColor = DIVIDER_COLOR1.CGColor;
    }
    [self.layer addSublayer:layer];
    //这是添加在view层
    //    UIView * dividerView = [[UIView alloc]initWithFrame:frame];
    //    if (color) {
    //         dividerView.layer.backgroundColor = color.CGColor;
    //    }else {
    //         dividerView.layer.backgroundColor = DIVIDER_COLOR.CGColor;
    //    }
    //    [self addSubview:dividerView];
}
-(void)addUnderscoreWihtColor:(nullable UIColor *)color  dividerJNFrame:(CGRect)frame
{
    [self addUnderscoreWihtColor:color dividerFrame:CGFrameWithJNFrame(frame)];
}
/**
 *  这里是间隔线了
 */
-(void)addSpacingWithY:(CGFloat)y
{
    [self addSpacingWithColor:DIVIDER_SPACING_COLOR y:DIVIDER_SPACING_H];
}

-(void)addSpacingWithColor:(UIColor *)color y:(CGFloat)y
{
    [self addSpacingWithColor:color y:y height:DIVIDER_SPACING_H];
}

-(void)addSpacingWithColor:(UIColor *)color y:(CGFloat)y height:(CGFloat)height
{
    [self addUnderscoreWihtColor:color dividerFrame:CGRectMake(0, y , [self getW], height)];
}
-(void)addJianbianWithColor:(UIColor *)downColor upColor:(UIColor *)upColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[ (__bridge id)downColor.CGColor,(__bridge id)upColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
}
#pragma mark 画一条线
-(void)creatLineOnRelativeView:(UIView *)relativeView offSet:(CGFloat)offset{
    UILabel * line = [UILabel new];
    line.backgroundColor = COLOR_B6;
    [relativeView.superview addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(relativeView.mas_bottom).offset(offset);
    }];
    
}
#pragma mark 画分割
-(void)creatStrongLineOnRelativeView:(UIView *)relativeView offSet:(CGFloat)offset{
    UILabel * line = [UILabel new];
    line.backgroundColor = COLOR_B6;
    [relativeView.superview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self);
        make.height.mas_equalTo(20);
        make.top.equalTo(relativeView.mas_bottom).offset(offset);
    }];
}
@end

@interface UIView ()
//  点击手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, taprecognizertap);
//  双击手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, doubleTaprecognizertap);
//  滑动手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, swiperecognizertap);
//  长按手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, longrecognizertap);
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, longrecognizertapBegan);
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, longrecognizertapEnded);
//  平移手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, panrecognizertap);
//  捏合手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, pinchperecognizertap);
//  旋转手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, rotationrecognizertap);
//  边缘手势
XH_ATTRIBUTE_COPY_BLOCK(UIRecognizertap, screenEdgePanrecognizertap);
@end

@implementation UIView(Recognizer)

#pragma mark----这里是添加点击
-(void)addtapGestureRecognizer:(UIRecognizertap)recognizertap
{
    if (![self addGestureWithView]) {   return ; }
    if (!self.taprecognizertap) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        tap.delegate = self ;
        [self addGestureRecognizer:tap];

        for (UIGestureRecognizer * ges in [self gestureRecognizers]) {
            if ([ges isKindOfClass:[UITapGestureRecognizer class]] ){
                UITapGestureRecognizer * ges1 = (UITapGestureRecognizer *)ges;
                if (ges1.numberOfTapsRequired == 2) {
                    [tap  requireGestureRecognizerToFail:ges];
                }
            }
        }
    }
    self.taprecognizertap = recognizertap;
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.taprecognizertap) {
        self.taprecognizertap(self,tap);
    }
}

#pragma mark----双击手势
-(void)adddoubleTapGestureRecognizer:(UIRecognizertap)recognizertap{
    if (![self addGestureWithView]) return;
    if (!self.doubleTaprecognizertap) {
        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:
                                              self action:@selector(doubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        //拿到tap手势
        for (UIGestureRecognizer * ges in [self gestureRecognizers]) {
            UITapGestureRecognizer * ges1 = (UITapGestureRecognizer *)ges;
            if (ges1.numberOfTapsRequired == 1) {
                [ges1  requireGestureRecognizerToFail:doubleTap];
            }
        }
        [self addGestureRecognizer:doubleTap];
    }
    self.doubleTaprecognizertap  = recognizertap;
}

- (void)doubleTapAction:(UITapGestureRecognizer *)tap{
    if (self.doubleTaprecognizertap) {
        self.doubleTaprecognizertap(self, tap);
    }
}

#pragma mark----这里是添加滑动手势
-(void)addswipeGestureRecognizer:(UIRecognizertap)recognizertap
{
    if (![self addGestureWithView]) return ;
    if (!self.swiperecognizertap) {
        UISwipeGestureRecognizer *swipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        swipe.direction =UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipe];
        UISwipeGestureRecognizer *swipe2 =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        swipe2.direction =UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipe2];
        UISwipeGestureRecognizer *swipe3 =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        swipe3.direction =UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipe3];
        UISwipeGestureRecognizer *swipe4 =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        swipe4.direction =UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipe4];
    }
    self.swiperecognizertap = recognizertap;
}

-(void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    if (self.swiperecognizertap) {
        self.swiperecognizertap(self,swipe);
    }
}

#pragma mark----添加长按手势
-(void)addlongPressGestureRecognizerBegan:(UIRecognizertap)recognizertapBegan Ended:(UIRecognizertap)recognizertapEnded
{
    if (![self addGestureWithView]) return;
    if (!self.longrecognizertapBegan) {
        for (UIGestureRecognizer * ges in [self gestureRecognizers]) {
            if ([ges isKindOfClass:[UILongPressGestureRecognizer class]] ){
                [self removeGestureRecognizer:ges];
            }
        }

        UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressActionBegan:)];
        //最短长按时间
        longPress.minimumPressDuration =2;
        //允许移动最大距离
        longPress.allowableMovement =1;
        //添加到指定视图
        [self addGestureRecognizer:longPress];
    }
    self.longrecognizertapBegan = recognizertapBegan ;
    self.longrecognizertapEnded = recognizertapEnded;
}

-(void)longPressActionBegan:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (self.longrecognizertapBegan) {
            self.longrecognizertapBegan(self,longPress);
        }
    }else {
        if (self.longrecognizertapEnded) {
            self.longrecognizertapEnded(self,longPress);
        }
    }
}

-(void)addlongPressGestureRecognizer:(UIRecognizertap)recognizertap
{
    if (![self addGestureWithView]) return;
    for (UIGestureRecognizer * ges in [self gestureRecognizers]) {
        if ([ges isKindOfClass:[UILongPressGestureRecognizer class]] ){
            return ;
        }
    }
    if (!self.longrecognizertap) {
        UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        //最短长按时间
        longPress.minimumPressDuration =2;
        //允许移动最大距离
        longPress.allowableMovement =1;
        //添加到指定视图
        [self addGestureRecognizer:longPress];
    }
    self.longrecognizertap = recognizertap ;
}

-(void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if (self.longrecognizertap && longPress.state == UIGestureRecognizerStateEnded ) {
        self.longrecognizertap(self,longPress);
    }
}

#pragma mark----添加平移
-(void)addpanGestureTecognizer:(nullable UIRecognizertap)recognizertap
{
    if (![self addGestureWithView]) return;
    if (!self.panrecognizertap) {
        UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        //添加到指定视图
        [self addGestureRecognizer:pan];
    }
    self.panrecognizertap  = recognizertap;
}

-(void)panAction:(UIPanGestureRecognizer *)pan
{
    if (self.panrecognizertap) {
        self.panrecognizertap(self,pan);
    }else {
        //获取手势的位置
        CGPoint position =[pan translationInView:self];
        //通过stransform 进行平移交换
        self.transform = CGAffineTransformTranslate(self.transform, position.x, position.y);
        //将增量置为零
        [pan setTranslation:CGPointZero inView:self];
    }
}

#pragma mark----捏合手势
-(void)addpinchGestureRecognizer:(UIRecognizertap)recognizertap
{
    if (![self addGestureWithView]) return;
    if (!self.pinchperecognizertap) {
        UIPinchGestureRecognizer *pinch =[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
        //添加到指定视图
        [self addGestureRecognizer:pinch];
    }
    self.pinchperecognizertap = recognizertap;
}
-(void)pinchAction:(UIPinchGestureRecognizer *)pinch
{
    if (self.pinchperecognizertap) {
        self.pinchperecognizertap(self,pinch);
    }else {
        self.transform =CGAffineTransformScale(self.transform, pinch.scale, pinch.scale);
        pinch.scale = 1;
    }
}

#pragma mark----旋转手势
-(void)addrotationGestureRecognizer:(UIRecognizertap)recognizertap
{
    if (![self addGestureWithView]) return;
    if (!self.rotationrecognizertap)
    {
        UIRotationGestureRecognizer *rotation =[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
        //添加到指定的视图
        [self   addGestureRecognizer:rotation];
    }
    self.rotationrecognizertap  = recognizertap;
}
-(void)rotationAction:(UIRotationGestureRecognizer *)rote
{
    if (self.rotationrecognizertap) {
        self.rotationrecognizertap(self,rote);
    }else {
        //通过transform 进行旋转变换
        self.transform = CGAffineTransformRotate(self.transform, rote.rotation);
        //将旋转角度 置为 0
        rote.rotation = 0;
    }
}
#pragma mark----边缘手势
-(void)addscreenEdgePanGestureRecognizer:(UIRecognizertap)recognizertap
{
    if (![self addGestureWithView]) return;
    if (!self.screenEdgePanrecognizertap) {
        UIScreenEdgePanGestureRecognizer *screenPan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenPanAction:)];
        [self addGestureRecognizer:screenPan];
    }
    self.screenEdgePanrecognizertap = recognizertap;
}

-(void)screenPanAction:(UIScreenEdgePanGestureRecognizer *)screenPan
{
    if (self.screenEdgePanrecognizertap) {
        self.screenEdgePanrecognizertap(self,screenPan);
    }
}
//处理uibutton 不给手势处理
-(BOOL)addGestureWithView
{
    if ([self class]== [UIButton class]) {
        return  NO;
    }
    self.userInteractionEnabled = YES ;
    return YES ;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
////    for (UIView * view in self.subviews) {
////        if (![MYRuntime Myclass_isMetaClass:[view class]])
////        {
////            if ([touch.view isDescendantOfView:view])
////                return NO;
////        }
////    }
//    return YES;
//}
//点击手势
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, taprecognizertap, Taprecognizertap)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, doubleTaprecognizertap, DoubleTaprecognizertap)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, swiperecognizertap, Swiperecognizertap)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, longrecognizertap, Longrecognizertap)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, longrecognizertapBegan, LongrecognizertapBegan)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, longrecognizertapEnded, LongrecognizertapEnded)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, panrecognizertap, Panrecognizertap)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, pinchperecognizertap, Pinchperecognizertap)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, rotationrecognizertap, Rotationrecognizertap)
XM_SEL_BLOCK(OBJC_ASSOCIATION_COPY_NONATOMIC, UIRecognizertap, screenEdgePanrecognizertap, ScreenEdgePanrecognizertap)

@end

@implementation UIView (Extensions)

// Retrieve and set the origin
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

// Retrieve and set the size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth {
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

@end

