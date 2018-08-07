//
//  InformationView.m
//  LianbiHome
//
//  Created by Apple on 2018/8/6.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "InformationView.h"

@interface InformationView()
{
    UIButton * _selBtn;
    UIView * _xianView;
}
@end


@implementation InformationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self   = [super initWithFrame:frame];
    if (self) {
        [self show];
        return self;
    }
    return nil;
}

-(void)show
{
    NSArray * titleArray = @[@"推荐",@"快讯"];
    for ( int  i= 0 ; i < titleArray.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - JN_HH(100) + JN_HH(100) * i, JN_HH(5), JN_HH(100), JN_HH(40))];
        [btn setTitle:titleArray[i] forState:0];
        [btn setTitleColor:SXRGB16Color(0x7584a0) forState:0];
        [btn setTitleColor:SXRGB16Color(0x000000) forState:UIControlStateSelected];
        if (i == 0) {
            _xianView = JnUIView(CGRectMake(SCREEN_WIDTH * 0.5 - JN_HH(58), self.height - JN_HH(10), JN_HH(16), 2), COLOR_RED);
            [self addSubview:_xianView];
            btn.selected = YES;
            _selBtn = btn;
        }
        btn.tag = 100 + i;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addUnderscoreBottomline];
}

-(void)btnClick:(UIButton *)btn
{
    if (_selBtn == btn) {
        return;
    }
    _selBtn.selected = NO;
    _selBtn = btn;
    _selBtn.selected = YES;
    if ([_delegate respondsToSelector:@selector(InformationView:index:)]) {
        [_delegate InformationView:self index:(int)_selBtn.tag - 100];
    }
     [self loadXian];
}

-(void)showWithLeftBtn:(BOOL)left
{
    if (left) {
        if (_selBtn.tag == 101) {
            return ;
        }
        _selBtn.selected = NO;
        _selBtn = [self viewWithTag:101];
        _selBtn.selected = YES;

    }else {
        if (_selBtn.tag == 100) {
            return ;
        }
        _selBtn.selected = NO;
        _selBtn = [self viewWithTag:100];
        _selBtn.selected = YES;
    }
    [self loadXian];
}

-(void)loadXian
{
    if (_selBtn.tag == 100) {
        [_xianView setX:SCREEN_WIDTH * 0.5 - JN_HH(58)];
    }else {
     [_xianView setX:SCREEN_WIDTH * 0.5 + JN_HH(42)];
    }
}

@end
