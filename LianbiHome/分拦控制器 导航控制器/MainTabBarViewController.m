
#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()<MyTabBarDelegate,UITabBarControllerDelegate>
{
    NSString *_userid;
    NSString *_str;
}
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)initWithStringPlist:(NSString *)Plist userid:(NSString *)userid
{
    if (self=[self initWithStringPlist:Plist]) {
        _userid=userid;
    }
    return self;
}

-(instancetype)initWithStringPlist:(NSString *)Plist
{
    if (self=[super init]) {
        _Plistname=Plist;;
        // 读取Plist文件
        [self loadPlistFile];
        // 创建管理的视图控制器
        [self createViewControllers];
        // 定制tabBar
        [self createTabBar];
    }
    return self;
}

#pragma mark - 加载plist文件
- (void)loadPlistFile
{
    NSString *plistPath=[[NSBundle mainBundle] pathForResource:_Plistname  ofType:@"plist"];
    self.arrayPlist = [NSArray arrayWithContentsOfFile:plistPath];
}

#pragma mark - 创建子视图控制器
- (void)createViewControllers
{
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSDictionary *dict in self.arrayPlist) {
        // 取到视图控制器的名称字符串
        NSString *clsName = [dict objectForKey:@"CLASS_NAME"]; // News
        // 取到类对象
        Class cls = NSClassFromString(clsName); // News
        if (cls) {
            if ([clsName isEqual:@""]) {
                // 根据类对象，创建视图控制器
                BaseViewController *vc = [[cls alloc] initWithDict:dict ];
                [viewControllers addObject:vc];
            }else {
                // 根据类对象，创建视图控制器
                BaseViewController *vc = [[cls alloc] initWithDict:dict];
                MainNavigrtionController *nav = [[MainNavigrtionController alloc] initWithRootViewController:vc];
                nav.title=[dict objectForKey:@"NAVBAR_TITLE_IMAGE_NAME"];
                [viewControllers addObject:nav];
            }
        } else {
            NSLog(@"名为%@的类不存在", clsName);
        }
    }
    self.viewControllers = viewControllers;
}

#pragma mark - 定制分栏
- (void)createTabBar
{
//    UIImageView * iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -Tabbar_49h(), SCREEN_WIDTH, Tabbar_49h()) image:[UIImage imageNamed:@"Tab"]];
//    [self.tabBar addSubview:iamgeView];
    // 创建自定制的tabBar,并添加到分栏控制器的tabbar上
    MyTabBar *tabBar = [[MyTabBar alloc] init];
#pragma mark----设置分栏的个数
    tabBar.index1=(int)self.arrayPlist.count;
    //   tabBar.frame = self.tabBar.bounds;
    tabBar.frame=CGRectMake(self.tabBar.bounds.origin.x, self.tabBar.bounds.origin.y, self.tabBar.bounds.size.width, Tabbar_49h());
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    // tabBar.backgroundColor=[UIColor whiteColor];
    // [tabBar setImage:[UIImage  imageNamed:@"tab_6"]];
    // 给tabBar添加分栏按钮
    for (NSDictionary *dict in self.arrayPlist) {
        // 取到图片名
        NSString *imgName = [dict objectForKey:@"TABBAR_IMAGE_NORMAL"];
        NSString *selImgName = [dict objectForKey:@"TABBAR_IMAGE_SELECTED"];
        NSString *name=[dict objectForKeyedSubscript:@"TABBAR_IMAGE_NAME"];
        // 创建分栏按钮
        [tabBar addItemWithImageName:selImgName selImageName:imgName name:name];
    }
    //设置默认选中的第几个
      self.selectedIndex = 0;
}

#pragma makr - MyTabBarDelegate 协议
- (void)tabBar:(MyTabBar *)tabBar didSelectItemWithIndex:(NSUInteger)toIndex
{
    self.selectedIndex = toIndex;
}

@end
