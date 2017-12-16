//
//  LoginView.m
//  北信+
//
//  Created by #incloud on 16/10/28.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "LoginViewController.h"

#import "ViewController.h"
#import "AppDelegate.h"

#import "MBProgressHUD+NJ.h"
#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>

#import "GModel.h"


@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    
    self.nameTextField.text = @"孙伊凡";
    self.pwTextField.text = @"123456";
}

- (void)initView {
    _loginButton.backgroundColor = mainDeepSkyBlue;
    _signupButton.backgroundColor = mainGreen;
}

+ (void)show {
    UIViewController *vc = [GModel currentViewController];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PJLoginSB" bundle:nil];
    LoginViewController *loginvc = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [vc presentViewController:loginvc animated:true completion:^{
        
    }];
}

- (IBAction)loginButtonClick:(id)sender {
    if (self.nameTextField.text.length == 0)
    {
        [PJHUD showErrorWithStatus:@"用户名"];
    }
    else if (self.pwTextField.text.length == 0)
    {
        [PJHUD showErrorWithStatus:@"密码"];
    }
    else
    {
        [PJHUD showWithStatus:@"正在登录..."];
        [BmobUser loginWithUsernameInBackground:self.nameTextField.text password:self.pwTextField.text block:^(BmobUser *user, NSError *error) {
            if (error)
            {
                NSLog(@"%@", error);
            }
            else
            {
                if (user)
                {
                    [PJHUD dismiss];
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    
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
                    [PJHUD showErrorWithStatus:@"请检查"];
                }
            }
        }];
    }

}
- (IBAction)signupButtonClick:(id)sender {


}

//获取当前屏幕显示的NavigationController
- (UINavigationController *)getCurrentVC
{
    UITabBarController* VC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController* vc = (UINavigationController*)VC.childViewControllers[0];
    return vc;
}


@end
