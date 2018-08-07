

#import "MainNavigrtionController.h"

@interface MainNavigrtionController ()

@end

@implementation MainNavigrtionController

// 这个方法在类出现时会调用一次，并且只会调用一次
+ (void)initialize{
    [super initialize];
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController InStyle:(ENUM_UIInterfaceOrientation_ActionType)style{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.InStyle=style;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 导航的跟视图控制器被显示时，不需要设置影藏底部栏的属性
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if (self.InStyle==0) return  UIInterfaceOrientationPortrait;  //竖屏
    else if(self.InStyle==1)  return UIInterfaceOrientationLandscapeRight; //横屏
    else if(self.InStyle==2)  return UIInterfaceOrientationLandscapeLeft;
    else return  UIInterfaceOrientationPortrait;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.InStyle==0) return  UIInterfaceOrientationMaskPortrait;
    else if(self.InStyle==1) return UIInterfaceOrientationMaskLandscapeRight;
    else if(self.InStyle==2) return UIInterfaceOrientationMaskLandscapeLeft;
    else return  UIInterfaceOrientationMaskPortrait;
}
-(void)setInStyle:(ENUM_UIInterfaceOrientation_ActionType)InStyle
{
    _InStyle=InStyle;
    [self supportedInterfaceOrientations];
}

@end
