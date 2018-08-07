//
//  InformationView.h
//  LianbiHome
//
//  Created by Apple on 2018/8/6.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InformationView;

@protocol  InformationViewDelegate <NSObject>

@optional

-(void)InformationView:(InformationView *)informationView index:(int)index;

@end


@interface InformationView : UIView

-(void)showWithLeftBtn:(BOOL)left;

@property(nonatomic,assign)id <InformationViewDelegate>delegate;

@end
