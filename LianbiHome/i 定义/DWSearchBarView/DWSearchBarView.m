//
//  DWSearchBarView.m
//  i-qlady
//
//  Created by Apple on 2018/2/23.
//  Copyright © 2018年 i-qlady. All rights reserved.
//

#import "DWSearchBarView.h"
#import "MyUserDefaultsManager.h"
#import <AFNetworking.h>

#define DWSEATCHBAR  @"DWSEATCHBAR"

@interface DWSearchBarView() <UISearchBarDelegate>
{
    UISearchBar * _searchBar;
    UITextField * _textField;
    UIViewController * _vc;
    UIView * _upView;
    UIScrollView * _downView;
}


@property(nonatomic,retain)NSMutableArray * seatchbarArrays;

@property(nonatomic,retain)NSMutableArray * upDatasArrays;

@end 

@implementation DWSearchBarView


-(NSMutableArray *)seatchbarArrays
{
    if (!_seatchbarArrays) {
        _seatchbarArrays = [NSMutableArray array];
    }
    return _seatchbarArrays;
}

- (NSMutableArray *)upDatasArrays
{
    if (!_upDatasArrays) {
        _upDatasArrays = [NSMutableArray array];
    }
    return _upDatasArrays;
}


-(instancetype)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return self;
    }
    return nil;
}



-(void)showWithVc:(UIViewController *)vc
{
    _vc = vc;
    float w = vc.view.frame.size.width;
     float h = vc.view.frame.size.height;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    self.frame = CGRectMake(w, 0, w, h);
    [_vc.view addSubview:self];

    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10,CGNavView_20h() + 7, w - 80, 30)];
    UIView * bgView = [[UIView alloc]initWithFrame:_searchBar.frame];
    bgView.backgroundColor = [UIColor whiteColor];
    JNViewStyle(bgView, 15, nil, 0);
    _searchBar.backgroundImage = [self makeImageWithView:bgView withSize:CGSizeMake(_searchBar.frame.size.width, _searchBar.frame.size.height)];
    _searchBar.placeholder = @"";
    _searchBar.delegate = self;
    _searchBar.barTintColor = COLOR_WHITE;
    [_searchBar.layer setCornerRadius:15];
    [self addSubview:_searchBar];

    UITextField * searchTextField = [_searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = COLOR_WHITE;
    searchTextField.textColor = COLOR_B2;
//    [searchTextField becomeFirstResponder];
    _textField = searchTextField;

    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(w - 70, 7 + CGNavView_20h(), 60, 30)];
    [btn setTitle:@"取消" forState:0];
    [btn titleLabel].font = [UIFont systemFontOfSize:16.5];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:btn];

    [self downdata];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = 0;
        self.frame = frame;
    }];
}

-(void)createUpView
{
    float w = self.frame.size.width;
    float x = 20;
    float hei = 50;
    float b_w = (w - 2 * x - 2 * 15) / 3;
    if (!_upView) {
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, CGNavView_h() , w,  200)];
        [self addSubview:_upView];
    }else {
        for (UIView * view in _upView.subviews) {
            [view removeFromSuperview];
        }
    }
   // self.upDatasArrays = [NSMutableArray arrayWithArray:@[@"10",@"11",@"12",@"13"]];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, hei)];
    label.textColor = SXRGB16Color(0x636363);
    label.text = @"热门搜索";
    [_upView addSubview:label];

    for (int i = 0; i <= (self.upDatasArrays.count - 1) / 3; i++) {
        for (int j = 0 ; j < 3; j++) {
            int index = i * 3 + j;
            if (index < self.upDatasArrays.count) {
                UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x + j * (b_w +10), hei *  i + 10 + hei, b_w, hei - 20)];
                [btn setTitle:self.upDatasArrays[index] forState:0];
                btn.tag = 10000+index;
                [btn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_upView addSubview:btn];
                btn.backgroundColor = [UIColor whiteColor];
                [btn.layer setCornerRadius:15];
                if (index < 2) {
                    [btn setTitleColor:[UIColor redColor] forState:0];
                }else {
                    [btn setTitleColor:[UIColor blackColor] forState:0];
                }
            }
        }
    }
    CGRect frame = _upView.frame;
    frame.size.height = ((self.upDatasArrays.count - 1) / 3 + 3) * hei;

    _upView.frame = frame;

    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, frame.size.height - hei, 100, hei)];
    label1.textColor = SXRGB16Color(0x636363);
    label1.text = @"历史搜索";
    [_upView addSubview:label1];

    UIView * xian = [[UIView alloc]initWithFrame:CGRectMake(x, frame.size.height - 1, w - 2 * x,1)];
    xian.backgroundColor = SXRGB16Color(0xd4d4d4);
    [_upView addSubview:xian];

    [self createDownView];

}

