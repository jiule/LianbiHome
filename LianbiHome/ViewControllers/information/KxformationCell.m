//
//  KxformationCell.m
//  LianbiHome
//
//  Created by Apple on 2018/8/7.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "KxformationCell.h"
#import "InformationModel.h"
#import <UShareUI/UShareUI.h>
#import <UMCommon/UMCommon.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface KxformationCell()<UMSocialShareMenuViewDelegate>
{
    UILabel * _timerLabel;
    UILabel * _titleLabel;
    UILabel * _textLabel;
    UIButton * _lihaoBtn;
    UIButton * _likongBtn;
    UIView * _xianView;
    UIView * _downView;
    UIButton * _fenxiangBtn;
    KxModel * _model;
    UIView * _bgView;
}
@end


@implementation KxformationCell

-(void)createCell
{
  //  [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    _xianView = JnUIView(CGRectMake(JN_HH(15), 0, 1, JN_HH(150)), COLOR_B5);
    [self addSubview:_xianView];

    _timerLabel = JnLabel(CGRectMake(JN_HH(10), JN_HH(5), JN_HH(60), JN_HH(30)), @"", JN_HH(13), SXRGB16Color(0xff7147), 1);
    JNViewStyle(_timerLabel, JN_HH(15), COLOR_B5, 1);
    _timerLabel.backgroundColor = COLOR_B5;
    [self addSubview:_timerLabel];

    float x =JN_HH(20);
    float y = JN_HH(40);
    _titleLabel = JnLabel(CGRectMake(x, y, SCREEN_WIDTH - 2 * x, JN_HH(50)), @"", JN_HH(14.5), COLOR_B1, 0);
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];

    y += JN_HH(50);
    _textLabel = JnLabel(CGRectMake(x, y, SCREEN_WIDTH - 2 * x, JN_HH(60)), @"", JN_HH(14.5), COLOR_B3, 0);
    _textLabel.numberOfLines = 0;
    [self addSubview:_textLabel];
    y += JN_HH(70);

    _downView = JnUIView(CGRectMake(x, y, SCREEN_WIDTH - 2 * x, JN_HH(50)), COLOR_WHITE);
    [self addSubview:_downView];

    _lihaoBtn = JnButton_tag(CGRectMake(0, 0, JN_HH(100), JN_HH(40)), COLOR_WHITE, self, @selector(BtnClick:), 100);
    [_lihaoBtn setImage:MYimageNamed(@"02_lihao") forState:0];
    [_lihaoBtn setImage:MYimageNamed(@"02_lihao1") forState:UIControlStateSelected];
    [_lihaoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, JN_HH(60))];
    [_lihaoBtn setTitle:@"利好 0" forState:0];
    [_lihaoBtn setTitleColor:COLOR_B1 forState:0];
    [[_lihaoBtn titleLabel] setFont:[UIFont systemFontOfSize:JN_HH(13.5)]];
    [_lihaoBtn setTitleColor:SXRGB16Color(0xff7147) forState:UIControlStateSelected];
    [_downView addSubview:_lihaoBtn];

    _likongBtn = JnButton_tag(CGRectMake(JN_HH(110), 0, JN_HH(100), JN_HH(40)), COLOR_WHITE, self, @selector(BtnClick:), 101);

    [_likongBtn setImage:MYimageNamed(@"02_likong") forState:0];
    [_likongBtn setImage:MYimageNamed(@"02_likong1") forState:UIControlStateSelected];
    [_likongBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, JN_HH(60))];
    [_likongBtn setTitle:@"利空 0" forState:0];
    [_likongBtn setTitleColor:COLOR_B1 forState:0];
    [_likongBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [[_likongBtn titleLabel] setFont:[UIFont systemFontOfSize:JN_HH(13.5)]];
    [_downView addSubview:_likongBtn];

    _fenxiangBtn = JnButton_tag(CGRectMake(_downView.width - JN_HH(70), 0, JN_HH(70), JN_HH(40)), COLOR_WHITE, self, @selector(BtnClick:), 102);
    [_fenxiangBtn setImage:MYimageNamed(@"03_tab_share") forState:0];
    [_fenxiangBtn setTitle:@"分享" forState:0];
    [_fenxiangBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, JN_HH(55))];
    [_fenxiangBtn setTitleColor:COLOR_B1 forState:0];
    [[_fenxiangBtn titleLabel] setFont:[UIFont systemFontOfSize:JN_HH(13.5)]];
    [_downView addSubview:_fenxiangBtn];
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    KxModel * model = (KxModel *)tableViewModel;
    _model = model;
    _timerLabel.text = model.issue_time;
    _titleLabel.text = model.title;
    _textLabel.text = model.content;
    float h = [_titleLabel.text HeightOfFont:_titleLabel.font width:_titleLabel.width];
    [_titleLabel setH:h];

    [_textLabel setY:h + JN_HH(5) + [_titleLabel getY]];
    if (model.is_down) {
        [_textLabel setH:[_textLabel.text HeightOfFont:_textLabel.font width:_textLabel.width]];
    }else {
        [_textLabel setH:JN_HH(60)];
    }

    [_downView setY:[_textLabel getY] + JN_HH(5) + _textLabel.height];

    [ _lihaoBtn setTitle:[NSString stringWithFormat:@"利好  %@",model.bull_vote] forState:0];
    [ _likongBtn setTitle:[NSString stringWithFormat:@"利空  %@",model.bad_vote] forState:0];
    if ([model.evaluate isEqualToString:@"bull_vote"]) {
        _lihaoBtn.selected = YES;
        _likongBtn.selected = NO;
    }else if([model.evaluate isEqualToString:@"bad_vote"]){
        _lihaoBtn.selected = NO;
        _likongBtn.selected = YES;
    }else {
        _lihaoBtn.selected = NO;
         _likongBtn.selected = NO;
    }
