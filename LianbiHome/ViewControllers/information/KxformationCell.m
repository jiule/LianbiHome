//
//  KxformationCell.m
//  LianbiHome
//
//  Created by Apple on 2018/8/7.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "KxformationCell.h"
#import "InformationModel.h"


@interface KxformationCell()
{
    UILabel * _timerLabel;
    UILabel * _titleLabel;
    UILabel * _textLabel;
    UIButton * _lihaoBtn;
    UIButton * _likongBtn;
    UIView * _xianView;
    UIView * _downView;
    UIButton * _fenxiangBtn;
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

    [_downView addSubview: JnButtonImageTag(CGRectMake(_downView.width - JN_HH(44), JN_HH(10) , JN_HH(20), JN_HH(20)), MYimageNamed(@"03_tab_share"), self, @selector(BtnClick:), 102)];
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    KxModel * model = (KxModel *)tableViewModel;
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
    if ([self.delegate respondsToSelector:@selector(didsel:btn:model:)]) {
        [self.delegate didsel:self btn:btn model:self.tableViewModel];
    }
}


    


@end