-(void)createDownView
{

    float w = self.frame.size.width;
    float h = _vc.view.frame.size.height;
    float x = 20;
    if (!_downView) {
        _downView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGNavView_h() + _upView.frame.size.height, w, h - CGNavView_h() -  _upView.frame.size.height)];
        [self addSubview:_downView];
    }else {
        _downView.frame = CGRectMake(0, CGNavView_h() + _upView.frame.size.height, w, h - CGNavView_h() -  _upView.frame.size.height);
        for (UIView * view in _downView.subviews) {
            [view removeFromSuperview];
        }
    }

    float hei = 0;
    NSArray * downArray = [MyUserDefaultsManager objectForKey:DWSEATCHBAR];
      //  downArray = @[@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0 ; i < downArray.count; i++) {
        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 50 * i + hei, w, 50)];
        [btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_downView addSubview:btn1];

        [btn1 addSubview:JnImageView(CGRectMake( x , 15, 20, 20), MYimageNamed(@"02_searchtime"))];

        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(x + 40, 10, w - 2 * x, 30)];
        label.text  = downArray[i];
        label.textColor = SXRGB16Color(0x333333);
        [btn1 addSubview:label];

        UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(w - 65 , 10, 30, 30)];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"02_delete"] forState:0];
        btn2.tag = 1000+i;
        [btn2 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 100 + i;
        [btn1 addSubview:btn2];

        UIView * xian = [[UIView alloc]initWithFrame:CGRectMake(x, 50 - 1, w - 2 * x,1)];
        xian.backgroundColor = SXRGB16Color(0xd4d4d4);
        [btn1 addSubview:xian];
    }
    _downView.contentSize = CGSizeMake(w, 50 * downArray.count);
    self.seatchbarArrays = [NSMutableArray arrayWithArray:downArray];

    [[Listeningkeyboard sharedInstance]startlisteningblockcompletion:^(CGFloat h) {
        [_downView setH:SCREEN_HEIGHT - CGNavView_h() - _upView.frame.size.height - h];
    } keyboard:^(CGFloat h) {
        [_downView setH:SCREEN_HEIGHT - CGNavView_h() - _upView.frame.size.height ];
    }];

}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0) {
        [self.seatchbarArrays insertObject:searchBar.text atIndex:0];
        [MyUserDefaultsManager setObject:self.seatchbarArrays forkey:DWSEATCHBAR];

        if ([self.delegate respondsToSelector:@selector(DWSearchBarView:text:)]) {
            [self.delegate DWSearchBarView:self text:searchBar.text];
        }
        [self removeFromSuperview];
    }
}

-(void)btnClick
{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = frame.size.width;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

-(void)BtnClick:(UIButton *)btn
{
    NSString * str = [self.seatchbarArrays objectAtIndex:btn.tag - 100];
    [self.seatchbarArrays removeObject:str];
    [self.seatchbarArrays insertObject:str atIndex:0];
    [MyUserDefaultsManager setObject:self.seatchbarArrays forkey:DWSEATCHBAR];
    if ([self.delegate respondsToSelector:@selector(DWSearchBarView:text:)]) {
        [self.delegate DWSearchBarView:self text:str];
        [self removeFromSuperview];
    }

}
-(void)upBtnClick:(UIButton *)btn
{
    NSString * str = self.upDatasArrays[btn.tag - 10000];
    [self.seatchbarArrays removeObject:str];
    [self.seatchbarArrays insertObject:str atIndex:0];
    [MyUserDefaultsManager setObject:self.seatchbarArrays forkey:DWSEATCHBAR];
    if ([self.delegate respondsToSelector:@selector(DWSearchBarView:text:)]) {
        [self.delegate DWSearchBarView:self text:str];
        [self removeFromSuperview];
    }
}



-(void)closeClick:(UIButton *)btn
{
    [self.seatchbarArrays removeObjectAtIndex:btn.tag - 1000];
    [MyUserDefaultsManager setObject:self.seatchbarArrays forkey:DWSEATCHBAR];
    [self createDownView];
}

#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)downdata{

    [MyNetworkingManager GET:@"home/App/hot_search" withparameters:nil progress:^(NSProgress * _Nonnull Progress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * dict = responseDict[@"data"];
        self.upDatasArrays = dict[@"keyword"];
        NSLog(@"%@",dict[@"keyword"]);
//        NSLog(@"%@",self.upDatasArrays.count)
        [self createUpView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    } type:0];
}

@end