//    if (model.bull_add) {
//
//    }
    tableViewModel.cell_h = _downView.height + [_downView getY];
    [_xianView setH:tableViewModel.cell_h];
}

-(void)BtnClick:(UIButton *)btn
{
    if (btn.tag == 102) {
        [self share];
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(didsel:btn:model:)]) {
        [self.delegate didsel:self btn:btn model:self.tableViewModel];
    }
}

#pragma mark 分享点击了
-(void)share{
    NSLog(@"%@",[NSString stringWithFormat:@"http://api.456mobi.com/api/?s=home/Newsflash/get_newsflash_pic&id=%@",self->_model.kx_id]);
    _fenxiangBtn.userInteractionEnabled = NO;
    [MyNetworkingManager POST:[NSString stringWithFormat:@"home/Newsflash/get_newsflash_pic&id=%@",self->_model.kx_id] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:[responseDict[@"data"] substringFromIndex:22] options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        // 将NSData转为UIImage
        UIImage *decodedImage = [UIImage imageWithData: decodeData];

        UIView * bgView = JnUIView([UIViewController getCurrentVC].view.bounds, COLOR_B(0.7));
        [bgView addSubview:JnImageView(CGRectMake(JN_HH(30), CGNavView_h() - JN_HH(30), SCREEN_WIDTH - JN_HH(60), SCREEN_HEIGHT - CGNavView_h()), decodedImage)];
        _bgView = bgView;
        [[UIViewController getCurrentVC].view addSubview:bgView];
         _fenxiangBtn.userInteractionEnabled = YES ;
        [UMSocialUIManager  addCustomPlatformWithoutFilted:UMSocialPlatformType_Renren withPlatformIcon:MYimageNamed(@"04_share_img") withPlatformName:@"保存图片"];
        [UMSocialUIManager setShareMenuViewDelegate:self];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            if (platformType == UMSocialPlatformType_Renren) {
                [self loadImageFinished:decodedImage];
            }else {
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
                [shareObject setShareImage:decodedImage];
                //分享消息对象设置分享内容对象
                messageObject.shareObject = shareObject;

                [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController getCurrentVC] completion:^(id data, NSError *error) {
                    if (error) {
                        [MYAlertController showNavViewWith:@"分享失败"];
                    }else{
                        if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                            [MYAlertController showNavViewWith:@"分享成功"];
                        }
                    }
                }];
            }
            [bgView removeFromSuperview];
        }];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _fenxiangBtn.userInteractionEnabled = YES ;
        [_bgView removeFromSuperview];
    }];
}
- (void)loadImageFinished:(UIImage *)image
{
    __block ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {

        if(!error)
        {
            [MYAlertController showNavViewWith:@"保存成功"];
        }
        lib = nil;
    }];
}

- (void)UMSocialShareMenuViewDidDisappear
{
    [_bgView removeFromSuperview];
}


@end
