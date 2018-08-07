//
//  MyTabBar.m
//  XM
//
//  Created by Macintosh HD on 16/4/16.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "MyTabBar.h"

#define TABBAR_BTN_START_TAG 100
//#define BTN_COUNT  3

@interface TabBarButton : UIButton

@end

@implementation TabBarButton

// 重写高亮的方法。在这个方法中，我们忽略按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end

@interface MyTabBar ()
{
    NSMutableArray *imageArray;
    NSMutableArray *imageArray1;
}

// 保存分栏之前选中的按钮
@property (nonatomic, retain) TabBarButton *preSelBtn;
@end

@implementation MyTabBar

- (instancetype)init
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished:) name:@"返回根视图" object:nil];
    imageArray=[NSMutableArray array];
    imageArray1=[NSMutableArray array];
    if (self = [super init]) {

    }
    return self;
}

// init方法会调用initWithFrame ,给控件添加子控件在initWithFrame中添加
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE;
        // 1.3 设置用户交互属性可用(父控件不能与用户进行交互，则所有子控件都不能与用户交互)
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)addItemWithImageName:(NSString *)imageName selImageName:(NSString *)selImageName name:(NSString *)name
{
    [imageArray addObject:imageName];
    [imageArray1 addObject:selImageName];
    TabBarButton *btn = [TabBarButton buttonWithType:UIButtonTypeCustom];
    
    UIImageView *tbn1=[[UIImageView alloc]init];
    tbn1.frame=CGRectMake(self.bounds.size.width/_index1/2-22, 5, 44, 44);
    tbn1.image=[UIImage imageNamed:imageName];
    tbn1.tag=200;
    [btn addSubview:tbn1];
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/_index1/2-30, 25, 60, 30)];
//    label.font=[UIFont systemFontOfSize:10];
//    label.numberOfLines=0;
//    label.textColor = label_color;
//    label.textAlignment=NSTextAlignmentCenter;
//    label.text=name;
//    label.tag=100;
    // 默认第一个按钮为选中
    if (self.subviews.count == 0) {
        btn.selected = YES;
        // 保存当前选中的按钮
        self.preSelBtn = btn;
        [tbn1 setImage:[UIImage imageNamed:selImageName]];
//        label.textColor= label_sel_color;
    }
//    [btn addSubview:label];
    // 监听按钮的点击事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    // 设置按钮的tag值
    btn.tag = self.subviews.count+10;
    
    [self addSubview:btn];
}
-(void)downloadFinished:(NSNotification *)not
{
    if ([not.name isEqualToString:@"返回根视图"]) {
        TabBarButton *btn=(TabBarButton *)[self viewWithTag:10];
        [self btnClick:btn];
    }
}

- (void)btnClick:(TabBarButton *)btn
{    
    // 1. 取消之前选中按钮的选中状态
    self.preSelBtn.selected = NO;
//    UILabel *label= (UILabel *)[self.preSelBtn viewWithTag:100];
//    label.textColor= label_color;
//
    UIImageView *btn1=(UIImageView *)[self.preSelBtn viewWithTag:200];
    [btn1 setImage:[UIImage imageNamed:imageArray[self.preSelBtn.tag-10]]];
//
//    // 2. 将当前点击的按钮设为选中状态
    btn.selected = YES;
//    UILabel *label1= (UILabel *)[btn viewWithTag:100];
//    label1.textColor= label_sel_color;
//
    UIImageView *btn2=(UIImageView *)[btn viewWithTag:200];
    [btn2 setImage:[UIImage imageNamed:imageArray1[btn.tag-10]]];
    // 3. 保存当前选中的按钮
    self.preSelBtn = btn;
//    self.preSelBtn.selected = YES;
    // 如果代理实现了协议方法，通过协议方法通知代理当前控件上的第几个按钮被点击了。
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemWithIndex:)]) {
        [self.delegate tabBar:self didSelectItemWithIndex:btn.tag-10];
    }
}

// 这个方法在控件的frame(大小)修改后被调用
- (void)layoutSubviews
{
    // 这行代码不能少
    [super layoutSubviews];
    // 取出子控件的个数
    NSUInteger count = self.subviews.count ;
    // 调整子控件的大小
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.bounds.size.height;
    int i = 0;
    // 取出所有的子控件,调整frame
    for (UIView *view in self.subviews) {
        // 设置frame
        CGFloat btnX = btnW * i;
          view.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        if (i==2){
//            UIImageView * iamgeView = [view viewWithTag:200];
//            CGRect Frame = iamgeView.frame ;
//            Frame.origin.x -= JN_HH(9);
//            Frame.origin.y -= JN_HH(13);
//            Frame.size.width += JN_HH(18);
//            Frame.size.height += JN_HH(18);
//            iamgeView.frame = Frame;
//        }
        i++;
    }
}
@end
