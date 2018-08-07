//
//  MYAlertController.h
//  Q-Lady
//
//  Created by Apple on 16/12/26.
//  Copyright © 2016年 Q-Lady. All rights reserved.
//

@class MYAlertController;

typedef void (^MyPromptwarningViewSelbutton)(MYAlertController * AlertController,int index);

#import <UIKit/UIKit.h>


@interface MYAlertController : UIView

+(void)showTitltle:(NSString *)message selButton:(MyPromptwarningViewSelbutton)selButton  title:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION;

+(void)showTitltle:(NSString *)message selButton:(MyPromptwarningViewSelbutton)selButton ;

+(void)showTitltle:(NSString *)message;
+(void)showTitltle:(NSString *)message vc:(UIViewController *)vc;
+(void)showTitltle:(NSString *)message selButton:(MyPromptwarningViewSelbutton)selButton vc:(UIViewController *)vc ;
//重上到下的 页面下来
+(void)showNavViewWith:(NSString *)message ;

+(void)showTitltleArrays:(NSArray *)titleArrays selButton:(MyPromptwarningViewSelbutton)selButton  title:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION;
@end

@interface MyPromptwarningView : UIView

-(void)showWithTitle:(NSString *)title;

@end
