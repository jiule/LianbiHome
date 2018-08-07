//
//  NavView.m
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//

//屏幕的宽 高

#import "NavView.h"


@interface NavView ()
{
    UIButton * _stateBtn;
    UIImageView * _stateImageView;
    UILabel * _stateLabel;
    UILabel *  _lookLabel;
    UIImageView *_lookImageView;
}

@property(nonatomic,retain)UILabel * fanhuiLabel;

@end

@implementation NavView

-(instancetype)initWithFrame:(CGRect)frame title:(nullable NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGNavView_h())]) {
        _title = title;
        _rightTitle = RIGHT_TITLE;
        self.backgroundColor = COLOR_WHITE;
        self.userInteractionEnabled = YES ;
        self.clipsToBounds = YES  ;
        [self createView];
    }
    return  self;
}

-(void)createView{
    //To add text label
    _titleLabel = JnLabel(CGRectMake(0, CGNavView_20h() + 12, SCREEN_WIDTH, 20), _title, 18, TITLELABEL_TEXTCOLOR_STYLE1, 1);
    [self addSubview:_titleLabel];
    
    //Add the back button
    _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _returnBtn.frame = CGRectMake(5, CGNavView_20h(), 104, 44);
    [_returnBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_returnBtn];
    
    //Add the returned images
    UIImageView * imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44) image:[UIImage imageNamed:UIBUTTON_FANHUIIMAGE_STYLE1] ];
    imageview.userInteractionEnabled = NO;
    [_returnBtn addSubview:imageview];
    _fanhuiImageView = imageview ;
    
  //  _fanhuiLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 12, 50, 20) text:@"返回" textColor:[UIColor whiteColor] index:0 size:17];
    [_returnBtn addSubview:_fanhuiLabel];

    _rightButton = JnButtonImageTag(CGRectMake(SCREEN_WIDTH - 54, CGNavView_20h(), 44, 44), MYimageNamed(@"nav_kefu1"), self, @selector(RightBtnClick:), -49);
    _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight ;

    [self addSubview:_rightButton];
    [self setStyle:0];
 //   [self addDividingLine];
//    [self setcolorStyle:1];
    
}

-(void)isfanhuiBtn:(BOOL)isfanhui
{
    if (!isfanhui) {
        _returnBtn.alpha = 0;
    }else {
        _returnBtn.alpha = 1;
    }
}

-(void)BtnClick
{
    if ([self.delegate respondsToSelector:@selector(clickonReturn)]) {
        [self.delegate clickonReturn];
    }else {
       // MyLog(@"代理呢?");
    }
}
-(void)RightBtnClick:(UIButton *)btn
{
    if([_delegate respondsToSelector:@selector(clickRightButton:)])
        [_delegate clickRightButton:btn];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
-(void)setStyle:(MynavViewStyle)style
{
    if (style == 0) {
        _titleLabel.alpha = 1;
        _returnBtn.alpha = 0;
        _rightButton.alpha = 0;
    }else if(style == 1){
        _titleLabel.alpha = 1;
        _returnBtn.alpha = 1 ;
        _rightButton.alpha = 0;
    }else if(style == 2){
        _titleLabel.alpha = 1;
        _returnBtn.alpha = 1 ;
        _rightButton.alpha = 1;
    }else if(style == 3)
    {
        _titleLabel.alpha = 1;
        _returnBtn.alpha = 0;
        _rightButton.alpha = 1;
    }
}

-(void)setcolorStyle:(MyColor_Style)style
{
    if (style == 0) {
        self.backgroundColor = NAVVIEW_BACKCOLOR_STYLE1;
        _titleLabel.textColor = TITLELABEL_TEXTCOLOR_STYLE1;
        _fanhuiImageView.image = [UIImage imageNamed:UIBUTTON_FANHUIIMAGE_STYLE1];
        [_rightButton setTitleColor:RIGHTBUTTON_TEXTCOLOR_STYLE1 forState:0];
    }else if(style == 1)
    {
        self.backgroundColor = NAVVIEW_BACKCOLOR_STYLE2;
        _titleLabel.textColor = TITLELABEL_TEXTCOLOR_STYLE2;
        _fanhuiImageView.image = [UIImage imageNamed:UIBUTTON_FANHUIIMAGE_STYLE2];
        [_rightButton setTitleColor:RIGHTBUTTON_TEXTCOLOR_STYLE2 forState:0];
    }else if (style == 2){
        self.backgroundColor = COLOR_A4;
        _titleLabel.textColor = [UIColor whiteColor];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:0];
        _fanhuiImageView.image = [UIImage imageNamed:UIBUTTON_FANHUIIMAGE_STYLE3];
    }
    else {
        self.backgroundColor = NAVVIEW_BACKCOLOR_STYLE2;
        _titleLabel.textColor = TITLELABEL_TEXTCOLOR_STYLE1;
    }
}

-(void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle = rightTitle;
    [_rightButton setTitle:_rightTitle forState:0];
}

-(void)setRrturnBackImage:(UIImage *)image
{
    _fanhuiImageView.image = image;
}

-(void)addDividingLine
{
    UIView * DividingLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGNavView_h() - 1, SCREEN_WIDTH, 1) BgColor:DIVIDER_COLOR1];
    DividingLineView.tag = -50;
    [self addSubview:DividingLineView];
}

-(void)removeDividingLine
{
    [[self viewWithTag: -50] removeFromSuperview];
}

-(void)insertUp
{
      [self.superview insertSubview:self atIndex:self.superview.subviews.count + 100];
}
    


@end
