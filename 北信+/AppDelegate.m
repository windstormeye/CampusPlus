//
//  AppDelegate.m
//  北信+
//
//  Created by #incloud on 16/9/13.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "HelpViewController.h"
#import "FindViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *contentTabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = contentTabBarController;
    // 设置tabbar
    HomePageViewController *homePage = [[HomePageViewController alloc] init];
    HelpViewController *help = [[HelpViewController alloc] init];
    FindViewController *find = [[FindViewController alloc] init];
    UINavigationController *firstContentViewController = [[UINavigationController alloc] initWithRootViewController:homePage];
    UINavigationController *secondContentViewController = [[UINavigationController alloc] initWithRootViewController:help];
    UINavigationController *thirdContentViewController = [[UINavigationController alloc] initWithRootViewController:find];
    contentTabBarController.viewControllers = [[NSArray alloc] initWithObjects:firstContentViewController, secondContentViewController, thirdContentViewController, nil];
    // 设置tabbar图片
    UIImage *firstImg1 = [self resetImg:@"tab_icon_homepage_normal"];
    UIImage *firstImg2 = [self resetImg:@"tab_icon_homepage_selected"];
    UIImage *secondImg1 = [self resetImg:@"tab_icon_life_normal"];
    UIImage *secondImg2 = [self resetImg:@"tab_icon_life_selected"];
    UIImage *thirdImg1 = [self resetImg:@"tab_icon_discover_normal"];
    UIImage *thirdImg2 = [self resetImg:@"tab_icon_discover_selected"];
    firstContentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:firstImg1 selectedImage:firstImg2];
    secondContentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"代理" image:secondImg1 selectedImage:secondImg2];
    thirdContentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:thirdImg1 selectedImage:thirdImg2];
    // 设置tabbar文字颜色
    contentTabBarController.tabBar.tintColor = [UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0];
    // 更改tabbar的背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [contentTabBarController.tabBar insertSubview:backView atIndex:0];
    // 设置底部tabbar为不透明
    contentTabBarController.tabBar.translucent = NO;
    // 让当前window成为主窗口并显示出来
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    return YES;
}

- (UIImage *)resetImg:(NSString *)name
{
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
