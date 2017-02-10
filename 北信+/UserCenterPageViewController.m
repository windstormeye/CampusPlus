//
//  UserCenterPageViewController.m
//  北信+
//
//  Created by #incloud on 16/10/26.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "UserCenterPageViewController.h"
#import "MyAllCollectTableViewController.h"
#import "MyAllWrongBookDetailTableViewController.h"
#import "MyActivitiesViewController.h"
#import "MydelegateTableViewController.h"
#import "AboutUsViewController.h"
#import "AnswerChatListViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import <BmobSDK/Bmob.h>


@interface UserCenterPageViewController () <UITableViewDelegate, UITableViewDataSource>

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
    UIImageView *userCenterBackgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
    userCenterBackgroundImgView.image = [UIImage imageNamed:@"usercenter_background"];
    [self.view addSubview:userCenterBackgroundImgView];
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = CGRectMake(0, userCenterBackgroundImgView.frame.size.height - 110, self.view.frame.size.width, 110);
    [userCenterBackgroundImgView addSubview:effectView];
    //设置模糊透明度
    effectView.alpha = 0.2;
    
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
    userNameLabel.font = [UIFont boldSystemFontOfSize:20];
    [userCenterBackgroundImgView addSubview:userNameLabel];
    
    UILabel *schoolNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabel.frame.origin.x, CGRectGetMaxY(userNameLabel.frame) + 5, self.view.frame.size.width - userNameLabel.frame.origin.x, 20)];
    schoolNameLabel.text = [[BmobUser currentUser] objectForKey:@"School"];
    schoolNameLabel.textColor = [UIColor whiteColor];
    schoolNameLabel.font = [UIFont boldSystemFontOfSize:14];
    [userCenterBackgroundImgView addSubview:schoolNameLabel];
    
