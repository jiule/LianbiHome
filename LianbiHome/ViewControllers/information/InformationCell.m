//
//  InformationCell.m
//  LianbiHome
//
//  Created by Apple on 2018/8/6.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "InformationCell.h"

@interface InformationCell()
{
    UILabel * _titleLabel;
    UILabel * _textLabel;
    UILabel * _timerLabel;
    UIImageView * _imageView;
}

@end


@implementation InformationCell

-(void)createCell
{
    float  x = JN_HH(15);
    _titleLabel = JnLabel(CGRectMake(x, JN_HH(5), SCREEN_WIDTH * 0.5, JN_HH(45)), @"", JN_HH(16), SXRGB16Color(0x333333),0 );
    _titleLabel.numberOfLines = 0;
    [self     addSubview:_titleLabel];

    _textLabel = JnLabel(CGRectMake(x, JN_HH(50), SCREEN_WIDTH * 0.5, JN_HH(20)), @"", JN_HH(10), SXRGB16Color(0xb5b6c7),0 );
    [self addSubview:_textLabel];

    _timerLabel = JnLabel(CGRectMake(x, JN_HH(50), SCREEN_WIDTH * 0.5, JN_HH(20)), @"", JN_HH(10), SXRGB16Color(0xb5b6c7),0 );
    [self addSubview:_timerLabel];

    _imageView = JnImageView(CGRectMake(SCREEN_WIDTH * 0.5 + JN_HH(36), JN_HH(5), SCREEN_WIDTH * 0.5 - JN_HH(36) - x, JN_HH(72)), MYimageNamed(@""));
    [self addSubview:_imageView];
}


-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    InformationModel * model = (InformationModel *)tableViewModel;
    _titleLabel.text = model.post_title;
    _textLabel.text = model.post_source;

    float x = [model.post_source widthOfFont:_textLabel.font height:JN_HH(20)];
    [_textLabel setW:x+JN_HH(16)];

    [_timerLabel setX:[_textLabel getX]+_textLabel.width];
    _timerLabel.text =  [NSString stringWithFormat:@"%@",model.published_time];
    _timerLabel.text = [self tiemrWithpublished:model.published_time];

    [_imageView setimageWithurl:TUPIANURL(model.moreModel.thumbnail)];
    if (model.cell_id % 4 != 0) {
        [_titleLabel setW:SCREEN_WIDTH * 0.5];
        [_titleLabel setH:JN_HH(45)];
        [_textLabel setY:JN_HH(50)];
        [_timerLabel setY:JN_HH(50)];
        _imageView.frame = CGRectMake(SCREEN_WIDTH * 0.5 + JN_HH(36), JN_HH(5), SCREEN_WIDTH * 0.5 - JN_HH(36) - JN_HH(15), JN_HH(72));
        [self createcell_h:JN_HH(100) BgColor:COLOR_B5 xian_h:1];

    }else {
        [_titleLabel setW:SCREEN_WIDTH  - JN_HH(30)];
        [_titleLabel setH:JN_HH(30)];
        [_textLabel setY:JN_HH(30)];
        [_timerLabel setY:JN_HH(30)];

        _imageView.frame = CGRectMake(JN_HH(15), JN_HH(60), SCREEN_WIDTH - JN_HH(30), SCREEN_WIDTH  * 0.5- JN_HH(15));
        [self createcell_h:JN_HH(240) BgColor:COLOR_B5 xian_h:1];
    }
}

-(NSString *)tiemrWithpublished:(NSString *)published
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[published intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}


@end
