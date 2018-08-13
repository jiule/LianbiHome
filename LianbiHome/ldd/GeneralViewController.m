//
//  GeneralViewController.m
//  kyzx
//
//  Created by simon on 16/5/17.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "GeneralViewController.h"
#import "Masonry.h"

#define Tag_middle_title   (12001)
#define Tag_middle_image   (12002)
#define Tag_time_title     (12003)
#define Tag_page_title     (12004)
#define Tag_back_item      (11000)
#define Tag_right_item     (13000)

//barItemWidth
#define barItem_width           100


@interface GeneralViewController ()

@end

@implementation GeneralViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view，最底层的view
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏
    _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGNavView_h())];
//    [self setNaviBarBgImage:@"common/bar/Header"];
    _naviView.backgroundColor = [UIColor whiteColor];
    
    //主体视图
    _bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, CGNavView_h(), SCREEN_WIDTH, [self bodyHeigh])];
    _bodyView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bodyView];
    
    [self.view addSubview:_naviView];
    
}

-(void)setNaviBarBgImage:(NSString*)imageName
{
    //    _naviView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    UIImage* bgImage = [UIImage imageNamed:imageName];
    _naviView.layer.contents = (id)bgImage.CGImage;
}

-(void)setMiddleTitle:(NSString*)title
{
    if ([_naviView viewWithTag:Tag_middle_image]) {
        [[_naviView viewWithTag:Tag_middle_image] removeFromSuperview];
    }
    if ([_naviView viewWithTag:Tag_middle_title]) {
        [[_naviView viewWithTag:Tag_middle_title] removeFromSuperview];
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGNavView_20h(), 180, CGNavView_h() -CGNavView_20h())];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(SCREEN_WIDTH/2, CGNavView_h()/2+10);
    label.text = title;
    label.tag = Tag_middle_title;
    [_naviView addSubview:label];
}


-(float)bodyHeigh{
    return SCREEN_HEIGHT - CGNavView_h();
}
@end







#pragma mark -----------------class LeftButtonItem------------------
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
@implementation LeftButtonItem

-(id)initWithStr:(NSString*)str target:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, barItem_width, Tabbar_49h());
        self.center = CGPointMake(barItem_width/2, CGNavView_20h() + 22);
        _navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navLeftButton setTitle:str forState:UIControlStateNormal];
        [_navLeftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _navLeftButton.frame = self.bounds;
        [self addSubview:_navLeftButton];
    }
    return self;
}
-(id)initWithNormalImg:(NSString*)imgName selectedImg:(NSString*)selectedImgName target:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, CGNavView_20h(), barItem_width, CGNavView_h()- CGNavView_20h());
        self.center=CGPointMake(barItem_width/3, CGNavView_20h() + 22);
        _navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navLeftButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_navLeftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [_navLeftButton setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
        [_navLeftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _navLeftButton.frame = self.bounds;
        [self addSubview:_navLeftButton];
    }
    return self;
}

@end




#pragma mark -----------------class RightButtonItem------------------
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
@implementation RightButtonItem

-(id)initWithStr:(NSString*)str target:(id)target action:(SEL)action
{
    if (self = [super init]){
        self.frame = CGRectMake(SCREEN_WIDTH-barItem_width, CGNavView_20h() + 7, barItem_width, Tabbar_49h()-  CGNavView_20h() + 14);
        self.center=CGPointMake(SCREEN_WIDTH-barItem_width/2, CGNavView_20h()+22);
        _navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navRightButton setTitle:str forState:UIControlStateNormal];
        [_navRightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _navRightButton.frame = self.bounds;
        [self addSubview:_navRightButton];
    }
    return self;
}

-(id)initWithNormalImg:(NSString*)imgName selectedImg:(NSString*)selectedImgName target:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        self.frame = CGRectMake(SCREEN_WIDTH - barItem_width, CGNavView_20h() + 3, barItem_width, CGNavView_h() -CGNavView_20h());
        self.center = CGPointMake(SCREEN_WIDTH - barItem_width/3 , CGNavView_20h()+22);
        _navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navRightButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_navRightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [_navRightButton setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateHighlighted];
        [_navRightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _navRightButton.frame = self.bounds;
        [self addSubview:_navRightButton];
    }
    return self;
}


-(void)setRightButtonItemContentEdgeInsetsWith:(UIEdgeInsets)insets
{
    _navRightButton.contentEdgeInsets = insets;
}

@end
