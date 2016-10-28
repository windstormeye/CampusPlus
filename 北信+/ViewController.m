//
//  ViewController.m
//  北信+
//
//  Created by #incloud on 16/9/13.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "ViewController.h"
#import "HomePageViewController.h"
#import "FindViewController.h"
#import "HelpTableViewController.h"
#import "UserCenterPageViewController.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>

@interface ViewController ()

@property (nonatomic, strong) UITabBarController *contentTabBarController;


@end

@implementation ViewController

- (UITabBarController *)contentTabBarController {
    if (!_contentTabBarController)
    {
        UITabBarController *contentTabBarController = [[UITabBarController alloc] init];
        // 设置tabbar
        HomePageViewController *homePage = [[HomePageViewController alloc] init];
        HelpTableViewController *help = [[HelpTableViewController alloc] init];
        FindViewController *find = [[FindViewController alloc] init];
        UserCenterPageViewController *user = [[UserCenterPageViewController alloc] init];
        UINavigationController *firstContentViewController = [[UINavigationController alloc] initWithRootViewController:homePage];
        UINavigationController *secondContentViewController = [[UINavigationController alloc] initWithRootViewController:help];
        UINavigationController *thirdContentViewController = [[UINavigationController alloc] initWithRootViewController:find];
        UINavigationController *fourContentViewController = [[UINavigationController alloc] initWithRootViewController:user];
        
        contentTabBarController.viewControllers = @[firstContentViewController, secondContentViewController, thirdContentViewController, fourContentViewController];
        self.contentTabBarController = contentTabBarController;
        // 设置tabbar图片
        UIImage *firstImg1 = [self resetImg:@"tab_icon_homepage_normal"];
        UIImage *firstImg2 = [self resetImg:@"tab_icon_homepage_selected"];
        UIImage *secondImg1 = [self resetImg:@"tab_icon_life_normal"];
        UIImage *secondImg2 = [self resetImg:@"tab_icon_life_selected"];
        UIImage *thirdImg1 = [self resetImg:@"tab_icon_discover_normal"];
        UIImage *thirdImg2 = [self resetImg:@"tab_icon_discover_selected"];
        UIImage *fourImg1 = [self resetImg:@"tab_icon_mine_normal"];
        UIImage *fourImg2 = [self resetImg:@"tab_icon_mine_selected"];
        firstContentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:firstImg1 selectedImage:firstImg2];
        secondContentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"代理" image:secondImg1 selectedImage:secondImg2];
        thirdContentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:thirdImg1 selectedImage:thirdImg2];
        fourContentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:fourImg1 selectedImage:fourImg2];
        // 设置tabbar文字颜色
        contentTabBarController.tabBar.tintColor = [UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0];
        // 更改tabbar的背景颜色
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
        backView.backgroundColor = [UIColor whiteColor];
        [contentTabBarController.tabBar insertSubview:backView atIndex:0];
        // 设置底部tabbar为不透明
        contentTabBarController.tabBar.translucent = NO;

    }
    return _contentTabBarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)loadView
{
    [super loadView];
    
    [BmobUser logout];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    [Bmob registerWithAppKey:@"c1b1f0a0d66af132513b58b66df9aa25"];
    [[RCIM sharedRCIM] initWithAppKey:@"kj7swf8o7k8c2"];
    
    [[RCIM sharedRCIM] connectWithToken:@"S6INovIiurjw9zwbXzKs/DeTpnHumjRk5qL8B+hm4JsA2uVqF2raxOSD+kszN10MwDbb3+SwocWM8aBV+JjyqcGy1csRwJ5H" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
    [self addChildViewController:self.contentTabBarController];
    [self.view addSubview:self.contentTabBarController.view];

    BmobUser *bUser = [BmobUser currentUser];
    if (bUser == NULL)
    {
        // 得设置延迟操作，让界面都加载完，因为不能在一个ViewController中进行另外一个Viewcontroller
        [self performSelector:@selector(login) withObject:nil afterDelay:0.1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    LoginViewController *lg = [LoginViewController loginView];
    [self presentViewController:lg animated:YES completion:nil];
}

- (UIImage *)resetImg:(NSString *)name
{
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}



@end
