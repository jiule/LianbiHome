//
//  NavBtn.m
//  YB-YH
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "NavBtn.h"

@interface NavBtn()
{
    UILabel * _titleLabel;
}
@end


@implementation NavBtn

-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

@end
