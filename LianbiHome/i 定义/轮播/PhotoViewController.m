//
//  PhotoViewController.m
//  相册浏览
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PhotoViewController.h"
@interface PhotoViewController ()
{
    UIImageView *_imgv;
}
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;

    _imgv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_imgv];
    [_imgv setimage:[UIImage imageNamed:@"turn-arrow"] withurl:_imageName];
}

@end
