
#import <UIKit/UIKit.h>
#import "MainTabBarViewController.h"
#import "BaseViewController.h"
#import "MyTabBar.h"
#import "MainNavigrtionController.h"

@interface MainTabBarViewController : UITabBarController

@property (nonatomic, copy)NSString *Plistname;     //保存的plist文件名称

@property (nonatomic, retain) NSArray *arrayPlist;   //保存的plist文件的数组

-(instancetype)initWithStringPlist:(NSString *)Plist; // 初始化

- (void)createViewControllers;

-(instancetype)initWithStringPlist:(NSString *)Plist userid:(NSString *)userid;

@end
