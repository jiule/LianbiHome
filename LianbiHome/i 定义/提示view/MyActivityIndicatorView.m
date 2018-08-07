//
//  MyActivityIndicatorView.m
//  Q-Lady
//
//  Created by Apple on 17/2/17.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import "MyActivityIndicatorView.h"

@interface MyActivityIndicatorView ()

@property(nonatomic,retain)UIImageView * bgImageView;

@property(nonatomic,retain)UILabel * TitleLabel;

@property(nonatomic,retain)UIView * bgView;

@property(nonatomic,retain)NSArray * titleArray;

@property(nonatomic,retain)NSArray * imageArray;

@property(nonatomic,assign)ActivityIndicatorStyle style;

@property(nonatomic,copy)NSString * TitleString;

@end


@implementation MyActivityIndicatorView


-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"连接中",@"连接成功",@"连接超时",@"连接断开",@"连接错误",@""];
    }
    return _titleArray ;
}

- (NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = @[@"hq_qiehuan",@"hq_qiehuan",@"hq_qiehuan",@"hq_qiehuan",@"hq_qiehuan",@""];
    }
    return _imageArray;
}

-(instancetype)initWithTitleName:(NSString *)Title Style:(ActivityIndicatorStyle)style
{
    _TitleString  = Title;
    _style = style;
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) BgColor:[SXRGB16Color(0X656565) colorWithAlphaComponent:0.3]]) {
        [self show];
    }
    return self ;
}

-(void)show
{
    if (!_bgImageView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, SCREEN_HEIGHT / 2 - 50, 100, 100) BgColor:COLOR_B(0.2)];
        _bgView.layer.contentsScale = 5;
        [self addSubview:_bgView];

        UIActivityIndicatorView * view = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25, 15, 50, 50);
        view.hidesWhenStopped = YES;
        [view startAnimating];
        [_bgView addSubview:view];
  //      _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 15, 50, 50)];
 //       _bgImageView.image = [UIImage imageNamed:self.imageArray[_style]];

  //      _bgImageView.backgroundColor = COLOR_A1;
  //      [_bgView addSubview:_bgImageView];
        
    //    _TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 100, 20) text:_TitleString textColor:[UIColor whiteColor] index:1 size:16];
        [_bgView addSubview:_TitleLabel];
    }else {
        _bgImageView.image = [UIImage imageNamed:self.imageArray[_style]];
        _TitleLabel.text = _TitleString;
    }
}


@end
