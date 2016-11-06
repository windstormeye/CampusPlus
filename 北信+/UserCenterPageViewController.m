//
//  UserCenterPageViewController.m
//  北信+
//
//  Created by #incloud on 16/10/26.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "UserCenterPageViewController.h"
#import <BmobSDK/Bmob.h>


@interface UserCenterPageViewController ()

@end

@implementation UserCenterPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0]];
    //设置navigationbar为不透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationItem.title = @"个人中心";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    [self initUserCenterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUserCenterView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImageView *userCenterBackgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
    userCenterBackgroundImgView.image = [UIImage imageNamed:@"usercenter_background"];
    [scrollView addSubview:userCenterBackgroundImgView];
    [self.view addSubview:scrollView];
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = CGRectMake(0, userCenterBackgroundImgView.frame.size.height - 110, self.view.frame.size.width, 110);
    [userCenterBackgroundImgView addSubview:effectView];
    //设置模糊透明度
    effectView.alpha = 0.1;
    
    UIImageView *userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    BmobFile *file = (BmobFile*)[[BmobUser currentUser] objectForKey:@"user_pic"];
    NSURL *url = [NSURL URLWithString:file.url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    userImgView.image = [UIImage imageWithData:data];
    // 设置用户头像为圆形
    userImgView.layer.cornerRadius = userImgView.frame.size.width / 2;
    userImgView.clipsToBounds = YES;
    userImgView.layer.borderWidth = 1;
    userImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    // 设置用户头像Button
    UIButton *userCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userCenterButton.frame = CGRectMake(10, (userCenterBackgroundImgView.frame.size.height - 90), 70, 70);
    [userCenterButton addSubview:userImgView];
    [userCenterBackgroundImgView addSubview:userCenterButton];
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userCenterButton.frame) + 5, userCenterButton.frame.origin.y, 60, 20)];
    userNameLabel.text = [[BmobUser currentUser] objectForKey:@"username"];
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.font = [UIFont systemFontOfSize:20];
    [userCenterBackgroundImgView addSubview:userNameLabel];
    
    UILabel *schoolNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabel.frame.origin.x, CGRectGetMaxY(userNameLabel.frame) + 5, self.view.frame.size.width - userNameLabel.frame.origin.x, 20)];
    schoolNameLabel.text = [[BmobUser currentUser] objectForKey:@"School"];
    schoolNameLabel.textColor = [UIColor whiteColor];
    schoolNameLabel.font = [UIFont systemFontOfSize:14];
    [userCenterBackgroundImgView addSubview:schoolNameLabel];
    
    UILabel *classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(schoolNameLabel.frame.origin.x, CGRectGetMaxX(schoolNameLabel.frame) + 5, self.view.frame.size.width - classNameLabel.frame.origin.x, 20)];
    
}












@end
