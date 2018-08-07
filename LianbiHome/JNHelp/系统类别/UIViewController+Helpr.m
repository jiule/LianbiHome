//
//  UIViewController+Helpr.m
//  duwen
//
//  Created by Apple on 17/3/28.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import "UIViewController+Helpr.h"
#import "MainTabBarViewController.h"


@implementation UIViewController (Helpr)

static AFNetworkReachabilityManager * manager;

+(void)load
{
#ifdef DEBUG //调试状态 打开交换
    Method viewWill = class_getInstanceMethod([UIViewController class], @selector(viewWillAppear:));
    Method HK_viewWill = class_getInstanceMethod([UIViewController class], @selector(HK_viewWillAppear:));
    method_exchangeImplementations(viewWill, HK_viewWill);  //交换成功

    Method viewDisappearl = class_getInstanceMethod([UIViewController class], @selector(viewWillDisappear:));
    Method HK_viewDisappear = class_getInstanceMethod([UIViewController class], @selector(HK_viewWillDisappear:));
    method_exchangeImplementations(viewDisappearl, HK_viewDisappear);  //交换成功
    
#endif
}


-(void)HK_viewWillAppear:(BOOL)animated
{
    [self HK_viewWillAppear:animated];
    MyLog(@"当前控制器是＝＝＝＝＝＝＝＝＝%@",NSStringFromClass([self class]));
}

-(void)HK_viewWillDisappear:(BOOL)animated
{
    [self HK_viewWillDisappear:animated];
    MyLog(@"离开控制器 %@",NSStringFromClass([self class]));
}

+(UIViewController *)getCurrentVCWithView:(UIView *)view
{
    UIViewController * getCurrentVC;
    UIView * getView = view.superview;
    do {
        if ([[[getView nextResponder]class] isSubclassOfClass:[UIViewController class]]) {
            getCurrentVC = (UIViewController *)[getView nextResponder];
            getView = nil;
        }else {
            getView = getView.superview;
        }
    } while (getView);
    if (getCurrentVC) {
            return getCurrentVC;
    }
    return nil;
}

+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView * frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}
+ (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [self topMostWindowController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    return currentViewController;
}
+ (UIViewController*)topMostWindowController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *topController = [window rootViewController];
    while ([topController presentedViewController])    topController = [topController presentedViewController];
    return topController;
}

/*****
 当前控制器添加转场动画
 */
+(void)getCurrentVC:(int)index timer:(CGFloat)timer{
    [self getCurrentVCanimation:[self animationWith:index timer:timer]];
}
+(void)getCurrentVCanimation:(CAAnimation *)animation{
    [[self getCurrentVC].view.layer addAnimation:animation forKey:@"SHOUYE_DONGHUA"];
}
+(void)getCurrentVCanimation:(int)index timer:(CGFloat)timer Withview:(UIView *)animationView{
    [animationView.layer addAnimation:[self animationWith:index timer:timer] forKey:@"SHOUYE_DONGHUA"];
}

-(BOOL)popToViewControllerWithStr:(NSString *)ViewControllerStr
{
    for (UIViewController * v in  self.navigationController.viewControllers) {
        if ([[v class] isSubclassOfClass: NSClassFromString(ViewControllerStr)]) {
            [self.navigationController popToViewController:v animated:YES];
            return YES;
        }
    }
    return NO;
}

-(BOOL)ViewControllerWithStr:(NSString *)ViewControllerStr
{
    for (UIViewController * v in  self.navigationController.viewControllers) {
        if ([[v class] isSubclassOfClass: NSClassFromString(ViewControllerStr)]) {
            return YES;
        }
    }
    return  NO;
}



+(CAAnimation *)animationWith:(int)index timer:(CGFloat )timer
{
    NSArray *array = @[@"pageCurl",@"pageUnCurl",@"rippleEffect",@"suckEffect",@"cube",@"oglFlip",@"kCATransitionFade",@"kCATransitionMoveIn",@"kCATransitionPush",@"kCATransitionReveal"];
    if (index>=array.count&&index<0) {
        return  [CATransition animation];
    }
    CATransition *animation2 = [CATransition animation];
    animation2.type = array[index];
    animation2.duration = timer;
    animation2.subtype = kCATransitionFromRight;
    animation2.delegate = [UIViewController getCurrentVC];
    return  animation2;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [anim removeObserver:self forKeyPath:@"SHOUYE_DONGHUA"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

//-(void)dealloc
//{
//    NSLog(@"%@--被释放",NSStringFromClass([self class]));
//}

@end
