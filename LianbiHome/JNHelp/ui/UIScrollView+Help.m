//
//  UIScrollView+Help.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UIScrollView+Help.h"

@implementation UIScrollView (Help)

//快速创建view
-(instancetype)initWithFrame:(CGRect)frame BgColor:(UIColor *)BgColor
{
    if (self = [super initWithFrame:frame BgColor:BgColor ]) {
        self.showsVerticalScrollIndicator  = NO ;
        self.showsHorizontalScrollIndicator = NO ;
    }
    return self;
}

@end
