//
//  MyActivityIndicatorView.h
//  Q-Lady
//
//  Created by Apple on 17/2/17.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ActivityIndicatorStyle) {
    CONNECTION                     = 0,           //连接中
    CONNECTION_OK                  = 1,           //连接成功
    CONNECTION_OUT                 = 2,           //连接超时
    CONNECTION_BYUSER              = 3,           //连接断开
    CONNECTION_ERROR               = 4,           //连接错误
    CONNECTION_REMOVE              = 5,           
};

@interface MyActivityIndicatorView : UIView

-(instancetype)initWithTitleName:(NSString *)Title Style:(ActivityIndicatorStyle)style;

-(void)show;

@end
