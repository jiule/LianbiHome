//
//  DWSearchBarView.h
//  i-qlady
//
//  Created by Apple on 2018/2/23.
//  Copyright © 2018年 i-qlady. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DWSearchBarView;

@protocol DWSearchBarViewDelegate <NSObject>

@optional

/// 告诉代理一个字符串
-(void)DWSearchBarView:(DWSearchBarView *)seatchBarView text:(NSString *)text;

@end


@interface DWSearchBarView : UIView



-(void)showWithVc:(UIViewController *)vc;

@property(nonatomic,assign)id<DWSearchBarViewDelegate>delegate;
@end
