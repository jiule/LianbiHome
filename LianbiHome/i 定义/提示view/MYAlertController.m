//
//  MYAlertController.m
//  Q-Lady
//
//  Created by Apple on 16/12/26.
//  Copyright © 2016年 Q-Lady. All rights reserved.
//

#import "MYAlertController.h"

@interface MYAlertController ()


@property(nonatomic,retain)NSMutableArray * titleArray;

@property(nonatomic,copy)MyPromptwarningViewSelbutton selButton;

@property(nonatomic,copy)NSString * message;

@property(nonatomic,copy)NSArray * messageArrays;

@property(nonatomic,retain)UIView * bgView;

@property(nonatomic,retain)UILabel * messageLabel;

@property(nonatomic,assign)float WW;

@property(nonatomic,assign)float HH;

@property(nonatomic,weak)UIViewController *vc;

@end


@implementation MYAlertController

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc]init];
    }
    return _titleArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.userInteractionEnabled = YES;
        
        _WW = SCREEN_WIDTH - JN_HH(60);
        _HH = JN_HH(150);
        
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(JN_HH(30), SCREEN_HEIGHT * 0.5 - JN_HH(75), _WW, JN_HH(150))BgColor:COLOR_W(9)];
        [self.bgView.layer setCornerRadius:10];
        self.bgView.clipsToBounds = YES;
        [self addSubview:_bgView];

        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _WW, JN_HH(106)) text:@""];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = COLOR_A1;
        _messageLabel.textAlignment = NSTextAlignmentCenter;

        [_bgView addSubview:_messageLabel];


        //分割线的颜色
        [_bgView addSubview:[[UIView alloc]initWithFrame:CGRectMake(0, JN_HH(105), _WW, JN_HH(1.5)) BgColor:DIVIDER_COLOR1]];
    }
    return self;
}


+(void)showTitltle:(NSString *)message selButton:(MyPromptwarningViewSelbutton)selButton   title:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION
{
    MYAlertController * view = [[MYAlertController alloc]initWithFrame:[UIViewController getCurrentVC].view.bounds];
    view.selButton = selButton;
    view.message = message;
    va_list args;
    va_start(args, title);
    for(NSString * str = title ;str != nil;str = va_arg(args,NSString *)){
        [view.titleArray addObject:str];
    }
    [view show];
}
+(void)showTitltleArrays:(NSArray *)titleArrays selButton:(MyPromptwarningViewSelbutton)selButton  title:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION
{
    MYAlertController * view = [[MYAlertController alloc]initWithFrame:[UIViewController getCurrentVC].view.bounds];
    view.selButton = selButton;
    view.messageArrays = titleArrays;
    va_list args;
    va_start(args, title);
    for(NSString * str = title ;str != nil;str = va_arg(args,NSString *)){
        [view.titleArray addObject:str];
    }
    [view show];
}

+(void)showTitltle:(NSString *)message selButton:(MyPromptwarningViewSelbutton)selButton vc:(UIViewController *)vc  title:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION
{
    MYAlertController * view = [[MYAlertController alloc]initWithFrame:[UIViewController getCurrentVC].view.bounds];
    view.selButton = selButton;
    view.message = message;
    view.vc = vc;
    va_list args;
    va_start(args, title);
    for(NSString * str = title ;str != nil;str = va_arg(args,NSString *)){
        [view.titleArray addObject:str];
    }
    [view show];
}

+(void)showTitltle:(NSString *)message selButton:(MyPromptwarningViewSelbutton)selButton
{
    [self showTitltle:message selButton:selButton title:@"确认", nil];
}
+(void)showTitltle:(NSString *)message
{
     [self showTitltle:message selButton:nil];
}

+(void)showTitltle:(NSString *)message vc:(UIViewController *)vc
{
    [self showTitltle:message selButton:nil vc:vc];
}

+(void)showTitltle:(NSString *)message selButton:(MyPromptwarningViewSelbutton)selButton vc:(UIViewController *)vc
{
    [self showTitltle:message selButton:selButton vc:vc title:@"确认", nil];
}

-(void)show
{
    if (_message.length > 0) {
        _messageLabel.text = _message;
    }else if(_messageArrays.count == 2) {
        _messageLabel.text = _messageArrays[0];
        _messageLabel.font = [UIFont systemFontOfSize:20];
        _messageLabel.textColor = COLOR_BL_2;
        _messageLabel.height = JN_HH(50);
        UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(JN_HH(20), JN_HH(45), _WW - JN_HH(40), JN_HH(50)) text:_messageArrays[1]] ;
        textLabel.numberOfLines = 0 ;
        textLabel.textColor = COLOR_BL_3;
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:textLabel];
    }

    if (self.titleArray.count == 1)
    {
        UIButton * btn = JnButtonColorIndexSize(CGRectMake(0, JN_HH(150) - JN_HH(44), _WW, JN_HH(44)), self.titleArray[0], JN_HH(17.5), COLOR_WHITE, [UIColor clearColor], 1, self, @selector(BtnClick:), 10000);
        btn.backgroundColor = COLOR_A1;
        btn.tag = 0;
        [self.bgView addSubview:btn];
    }else if(self.titleArray.count == 2)
    {
        for (int i = 0 ; i < self.titleArray.count; i++)
        {
            UIButton * btn = JnButtonColorIndexSize(CGRectMake(_WW * 0.5 * i, JN_HH(150) - JN_HH(44), _WW * 0.5, JN_HH(44)), self.titleArray[i], JN_HH(17.5), COLOR_A1, [UIColor clearColor], 1, self, @selector(BtnClick:), 10000 + i);
            [_bgView addSubview:btn];
            btn.tag = i;
            if (i != 0) {
                [btn setBackgroundColor:COLOR_A1];
                [btn setTitleColor:[UIColor whiteColor] forState:0];
                [_bgView addSubview:[[UIView alloc]initWithFrame:CGRectMake(_WW * 0.5 - JN_HH(0.75), JN_HH(150) - JN_HH(44), JN_HH(1.5), JN_HH(44)) BgColor:DIVIDER_COLOR1]];
            }
        }
    }
    if (self.vc) {
        [self.vc.view addSubview:self];
    }else {
        [[UIViewController getCurrentVC].view.window addSubview:self];
    }
}

-(void)BtnClick:(UIButton *)btn
{
    if (_selButton) {
          __weak __typeof(self)weakSelf = self;
        _selButton(weakSelf,(int)btn.tag);
    }
    [self  removeFromSuperview];
}

+(void)showNavViewWith:(NSString *)message 
{
    MyPromptwarningView * view =  [[MyPromptwarningView alloc]initWithFrame:CGRectMake(0, -CGNavView_h(), SCREEN_WIDTH, CGNavView_h()) BgColor:[UIColor whiteColor]];
    [view showWithTitle:message];
}
@end

@implementation MyPromptwarningView

-(void)showWithTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGNavView_20h(), SCREEN_WIDTH, 44) text:title];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = COLOR_B1;

    [self addSubview:label];

     [[UIViewController getCurrentVC].view.window addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
         [self setY:0];
    } completion:^(BOOL finished) {
         [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
    }];
    
}

-(void)delayMethod
{
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [self setY:-CGNavView_h()];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
