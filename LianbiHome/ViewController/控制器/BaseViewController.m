//
//  BaseViewController.m
//  XM
//
//  Created by Macintosh HD on 16/4/16.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navView insertUp];
    [self downDatas];
    [self addListeningkeyboard];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopListeningkeyboard];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self Initialize];
    [self createNavView];
    [self createView];
    [self downData];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.isRootViewController = YES;
        _dict = dict;
    }
    return self;
}
-(instancetype)initWithNavTitle:(NSString *)str
{
    _titlestr = str ;
    if (self = [super init]) {
        self.isRootViewController = NO;
    }
    return self;
}
-(instancetype)initWithNavTitle:(nullable NSString *)str data:(id)data
{
    return [self initWithNavTitle:str];
}
#pragma mark---Post
-(void)postdownDatas:(NSString *)str adddict:(nullable NSDictionary *)dict index:(int)index {
    [self postdownDatas:str withdict:[MyNetworkingHelp addSidWithDict:dict] index:index];
}

-(void)postdownDatas:(NSString *)str withdict:(NSDictionary *)dict index:(int)index
{
    [self postdownDatas:str withdict:dict index:index type:Encryption_TYPE0];
}

-(void)postdownDatas:(NSString *)str withdict:(NSDictionary *)dict index:(int)index type:(Encryption_TYPE)type
{
    JNWeakSelf(self);
    [weakself.view addSubview:self.actView];
    [MyNetworkingManager POST:str withparameters:dict progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakself.actView removeFromSuperview];
        if (responseObject) {
            id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (responseDict) {
                if (index >= 500) {
                    [weakself readDowndatawithResponseDict:responseDict index:index];
                }else if(index >= 1)
                {
                    [weakself readDowndatawithResponseDict:responseDict[@"data"] index:index];
                }else {
                    [weakself readDowndatawithArray:responseDict[@"data"] index:index];
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself duxucuowu:error index:index];
        [weakself.actView removeFromSuperview];
    }];
}
-(void)getDownDatas:(NSString *)str withdict:(NSDictionary *)dict index:(int)index type:(Encryption_TYPE)type
{
    JNWeakSelf(self);
    [weakself.view addSubview:self.actView];
    [MyNetworkingManager GET:str withparameters:dict progress:^(NSProgress * _Nonnull Progress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakself.actView removeFromSuperview];
        if (responseObject) {
            id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (responseDict) {
                if (index >= 500) {
                    [weakself readDowndatawithResponseDict:responseDict index:index];
                }else if(index >= 1)
                {
                    [weakself readDowndatawithResponseDict:responseDict[@"data"] index:index];
                }else {
                    [weakself readDowndatawithArray:responseDict[@"data"] index:index];
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself duxucuowu:error index:index];
        [weakself.actView removeFromSuperview];
    } type:type];
}



#pragma mark----读取下载数据
-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index{}
#pragma mark----下载数据错误
-(void)readDowndatawithArray:(NSArray *)dataArray index:(int)index{
    MyLog(@"子类未重写读取数据");
}
#pragma mark----读取错误信息
-(void)duxucuowu:(NSError *)error index:(int)index{

    MyLog(@"子类未重写错误======%@",error);
    
}
-(void)readcuowu:(NSString *)cuowu index:(int)index {}
        
#pragma mark---创建刷新小按钮
-(void)createShuaxin{}
#pragma mark-----返回按钮的代理
-(void)clickonReturn{FANHUI_JIUSHITU ;}
#pragma mark-----跳转试图
-(void)popControllerwithstr:(NSString *)str title:(NSString *)title
{
    Class cls =  NSClassFromString(str);
    if (cls) {
        BaseViewController * vc = [[cls alloc]initWithNavTitle:title];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        NSLog(@"不存在%@控制器",str);
    }
}

-(void)shuaxinView{    MyLog(@"子类重写刷新的状态");}
#pragma mark----页面即将出现  下载的数据
-(void)downDatas{}
#pragma mark-----初始化 下载的数据
-(void)downData{}
#pragma mark----加载view
-(void)createView{    }
#pragma mark----初始化一些数据
-(void)Initialize
{
    self.navigationController.navigationBarHidden=YES;
    [self.view addSubview:[[UIView alloc]init]];
    self.view.backgroundColor = COLOR_B6;
}
#pragma mark-----自定义导航拦
-(void)createNavView
{
    if (!_titlestr) {
        _navView = [[NavView alloc]initWithFrame:CGRectZero title:[_dict objectForKey:@"NAVBAR_TITLE_IMAGE_NAME"]];
        [_navView isfanhuiBtn:NO];
    }else {
        _navView = [[NavView alloc]initWithFrame:CGRectZero title:_titlestr ];
        [_navView isfanhuiBtn:YES];
        [self.navView addDividingLine];
    }
    _navView.delegate = self;
    [self.view addSubview:_navView];
    [_navView addDividingLine];
}

-(UIActivityIndicatorView *)actView
{
    if (_actView == nil)
    {
        _actView = [UIImage downloadingImageActivityIndicatorView:CGRectMake(self.view.bounds.size.width/2-5,self.view.bounds.size.height/2-5 , 10, 10)];
        [self.view addSubview:_actView];
    }
    return _actView;
}
-(void)addUIApplicationDidBecomeActiveNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Fromthebackground)
                                                 name:UIApplicationDidBecomeActiveNotification  object:nil];
}
-(void)removeUIApplicationDidBecomeActiveNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
#pragma mark-----后台进入前台
-(void)Fromthebackground{ NSLog(@"后台进入的前台");}

#pragma mark----设备状态改变的方法
-(void)CameraStatus{}

-(float)tab_h
{
    if (isIPhoneX)
       return  44.0f;
       return  0.f;
}
-(float)nav_h{
    return CGNavView_h();
}

-(void)clickRightButton:(UIButton *)rightBtn
{
    [self popControllerwithstr:@"KeFuViewController" title:@"在线客服"];
}

-(void)addListeningkeyboard
{}

-(void)stopListeningkeyboard
{
    [Listeningkeyboard endEditing];
}

-(void)dealloc
{
    NSLog(@"%@--被释放",NSStringFromClass([self class]));
}


@end



