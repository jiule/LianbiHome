//
//  UIView+Help.h
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class UIView;

@protocol JNBaseViewDelegate <NSObject>


@optional
//点击 BaseView
-(void)didView:(UIView *)view;
//点击 BaseView上面的按钮
-(void)didView:(UIView *)view leftbtn:(nullable  UIButton *)leftbtn;
-(void)didView:(UIView *)view rightbtn:(nullable  UIButton *)rightbtn;

-(void)didView:(UIView *)view btn:(nullable  UIButton *)btn;
//告诉代理一个字符串
-(void)didView:(UIView *)view text:(NSString *)text;

@end



@interface UIView (Help)

/**
 *  创建view 背景颜色  开启用户交互
 *
 *  @param BgColor  背景颜色
 */
-(instancetype _Nonnull  )initWithFrame:(CGRect)frame BgColor:(UIColor *_Nullable)BgColor ;

-(instancetype _Nullable )initWithSizi_Frame:(CGRect)frame BgColor:(UIColor *_Nullable)BgColor;

-(instancetype _Nullable )initWithSizi_Frame:(CGRect)frame;

-(void)setSIZI_Frame:(CGRect)frame;

-(CGRect)getSizi_Frame;
/**
 *  获取x坐标
 */
-(CGFloat )getX;
-(CGFloat )getSizi_X;
/**
 *  获取y坐标
 */
-(CGFloat)getY;
-(CGFloat )getSizi_Y;
/**
 *  获取宽度
 */
-(CGFloat)getW;
-(CGFloat )getSizi_W;
/**
 *  获取高度
 */
-(CGFloat)getH;
-(CGFloat )getSizi_H;
/**
 *  修改当坐标
 */
-(void)setX:(CGFloat)x;
-(void)setSizi_X:(CGFloat)x;
/**
 *  修改y坐标
 */
-(void)setY:(CGFloat)y;
-(void)setSizi_Y:(CGFloat)y;
/**
 *  修改宽度
 */
-(void)setW:(CGFloat)w;
-(void)setSizi_W:(CGFloat)w;
/**
 *  修改高度
 */
-(void)setH:(CGFloat)h;
-(void)setSizi_H:(CGFloat)h;

/*
 * 设置 圆角大小 边框颜色 边框宽度
 */
-(void)setCornerRadius:(CGFloat)cornerRadius BorderColor:(nullable UIColor *)corderColor  BorderWidth:(CGFloat)width;
/*
 * 设置 边框宽度  没有圆角 默认边框宽度
 */
-(void)setBorderColor:(nullable UIColor *)corderColor;
/*
 * 设置 圆角大小 边框颜色 默认边框宽度
 */
-(void)setCornerRadius:(CGFloat)cornerRadius BorderColor:(nullable UIColor *)corderColor;

/**
 *  转圈
 */
-(void)circles;
-(void)oneCircles;
@end

@interface UIView (Underscore)
/**
 *  添加下划线
 *    X :         DIVIDER_X
 *  linecolor :   DIVIDER_COLOR
 */
-(void)addUnderscore;
/**
 *  重开始 0  添加下划线
 *    X :         0
 *  linecolor :   DIVIDER_COLOR
 */
-(void)addUnderscoreBottomline;
/**
 *  添加下划线
 *  X  : DIVIDER_X
 *  linecolor   下划线颜色
 */
-(void)addUnderscoreBottomlineWithColor:(nullable UIColor *)linecolor;
/**
 *  添加最下面的线
 *  X  : DIVIDER_X    W:DIVIDER_W
 *  linecolor    下划线颜色
 */
-(void)addUnderscoreWithColor:(nullable UIColor *)linecolor;
/**
 *  添加最下面的线 默认  X DIVIDER_X 宽度 DIVIDER_W
 */
-(void)addUnderscoreWithY:(CGFloat)y;
/**
 *  添加最下面的线 默认  X DIVIDER_X 宽度 DIVIDER_W
 */
-(void)addUnderscoreWithSizi_Y:(CGFloat)y;
/**
 *  添加最下面的线 默认  X DIVIDER_X 宽度 DIVIDER_W
 */
-(void)addUnderscoreWithColor:(nullable UIColor *)color Y:(CGFloat)y;
/**
 *  添加最下面的线 默认  X DIVIDER_X 宽度 DIVIDER_W
 */
-(void)addUnderscoreWithY:(CGFloat)y height:(CGFloat)height;
/**
 *  添加线 默认  X DIVIDER_X 宽度 DIVIDER_W
 */
-(void)addUnderscoreWithColor:(nullable UIColor *)color Y:(CGFloat)y Height:(CGFloat)height;
/**
 *  添加线 默认  X DIVIDER_X 宽度 DIVIDER_W
 */
-(void)addUnderscoreWihtColor:(nullable UIColor *)color  dividerFrame:(CGRect)frame;
-(void)addUnderscoreWihtFrame:(CGRect)frame;
/**
 *  添加线 默认  X DIVIDER_X 宽度 DIVIDER_W
 */
-(void)addUnderscoreWihtColor:(nullable UIColor *)color  dividerJNFrame:(CGRect)frame;
/**
 *  这里是间隔线 默认高度  DIVIDER_SPACING_H 颜色 DIVIDER_SPACING_COLOR
 */
-(void)addSpacingWithY:(CGFloat)y;
/**
 *  这里是间隔线 默认高度  DIVIDER_SPACING_H
 */
-(void)addSpacingWithColor:(UIColor *)color y:(CGFloat)y;
/**
 *  添加线 默认  X 0
 */
-(void)addSpacingWithColor:(UIColor *)color y:(CGFloat)y height:(CGFloat)height;
//渐变颜色
-(void)addJianbianWithColor:(UIColor *)downColor upColor:(UIColor *)upColor;
-(void)creatLineOnRelativeView:(UIView *)relativeView offSet:(CGFloat)offset;
-(void)creatStrongLineOnRelativeView:(UIView *)relativeView offSet:(CGFloat)offset;

@end

//-----------------------------这是华丽的分割线--------------------------------
//Recognizer 是给uiview 添加各种手势的  这里未处理各种手势的冲突
typedef void (^UIRecognizertap)(UIView * view ,UIGestureRecognizer * tap);

@interface UIView (Recognizer) <UIGestureRecognizerDelegate>

/**
 *  添加单击手势
 */
-(void)addtapGestureRecognizer:(UIRecognizertap)recognizertap;
-(void)adddoubleTapGestureRecognizer:(UIRecognizertap)recognizertap;
/**
 *  添加滑动手势
 */
-(void)addswipeGestureRecognizer:(UIRecognizertap)recognizertap;
/**
 *  添加长按手势
 */
-(void)addlongPressGestureRecognizerBegan:(UIRecognizertap)recognizertapBegan Ended:(UIRecognizertap)recognizertapEnded;
/**
 *  添加平移手势
 */
-(void)addpanGestureTecognizer:(nullable UIRecognizertap)recognizertap;
/**
 *  添加捏合手势
 */
-(void)addpinchGestureRecognizer:(nullable UIRecognizertap)recognizertap;
/**
 *  添加旋转手势
 */
-(void)addrotationGestureRecognizer:(nullable UIRecognizertap)recognizertap;
/**
 *  添加边缘手势
 */
-(void)addscreenEdgePanGestureRecognizer:(UIRecognizertap)recognizertap;
@end
@interface UIView (Extensions)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@end


NS_ASSUME_NONNULL_END

