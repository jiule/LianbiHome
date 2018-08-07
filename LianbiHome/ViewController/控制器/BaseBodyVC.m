//
//  BaseBodyVC.m
//  YB-YH
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseBodyVC.h"

@interface BaseBodyVC ()

@end

@implementation BaseBodyVC

-(UIView *)bodyView{
    if (!_bodyView) {
        _bodyView = JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h), COLOR_WHITE);
        [self.view addSubview:_bodyView];
        if (self.isRootViewController) {
            [ _bodyView setH:SCREEN_HEIGHT - self.nav_h - self.tab_h];
        }else {
            [_bodyView setH:CGSCREEN_HEIGHT()-self.nav_h];
        }
    }
    return _bodyView;
}

@end
