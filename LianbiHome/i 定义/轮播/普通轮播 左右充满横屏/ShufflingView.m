//
//  ShufflingView.m
//  i-qlady
//
//  Created by Apple on 17/4/24.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import "ShufflingView.h"

@interface ShufflingView ()  <UIScrollViewDelegate>

@property(nonatomic,copy)didShuffling shuffling;

@property(nonatomic,retain)NSArray * urlPaths;

@property(nonatomic,retain)NSArray * imageArrays;

@property(nonatomic,retain)UIImage * placeholderImage;

@property(nonatomic,retain)UIView * placeholderImageView;

@property(nonatomic,assign)  float btnW ;

@property(nonatomic,assign)  float btnH ;

@property(nonatomic,assign)  float btnY ;

@property(nonatomic,assign)  float btnX ;

@property(nonatomic,assign)  int  index ;

@property(nonatomic,assign)NSTimer * timer;

@property(nonatomic,assign) int  jiange;

@property(nonatomic,assign) int cornerRadius;

@end


@implementation ShufflingView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _btnW = self.width;
        _btnH = self.height;
        _btnX = 0;
        _btnY = ([self getSizi_H] - _btnH) / 2;
        _jiange = 0 ;
        _cornerRadius = 5 ;
        _time = 5;
        self.clipsToBounds = YES ;
    }
    return self ;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    _btnW = self.width;
    _btnH = self.height;
    _btnX = 0;
    _btnY = ([self getSizi_H] - _btnH) / 2;
    _jiange = 0 ;
    _cornerRadius = 5 ;
    _time = 5;
    self.clipsToBounds = YES ;
    [self createView];
    [self createView1];
    [self startTimer];
}
-(UIImage *)placeholderImage
{
    if (!_placeholderImage)
    _placeholderImage = [UIImage imageNamed:@"placeholderImage"];
    return _placeholderImage ;
}

-(void)showWithImageUrlPaths:(NSArray *)urlPaths didShuffling:(didShuffling)shuffling
{
    _shuffling = shuffling ;
    _urlPaths = urlPaths;
    
    [self setNeedsDisplay];
    return;
  //  _urlPaths = _imageArray;
    [self createView];
    [self createView1];
    [self startTimer];
}
-(void)showWithImageImagePaths:(NSArray *)imagePaths didShuffling:(didShuffling)shuffling
{
    _shuffling = shuffling ;
    _imageArrays = imagePaths;
    [self createView];
    [self createView1];
    [self startTimer];
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    _urlPaths = _imageArray;
    [self createView];
    [self startTimer];
    
}

-(void)setUrlPaths:(NSArray *)urlPaths
{
    _imageArray = urlPaths;
    [self createView];
}

-(void)createView1
{
    for (UIView * view in self.subviews) {
        if(view.tag <= -60)
        {
            [view removeFromSuperview];
        }
    }
    [self addSubview:JnButtonImageTag(CGRectMake(0, 0, JN_HH(50), self.height), MYimageNamed(@"sy_zuoerduo"), self, @selector(leftClick), -60)];
    [self addSubview:JnButtonImageTag(CGRectMake(self.width - JN_HH(50), 0, JN_HH(50), self.height), MYimageNamed(@"sy_youerduo"), self, @selector(rightClick), -61)];
}

