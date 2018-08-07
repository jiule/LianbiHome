
#import "RootViewController.h"
#import "MainTabBarViewController.h"
#import "InformationViewController.h"





@interface RootViewController()

@property (strong, nonatomic) UIWindow *window;


@end

@implementation RootViewController

XMGSingletoM

-(void)chooseRootViewControllerWithwindow:(UIWindow *)window
{
    self.window = window;
    [Helpr Initialize];

    [self loginOFF];
    [window makeKeyAndVisible];
    return  ;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //获取本地版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sandboxVersion = [defaults valueForKey:@"sandboxVersion"];
    //判断是否显示新特性
    if ([currentVersion compare:sandboxVersion] == NSOrderedDescending) {
        // 更新本地保存的版本号
        [defaults setValue:currentVersion forKey:@"sandboxVersion"];
       [self loginOFF];
    }else
    {
        [self loginOFF];
#ifdef release
         [self performSelectorInBackground:@selector(test) withObject:nil];
#endif
    }
   [window makeKeyAndVisible];
}

-(void)loginOK
{
     //   NSLog(@"%@",[PersonalModel sharedInstance].invite_code);
    MainTabBarViewController *tab = [[MainTabBarViewController alloc]initWithStringPlist:@"YB-YH"];
    self.window.rootViewController = tab;
}

-(void)loginOFF
{
    InformationViewController * vc = [[InformationViewController alloc]init];
    self.window.rootViewController = [[MainNavigrtionController alloc]initWithRootViewController:vc];
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"      //方法弃用

-(void)test{
    
#if TARGET_IPHONE_SIMULATOR//模拟器
    
#elif TARGET_OS_IPHONE//真机

#endif
    
    /**
     *  版本更新
     */
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", kAppID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ( [data length] > 0 && !error ) { // Success
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                if ( ![versionsInAppStore count] ) { // No versions of app in AppStore
                    return;
                }
                else {
                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
                    
                    if ([currentVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kHarpyAlertViewTitle
                                                                            message:[NSString stringWithFormat:@"发现新版本(%@),是否更新", currentAppStoreVersion]
                                                                           delegate:self
                                                                  cancelButtonTitle:kHarpyCancelButtonTitle
                                                                  otherButtonTitles:kHarpyUpdateButtonTitle, nil];
                        alertView.tag = [kAppID intValue];
                        [alertView show];
                    }
                    else {
                     //   MyLog(@"等于");
                        return;
                    }
                }
            });
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( alertView.tag == [kAppID intValue] ) {
        switch ( buttonIndex ) {
            case 0:{
           //     MyLog(@"----下次再说");
            } break;
            case 1:{ // Update
                NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", kAppID];
                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                [[UIApplication sharedApplication] openURL:iTunesURL];
            } break;
            default:
                break;
        }
    }
}
#pragma clang diagnostic pop

@end
