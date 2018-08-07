//
//  NavView.h
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//
#define RIGHT_TITLE @"取消"

#define UIBUTTON_FANHUIIMAGE_STYLE1 @"back"          //The main color background returns
#define UIBUTTON_FANHUIIMAGE_STYLE2 @"back1"          //Grey back pictures
#define UIBUTTON_FANHUIIMAGE_STYLE3 @"nav_arrow_back"
#define NAVVIEW_BACKCOLOR_STYLE1  [UIColor whiteColor]                  //The background color
#define NAVVIEW_BACKCOLOR_STYLE2   COLOR_A1       //A white background


#define TITLELABEL_TEXTCOLOR_STYLE1 SXRGB16Color(0x282828)
#define TITLELABEL_TEXTCOLOR_STYLE2 [UIColor whiteColor]


#define RIGHTBUTTON_TEXTCOLOR_STYLE1   RGB_R(255, 255, 255)
#define RIGHTBUTTON_TEXTCOLOR_STYLE2   COLOR_A1

#import <UIKit/UIKit.h>

// Custom navview style , Enumerated type

typedef NS_ENUM(NSUInteger,MynavViewStyle) {
    MynavViewStateNormal       = 0,                   // 默认不带返回
    MynavViewNotReturns        = 1,                   // 带返回
    MynavViewReturnsRight      = 2,                   // 带返回 带右边按钮  UIBUTTON_FANHUIIMAGE_STYLE3
    MynavViewNotReturnsRight   = 3,                   // 左边不带返回  右边有按钮 文字
};


typedef NS_ENUM(NSUInteger , MyColor_Style)
{
    MyColor_Style_Normal  = 0,
    MyColor_Style_Color1  = 1,
    MyColor_Style_Color2  = 2,   //COLOR_A4  [UIColor whiteColor]
};

@protocol NavViewDelegate <NSObject>

@optional
/**
 导航栏左边的返回按钮点击了
 */
-(void)clickonReturn;
/**
 导航栏右边的按钮点击了

 @param rightBtn 导航栏右边的按钮
 */
-(void)clickRightButton:(nonnull UIButton *)rightBtn;
@end

@interface NavView : UIView

NS_ASSUME_NONNULL_BEGIN
/**
 *  Initialization method
 *
 *  @param frame     h =64
 *  @param title    titlelabel
 *
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame title:(nullable NSString *)title;
/**
 *  The agent
 */
@property(nonatomic,assign)id <NavViewDelegate> delegate;
/**
 *  Style not for MynavViewStateNormal back button
 */
@property(nonatomic,retain)UIButton * returnBtn;
/**
 *  返回按钮上面的图片
 */
@property(nonatomic,retain)UIImageView * fanhuiImageView;
/**
 *  The title in the middle of the label
 */
@property(nonatomic,retain)UILabel * titleLabel;
/**
 *  According to the middle of the label text
 */
@property(nonatomic,copy)NSString * title;

//Shown on the right side of the button Style for MynavViewReturnsRight display
@property(nonatomic,copy)NSString * rightTitle;

//Button on the right side of the display
@property(nonatomic,retain)UIButton * rightButton;

/**
 *  Is there a back button The default has returned
 *
 *  @param isfanhui  bool
 */
-(void)isfanhuiBtn:(BOOL)isfanhui;
//Set the naview style
-(void)setStyle:(MynavViewStyle)style;
//设置导航拦的字体颜色 
-(void)setcolorStyle:(MyColor_Style)style;
//把导航拦放到最上层
-(void)insertUp;
//Set up the picture of the back button   This method finally set to set the other styles Will override this method
-(void)setRrturnBackImage:(UIImage *)image;
//添加导航拦下面的线
-(void)addDividingLine;
//删除导航拦下面的线
-(void)removeDividingLine;


NS_ASSUME_NONNULL_END
@end