-(void)createView
{

    if (_placeholderImageView) {
        _placeholderImageView.frame = CGFrameWithJNFrame(CGRectMake(0, 0, _btnW * (_urlPaths.count + 2), _btnH));

    }else {
        if(_urlPaths.count > 0){
              _placeholderImageView = JNUIView(CGRectMake(0, 0, _btnW * (_urlPaths.count + 2), _btnH), self.backgroundColor);
        }else {
            _placeholderImageView = JNUIView(CGRectMake(0, 0, _btnW * (_imageArrays.count + 2), _btnH), self.backgroundColor);
        }


        [self addSubview:_placeholderImageView];
        
        [_placeholderImageView addswipeGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
            if ([[tap class] isSubclassOfClass:[UISwipeGestureRecognizer class] ]) {
                UISwipeGestureRecognizer * ges = (UISwipeGestureRecognizer *)tap;
                if (ges.direction ==  UISwipeGestureRecognizerDirectionLeft) {
                    [self SwipePlaceholderImageView:YES];
                }else  if(ges.direction ==  UISwipeGestureRecognizerDirectionRight)
                {
                    [self SwipePlaceholderImageView:NO];
                }
            }
        }];
    }
        for (UIView * view in _placeholderImageView.subviews) {
            [view removeFromSuperview];
        }
    for (int i = 0 ; i < _urlPaths.count ; i++) {
        [_placeholderImageView addSubview:[self placeholderButtonWithSizeFrame:CGRectMake(_btnW * i + _btnW + _jiange, _btnY, _btnW - _jiange * 2 , _btnH) Image:_urlPaths[i] tag:100 +i ]];
    }
    for (int i = 0 ; i < _imageArrays.count ; i++) {
        [_placeholderImageView addSubview:JNButtonImageTag(CGRectMake(_btnW * i + _btnW + _jiange, _btnY, _btnW - _jiange * 2 , _btnH), MYimageNamed(_imageArrays[i]), self, @selector(BtnClick:), 100 +i)];
    }

    if ([_placeholderImageView viewWithTag:100 + (int)_urlPaths.count] == nil) {
            [_placeholderImageView addSubview:[self placeholderButtonWithSizeFrame:CGRectMake(_btnW * _urlPaths.count + _btnW + _jiange, _btnY, _btnW - _jiange * 2 , _btnH) Image: _urlPaths[0] tag:100 + (int)_urlPaths.count ]];
    }
    if ([_placeholderImageView viewWithTag:99] == nil) {
             [_placeholderImageView addSubview:[self placeholderButtonWithSizeFrame:CGRectMake(_jiange, _btnY, _btnW - _jiange * 2 , _btnH) Image: _urlPaths[_urlPaths.count -  1] tag:99 ]];
    }
    //初始化放在第一个
     _index = 1 ;
    [self setPlaceholder:_index];
    [self createView1]; //添加左右小耳朵
    [self startTimer];
    [self endTimer];
}

-(void)BtnClick:(UIButton *)btn
{
    int index = (int)btn.tag - 100;
    if (index == -1) {
        index += _urlPaths.count;
    }
    if (index >= _urlPaths.count) {
        index = 0;
    }
    if (_shuffling) {
        _shuffling(self,index);
    }
}
#pragma mark----设置 _placeholderImageView 显示位子
-(void)setPlaceholder:(int)index
{
      [_placeholderImageView setSizi_X:_btnX - _btnW * index];
}
#pragma mark----设置 _placeholderImageView上面按钮的显示图片
-(UIButton *)placeholderButtonWithSizeFrame:(CGRect)Frame Image:(NSString *)imageUrl tag:(int)tag
{
    UIButton * btn = JNButtonImageTag(Frame, self.placeholderImage, self, @selector(BtnClick:), tag);
    [btn setBackgroundImage:nil withUrl:imageUrl];
    JNViewStyle(btn, _cornerRadius, nil, 0);
    return btn;
}
#pragma mark----是不是index ＋ 1个
-(void)SwipePlaceholderImageView:(BOOL)isLeft
{
    int index = (int)_urlPaths.count;
    if(_imageArrays.count >0)
    {
        index = (int)_imageArrays.count;
    }
    if (isLeft) {
        if (_index == index + 1) {
            _index = 1;
            [self setPlaceholder:_index];
        }
        _index ++ ;
        [UIView animateWithDuration:0.2 animations:^{
            [self setPlaceholder:self->_index];
        } completion:^(BOOL finished) {
            if (self->_index == index + 1) {
                self->_index = 1 ;
                [self setPlaceholder:self->_index];
            }
        }];
    }else {
        if (_index == 1) {
            _index = index + 1 ;
            [self setPlaceholder:_index];
        }
        _index -- ;
        [UIView animateWithDuration:0.2 animations:^{
            [self setPlaceholder:self->_index];
        } completion:^(BOOL finished) {
            if (self->_index == 1) {
                self->_index = index + 1 ;
                [self setPlaceholder:self->_index];
            }
        }];
    }
}

-(void)updateTimer
{
    if (_urlPaths.count >= 3) {
        [self SwipePlaceholderImageView:YES];
    }else if(_imageArrays.count >=3){
        [self SwipePlaceholderImageView:YES];
    }
}

-(void)startTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    _timer.fireDate = [NSDate distantPast];
}

-(void)endTimer
{
    _timer.fireDate = [NSDate distantFuture];
    [_timer invalidate]; // 销毁timer
    _timer = nil; // 置nil
}

-(void)setStyle:(int)style
{
    _type = style;
    if (style == 1 ) {
        _btnW = [self getSizi_W];
        _btnH = [self getSizi_H];
        _btnX = 0;
        _btnY = 0;
        _jiange = 0 ;
        _cornerRadius = 0 ;
    }
}

-(void)leftClick
{
    [self SwipePlaceholderImageView:NO];
}
-(void)rightClick
{
    [self SwipePlaceholderImageView:YES];
}

@end
