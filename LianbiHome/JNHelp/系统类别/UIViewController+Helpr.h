//---------------------------------------------
//
// 
//
//
//
//
//
//----------------------------------------------

#import <UIKit/UIKit.h>
#import <objc/message.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Helpr) <CAAnimationDelegate>
/*
 *  返回当前显示的控制器
 */
+ ( UIViewController * )getCurrentVC;
+ (UIViewController *)currentViewController;
+ (nullable UIViewController *)getCurrentVCWithView:(UIView *)view;

/*****
 * 当前控制器添加转场动画  index:0-9 timer:时长  调用这个方法添加动画效果
 * 0 向上翻一页
 * 1 向下翻一页
 * 2 滴水效果
 * 3 收缩效果
 * 4 立方体
 * 5 上下翻转
 * 6 交叉淡化
 * 7 新视图移到旧视图
 * 8 新视图把旧视图推
 * 9 将旧视图移开,显示下面的新视图
 */
+(void)getCurrentVC:(int)index  timer:(CGFloat)timer;
/**
 *  添加自定义动画效果
 *
 *  @param animation 动画
 */
+(void)getCurrentVCanimation:(CAAnimation *)animation;

+(void)getCurrentVCanimation:(int)index timer:(CGFloat)timer Withview:(UIView *)animationView;
/*
 * 返回到指定控制器
 */
-( BOOL)popToViewControllerWithStr:(NSString *)ViewControllerStr;
/**
 * 判断当前控制器里 包含不包含这个控制器
 */
-(BOOL)ViewControllerWithStr:(NSString *)ViewControllerStr;

+(CAAnimation *)animationWith:(int)index timer:(CGFloat )timer;

@end
NS_ASSUME_NONNULL_END
