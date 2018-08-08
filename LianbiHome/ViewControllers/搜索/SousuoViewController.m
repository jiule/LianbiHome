//
//  SousuoViewController.m
//  LianbiHome
//
//  Created by Apple on 2018/8/8.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "SousuoViewController.h"
#import "InformationView.h"
#import "DwTableView.h"
#import "InformationModel.h"
#import "KXTableView.h"
#import "DetailVC.h"

@interface SousuoViewController ()<InformationViewDelegate,DwTableViewDelegate,DwTableViewCellDelegate>
{
    NSString * _text;
    InformationView * _informationView;
}

@property(nonatomic,retain)UIView * downView1;

@end

@implementation SousuoViewController

-(instancetype)initWithNavTitle:(NSString *)str text:(NSString *)text
{
    _text = text;
    self = [super initWithNavTitle:str];
    if (self) {
        return self ;
    }
    return nil;
}

-(void)createView
{
    float h = self.nav_h;
    InformationView * inforMarinView = [[InformationView alloc]initWithFrame:CGRectMake(0, h, SCREEN_WIDTH, JN_HH(50))];
    inforMarinView.backgroundColor =  COLOR_WHITE;
    inforMarinView.delegate = self ;
    [self.view addSubview:inforMarinView];

    _informationView = inforMarinView;

    h += JN_HH(50);
    UIView * downView1 = JnUIView(CGRectMake(0,h, SCREEN_WIDTH * 2, SCREEN_HEIGHT - self.nav_h - JN_HH(60)), COLOR_BLACK);
    [self.view addSubview:downView1];

}


@end
