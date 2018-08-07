

#import <Foundation/Foundation.h>


#define kHarpyAlertViewTitle        @"版本升级"
#define kHarpyCancelButtonTitle     @"下次再说"
#define kHarpyUpdateButtonTitle     @"马上升级"
#define kAppID                      @"1062467077"


@interface RootViewController : NSObject 
//XMGSingletoH
-(void)chooseRootViewControllerWithwindow:(UIWindow *)window;
-(void)loginOK;
-(void)loginOFF;

@end
