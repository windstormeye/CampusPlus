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
    self.usernameTextField.text = @"";
    self.passwdTextField.text= @"";
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

                    [self dismissViewControllerAnimated:YES completion:nil];
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
