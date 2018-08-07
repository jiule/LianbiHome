//
//  DwTableViewCell.m
//  DW_kuangjia
//
//  Created by Apple on 2017/10/30.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import "DwTableViewCell.h"

@implementation DwTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}
//子类重新这个方法
-(void)createCell
{
    NSLog(@"子类需要重新写这个方法");
}
//这个子类必须要先调用父类的方法
-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    _tableViewModel = tableViewModel;
}

-(void)createcell_h:(CGFloat)cellh BgColor:(UIColor *)BgColor xian_h:(CGFloat)xian_h
{
    UIColor * bgColor = BgColor;
    if (bgColor == nil) {
        bgColor = DIVIDER_COLOR1;
    }
    self.tableViewModel.cell_h = cellh;
    CGRect Frame=CGRectMake(0,  self.tableViewModel.cell_h - xian_h, SCREEN_WIDTH, xian_h);
    if (_xianView) {
        [_xianView removeFromSuperview];
    }
    UIImage * xianImage = [UIImage makeImageWithView:JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, xian_h), bgColor) withSize:CGSizeMake(SCREEN_WIDTH, xian_h)];
    _xianView = [[UIImageView alloc]initWithFrame:(CGRect)Frame image:xianImage];
    [self addSubview:_xianView];
}

@end