//    UILabel *classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(schoolNameLabel.frame.origin.x, CGRectGetMaxY(schoolNameLabel.frame) + 5, self.view.frame.size.width - classNameLabel.frame.origin.x, 20)];
    UILabel *classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(schoolNameLabel.frame.origin.x, CGRectGetMaxY(schoolNameLabel.frame) + 5, self.view.frame.size.width - schoolNameLabel.frame.origin.x, 20)];
    classNameLabel.text = [[BmobUser currentUser] objectForKey:@"Class"];
    classNameLabel.textColor = [UIColor whiteColor];
    classNameLabel.font = [UIFont boldSystemFontOfSize:14];
    [userCenterBackgroundImgView addSubview:classNameLabel];
    
    UIImageView *attestationSign = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userNameLabel.frame) + 10, userNameLabel.frame.origin.y, 50, 15)];
    attestationSign.image = [UIImage imageNamed:@"authenticated"];
    [userCenterBackgroundImgView addSubview:attestationSign];
    
    UIImageView *goldSign = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, classNameLabel.frame.origin.y + 15, 20, 20)];
    goldSign.image = [UIImage imageNamed:@"mine_gold"];
    [userCenterBackgroundImgView addSubview:goldSign];
    
    UILabel *goldNumSign = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - goldSign.frame.size.width - 40, goldSign.frame.origin.y, 50, 20)];
    goldNumSign.text = [[BmobUser currentUser] objectForKey:@"goldNums"];
    goldNumSign.textColor = [UIColor whiteColor];
    goldNumSign.font = [UIFont boldSystemFontOfSize:14];
    [userCenterBackgroundImgView addSubview:goldNumSign];
    
    UITableView *userCenterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(userCenterBackgroundImgView.frame), self.view.frame.size.width, self.view.frame.size.height - userCenterBackgroundImgView.frame.size.height - 54 * 2 - 5)];
    userCenterTableView.backgroundColor = [UIColor whiteColor];
    userCenterTableView.delegate = self;
    userCenterTableView.dataSource = self;
    userCenterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    userCenterTableView.contentSize = CGSizeMake(0 ,userCenterTableView.frame.size.height + 54);
    
    [self.view addSubview:userCenterTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return 1;
    }
    else if(section == 1)
    {
        return 6;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cellFlag";
    //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.1];
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 60)];
        [cell addSubview:btnView];
        UIButton *firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, cell.frame.size.width / 2 - 5, 60)];
        firstBtn.backgroundColor = [UIColor whiteColor];
        [firstBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [firstBtn setTitle:@"我的关注：9" forState:UIControlStateNormal];
        firstBtn.font = [UIFont systemFontOfSize:16];
        [btnView addSubview:firstBtn];
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstBtn.frame), 0, 5, 60)];
        middleView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.1];
        [cell addSubview:middleView];
        UIButton *secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(middleView.frame), 0, cell.frame.size.width / 2 - 10, 60)];
        secondBtn.backgroundColor = [UIColor whiteColor];
        secondBtn.font = [UIFont systemFontOfSize:16];
        [secondBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [secondBtn setTitle:@"我的粉丝：11" forState:UIControlStateNormal];
        [btnView addSubview:secondBtn];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%d", (int)indexPath.row, (int)indexPath.row]];
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"我的收藏";
                break;
            case 1:
                cell.textLabel.text = @"我的消息";
                break;
            case 2:
                cell.textLabel.text = @"我的代理";
                break;
            case 3:
                cell.textLabel.text = @"错题本";
                break;
            case 4:
                cell.textLabel.text = @"我的活动";
                break;
            case 5:
                cell.textLabel.text = @"关于我们";
                break;
        }
        return cell;

    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        UIButton *cellBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width - 40, 40)];
        cellBtn.backgroundColor = [UIColor colorWithRed:220/255.0 green:20/255.0 blue:60/255.0 alpha:1.0];
        [cell addSubview:cellBtn];
        [cellBtn addTarget:self action:@selector(cellBtnClickMethon) forControlEvents:UIControlEventTouchUpInside];
        cellBtn.clipsToBounds = YES;
        cellBtn.layer.cornerRadius = 10;
        
        UILabel *cellTextLabel = [[UILabel alloc] initWithFrame:CGRectMake((cellBtn.frame.size.width / 2 - 20), 3, 40, 30)];
        cellTextLabel.textAlignment = NSTextAlignmentCenter;
        cellTextLabel.text = @"退出";
        cellTextLabel.textColor = [UIColor whiteColor];
        [cellBtn addSubview:cellTextLabel];
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);

    if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                self.hidesBottomBarWhenPushed = YES;
                MyAllCollectTableViewController *cl = [[MyAllCollectTableViewController alloc] init];
                [self.navigationController pushViewController:cl animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 1:
            {
                self.hidesBottomBarWhenPushed = YES;
                AnswerChatListViewController *cl = [[AnswerChatListViewController alloc] init];
                [self.navigationController pushViewController:cl animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 2:
            {
                self.hidesBottomBarWhenPushed = YES;
                MydelegateTableViewController *cl = [[MydelegateTableViewController alloc] init];
                [self.navigationController pushViewController:cl animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 3:
            {
                self.hidesBottomBarWhenPushed = YES;
                MyAllWrongBookDetailTableViewController *cl = [[MyAllWrongBookDetailTableViewController alloc] init];
                [self.navigationController pushViewController:cl animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 4:
            {
                self.hidesBottomBarWhenPushed = YES;
                MyActivitiesViewController *cl = [[MyActivitiesViewController alloc] init];
                [self.navigationController pushViewController:cl animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 5:
            {
                self.hidesBottomBarWhenPushed = YES;
                AboutUsViewController *cl = [[AboutUsViewController alloc] init];
                [self.navigationController pushViewController:cl animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)cellBtnClickMethon
{
    [BmobUser logout];
    BmobUser *bUser = [BmobUser currentUser];
    if (bUser == NULL)
    {
        LoginViewController *lg = [LoginViewController loginView];
        AppDelegate* appDelagete = [UIApplication sharedApplication].delegate;
        appDelagete.window.rootViewController = lg;
    }
    else
    {
        ViewController *view = [[ViewController alloc] init];
        AppDelegate* appDelagete = [UIApplication sharedApplication].delegate;
        appDelagete.window.rootViewController = view.contentTabBarController;
    }
}




@end
