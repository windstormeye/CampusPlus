//
//  LoginView.m
//  北信+
//
//  Created by #incloud on 16/10/28.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

#import "MBProgressHUD+NJ.h"
#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;



@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginBtn.layer.cornerRadius = 10;
    self.usernameTextField.text = @"孙伊凡";
    self.passwdTextField.text= @"123456";
}

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"Login" owner:nil options:nil] firstObject];
}

- (IBAction)loginBtnClickMethon:(id)sender
{
    if (self.usernameTextField.text.length == 0)
    {
        [MBProgressHUD showError:@"请填写用户名"];
    }
    else if (self.passwdTextField.text.length == 0)
    {
        [MBProgressHUD showError:@"请填写密码"];
    }
    else
    {
        [MBProgressHUD showMessage:@"正在登录..." toView:self.view];
        [BmobUser loginWithUsernameInBackground:self.usernameTextField.text password:self.passwdTextField.text block:^(BmobUser *user, NSError *error) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            if (error)
            {
                NSLog(@"%@", error);
            }
            else
            {
                if (user)
                {
                    [MBProgressHUD showSuccess:@"登录成功"];
                    ViewController *vc = [[ViewController alloc] init];
                    AppDelegate* appDelagete = [UIApplication sharedApplication].delegate;
                   appDelagete.window.rootViewController = vc.contentTabBarController;
                    
                    // 登录成功后的记录下token的操作应该放在这
                    [[RCIM sharedRCIM] connectWithToken:[[BmobUser currentUser] objectForKey:@"Token"] success:^(NSString *userId) {
                        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                    } error:^(RCConnectErrorCode status) {
                        NSLog(@"登陆的错误码为:%ld", (long)status);
                    } tokenIncorrect:^{
                        //token过期或者不正确。
                        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                        NSLog(@"token错误");
                    }];
                }
                else
                {
                    [MBProgressHUD showError:@"登陆失败，请确认账号密码是否正确"];
                }
            }
        }];
    }
    
}

//获取当前屏幕显示的NavigationController
- (UINavigationController *)getCurrentVC
{
    UITabBarController* VC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController* vc = (UINavigationController*)VC.childViewControllers[0];
    return vc;
}


@end
