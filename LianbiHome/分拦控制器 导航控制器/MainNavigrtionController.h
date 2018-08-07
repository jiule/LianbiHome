
//
//
//－－－－－－－－－－－－－－－－－－－－－－－－ 控制横竖屏  －－－－－－－－－－－－－－－－－－－－－
//---------------------------------------  使用方法    －－－－－－－－－－－－－－－－－－－－－
//     MainNavigrtionController *navv=[[MainNavigrtionController alloc]initWithRootViewController:[[kongzhiqiController alloc]init]];
//      navv.InStyle = 2;
//     [self.navigationController presentViewController:navv animated:YES completion:nil];
//----------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@interface MainNavigrtionController : UINavigationController

/****
 MainNavigrtionController的左右屏幕
 */
typedef enum {
    UINavigationController_UIInterfaceOrientationMaskPortrait = 0,//竖屏
    UINavigationController_UIInterfaceOrientationLandscapeLeft,//右
    UINavigationController_UIInterfaceOrientationLandscapeRight//左
} ENUM_UIInterfaceOrientation_ActionType;

/****
 屏幕的显示的方向  强制显示方向
 */
@property (nonatomic,assign) ENUM_UIInterfaceOrientation_ActionType InStyle;
/****
 屏幕的显示的方向  自动显示方向
 */
@property(nonatomic,assign)BOOL NavigationControllerAutomatic;

@end
