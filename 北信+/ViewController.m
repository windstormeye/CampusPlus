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
#import "YiSlideMenu.h"

#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>

@interface ViewController ()

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

- (void)viewDidAppear:(BOOL)animated
{
    BmobUser *bUser = [BmobUser currentUser];
    if (bUser == NULL)
    {
        LoginViewController *lg = [LoginViewController loginView];
        AppDelegate* appDelagete = [UIApplication sharedApplication].delegate;
        appDelagete.window.rootViewController = lg;
    }
    else
    {
        AppDelegate* appDelagete = [UIApplication sharedApplication].delegate;
        appDelagete.window.rootViewController = self.contentTabBarController;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 做测试，测试完成后删除
//    [BmobUser logout];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    [Bmob registerWithAppKey:@"c1b1f0a0d66af132513b58b66df9aa25"];
    [[RCIM sharedRCIM] initWithAppKey:@"kj7swf8o7k8c2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    LoginViewController *lg = [LoginViewController loginView];
    [self presentViewController:lg animated:NO completion:nil];
}

- (UIImage *)resetImg:(NSString *)name
{
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}



@end
