//
//  DetailVC.m
//  LianbiHome
//
//  Created by admin on 2018/8/7.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "DetailVC.h"
#import "InformationModel.h"

#include <ctype.h>

@interface DetailVC ()<UIWebViewDelegate>
XH_ATTRIBUTE(strong, InformationModel, model);
XH_ATTRIBUTE(strong, UILabel, titleLb);
XH_ATTRIBUTE(strong, UILabel, timeLb);
XH_ATTRIBUTE(strong, UILabel, readNumLb);
XH_ATTRIBUTE(strong, UIWebView, webV);
@end

@implementation DetailVC

-(UIWebView *)webV{
    if (!_webV) {
        _webV = [[UIWebView alloc] init];
        _webV.userInteractionEnabled = NO;
        _webV.dataDetectorTypes = UIDataDetectorTypeAll;
        _webV.delegate = self;
    }
    return _webV;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
    [self creatUI];
}
-(void)loadData{
    [MyNetworkingManager  DDPOSTResqust:@"home/Information/detail" withparameters:@{@"id":self.Id} withVC:self progress:^(NSProgress * _Nonnull progre) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray * arr = (NSArray *)responseObject;
        NSDictionary * dic = arr.firstObject;
        self.model = [[InformationModel alloc] initWithDict:dic];
        [self setMiddleTitle:self.model.post_title];
        self.titleLb.text = self.model.post_title;
        self.timeLb.text = [self computeTime:self.model.published_time];
        self.readNumLb.text = [NSString stringWithFormat:@"阅读%@",self.model.post_hits];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.lianbihome.net/portal/article/index/id/%@.html",self.Id]];
      //  NSLog(@"%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.self.webV loadRequest:request];

//        NSData * data  = [self.model.post_content dataUsingEncoding:NSUTF8StringEncoding];
 //       [self.webV loadHTMLString:self.model.post_content baseURL:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)creatNav{
    LeftButtonItem * left = [[LeftButtonItem alloc] initWithNormalImg:@"back" selectedImg:nil target:self action:@selector(back)];
    [self.naviView addSubview:left];
    RightButtonItem * right = [[RightButtonItem alloc] initWithNormalImg:@"03_tab_share" selectedImg:nil target:self action:@selector(share)];
    [self.naviView addSubview:right];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatUI{
    UIScrollView * scl = [UIScrollView new];
    [scl setBackgroundColor:[UIColor whiteColor]];
    scl.bounces = NO;
    [self.bodyView addSubview:scl];
    [scl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bodyView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIView * containView = [UIView new];
    [scl addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scl).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(scl);
    }];
    self.titleLb = [UIKitAdditions labelWithBlackText:@"" fontSize:20];
    self.titleLb.numberOfLines = 0;
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(containView).offset(JN_HH(20));
        make.centerX.equalTo(containView);
    }];
    self.timeLb = [UIKitAdditions labelWithText:@"" textColor:[UIColor grayColor] alignment:0 fontSize:14];
    [containView addSubview:self.timeLb];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb);
        make.top.equalTo(self.titleLb.mas_bottom).offset(JN_HH(20));
    }];
    self.readNumLb = [UIKitAdditions labelWithText:@"" textColor:[UIColor grayColor] alignment:0 fontSize:14];
    [containView addSubview:self.readNumLb];
    [self.readNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLb.mas_right).offset(JN_HH(30));
        make.top.equalTo(self.timeLb);
    }];
    [containView addSubview:self.webV];
    [self.webV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.readNumLb.mas_bottom).offset(JN_HH(20));
        make.left.centerX.equalTo(self.titleLb);
    }];
    UILabel * lab = [UIKitAdditions labelWithText:@"来源：链币Home\n未经允许请勿转载" textColor:[UIColor grayColor] alignment:0 fontSize:14];
    lab.numberOfLines = 0;
    [containView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.webV.mas_bottom).offset(JN_HH(30));
        make.left.centerX.equalTo(self.webV);
    }];
    UILabel * lab1 = [UIKitAdditions labelWithBlackText:@"关注【链币Home】" fontSize:14];
    [containView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containView);
        make.top.equalTo(lab.mas_bottom).offset(JN_HH(40));
    }];
    UIImageView * imav = [UIKitAdditions imageViewWithImageName:@"03_news_img"];
    [containView addSubview:imav];
    [imav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containView);
        make.top.equalTo(lab1.mas_bottom).offset(JN_HH(10));
    }];
    [containView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imav.mas_bottom).offset(JN_HH(30));
    }];
}
-(NSString *)computeTime:(NSString *)time{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date1 = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSDate * date2 = [NSDate date];
    
    NSTimeInterval aTimer = [date2 timeIntervalSinceDate:date1];
    int hour = (int)(aTimer/3600);
    int minute = (int)(aTimer - hour*3600)/60;
    int second = aTimer - hour*3600 - minute*60;
    NSString *dural = [NSString stringWithFormat:@"%d时%d分%d秒", hour, minute,second];
    if (hour) {
        if (hour / 24) {
            return [NSString stringWithFormat:@"%d天前",hour/24];
        }
        return [NSString stringWithFormat:@"%d小时前",hour];
    }
    if (minute) {
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }
    if (second) {
        return [NSString stringWithFormat:@"%d秒前",second];
    }
    return dural;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    float height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    [self.webV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 20);
    }];
}
#pragma mark 分享点击了
-(void)share{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
