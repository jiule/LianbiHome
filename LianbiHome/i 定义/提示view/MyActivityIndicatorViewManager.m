//
//  MyActivityIndicatorViewManager.m
//  Q-Lady
//
//  Created by Apple on 17/2/17.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import "MyActivityIndicatorViewManager.h"


@interface MyActivityIndicatorViewManager ()

@property(nonatomic,retain)MyActivityIndicatorView * acrivithIndicatorView;

@end

@implementation MyActivityIndicatorViewManager

XMGSingletoM

+(void)showActivityIndicatorViewWithName:(NSString *)name Style:(ActivityIndicatorStyle)style
{

    [self showActivityIndicatorViewWithName:name Style:style withBlock:nil];
}
+(void)showActivityIndicatorViewWithName:(NSString *)name Style:(ActivityIndicatorStyle)style vc:(UIViewController *)vc
{
    [self showActivityIndicatorViewWithName:name Style:style vc:vc withBlock:nil];
}

+(void)showActivityIndicatorViewWithName:(NSString *)name Style:(ActivityIndicatorStyle)style  withBlock:(void(^)(void))sendBlock{
    [self showActivityIndicatorViewWithName:name Style:style vc:nil withBlock:nil];
}
+(void)remove
{
    MyActivityIndicatorViewManager * Manager = [MyActivityIndicatorViewManager sharedInstance];
    if (Manager.acrivithIndicatorView) {
        [Manager.acrivithIndicatorView removeFromSuperview];
    }
}
+(void)showActivityIndicatorViewWithName:(NSString *)name Style:(ActivityIndicatorStyle)style vc:(UIViewController *)vc withBlock:(void(^)(void))sendBlock{
    MyActivityIndicatorViewManager * Manager = [MyActivityIndicatorViewManager sharedInstance];
    if (Manager.acrivithIndicatorView) {
        [Manager.acrivithIndicatorView removeFromSuperview];
    }
    Manager.acrivithIndicatorView = [[MyActivityIndicatorView alloc]initWithTitleName:name Style:style];
    [Manager.acrivithIndicatorView  show];
    if (vc) {
            [vc.view addSubview:Manager.acrivithIndicatorView];
    }else
    {
        [[UIViewController currentViewController].view addSubview:Manager.acrivithIndicatorView];
    }

    if (style == 5) {
        [Manager.acrivithIndicatorView removeFromSuperview];
    }
    if (style != 0) {
        dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sendBlock) {
                    sendBlock();
                }
                [Manager.acrivithIndicatorView removeFromSuperview];
            });
        });
    }else if(style == 0)
    {
        dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            sleep(10);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sendBlock) {
                    sendBlock();
                }
                [Manager.acrivithIndicatorView removeFromSuperview];
            });
        });
    }

}
@end
