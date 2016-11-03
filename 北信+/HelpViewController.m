//
//  HelpViewController.m
//  北信+
//
//  Created by #incloud on 16/11/2.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpTableViewController.h"
#import "AnswerChatListViewController.h"
#import "demandView.h"
#import "MyGetAgentView.h"

#import "MBProgressHUD+NJ.h"

#import <BmobSDK/Bmob.h>


@interface HelpViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UIButton *cover;
@property (weak, nonatomic) demandView *de;
@property (weak, nonatomic) HelpTableViewController *help;
@property (weak, nonatomic) MyGetAgentView *my;
@property (retain, nonatomic) NSMutableArray *getAgentArr;


@end

@implementation HelpViewController

-(NSMutableArray *)getAgentArr
{
    if (!_getAgentArr)
    {
        _getAgentArr = [[NSMutableArray alloc] init];
    }
    return _getAgentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0]];
    //设置navigationbar为不透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationItem.title = @"校园代理";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIButton *messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width - 40, 5, 30, 30)];
    [messageBtn setImage:[UIImage imageNamed:@"mydelegate_white"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(mydelegateBtnClickMethon) forControlEvents:UIControlEventTouchUpInside];
    // 固定按钮在rightButtonItem位置上
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    HelpTableViewController *help = [[HelpTableViewController alloc] init];
    self.help = help;
    [self addChildViewController: help];
    [self.view addSubview:help.view];
    
    UIButton *mydelegate = [[UIButton alloc] initWithFrame:CGRectMake(190, self.view.frame.size.height - 180, 60, 60)];
    [mydelegate setImage:[UIImage imageNamed:@"agent_user_me"] forState:UIControlStateNormal];
    [mydelegate addTarget:self action:@selector(mydelegateBtnClickMethon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mydelegate];
    
    UIButton *newdelegate = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(mydelegate.frame) + 5, mydelegate.frame.origin.y, 60, 60)];
    [newdelegate setImage:[UIImage imageNamed:@"add_agent"] forState:UIControlStateNormal];
    [newdelegate addTarget:self action:@selector(newdelegateClickMethon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newdelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 我的代理点击事件
- (void)mydelegateBtnClickMethon
{
    
    // 我的代理点击事件并不能成功--------------------------------------------
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Test"];
    //查找GameScore表的数据
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
     {
         for (BmobObject *obj in array)
         {
             if ([[obj objectForKey:@"Acceptor"] isEqualToString:[[BmobUser currentUser] objectForKey:@"username"]])
             {
                 NSLog(@"%@", obj);
                 [tempArr addObject:obj];
                 continue;
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             for (int i = 0; i < tempArr.count/2; i++)
             {
                 [tempArr  exchangeObjectAtIndex:i withObjectAtIndex:tempArr.count-1-i];
             }
             self.getAgentArr = tempArr;
         });
     }];
    
    MyGetAgentView *my = [MyGetAgentView getAgentView];
    my.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.my = my;
    my.center = self.view.center;
    my.layer.cornerRadius = 10;
    my.clipsToBounds = YES;
    my.tableView.delegate = self;
    
    // 创建蒙板按钮
    UIButton *btnCover = [[UIButton alloc]init];
    // 设置蒙板按钮的大小
    btnCover.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height);
    // 设置蒙板按钮的颜色
    btnCover.backgroundColor = [UIColor blackColor];
    // 设置蒙板按钮的透明度，开始先设置为0，使用动画进行变化
    btnCover.alpha = 0.0;
    // 添加蒙板按钮至最底层的View中
    [self.tabBarController.view addSubview:btnCover];
    self.cover = btnCover;
    // 为按钮注册一个单击事件
    [btnCover addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    //设置动画，在0.5秒内把这个图片变大
    [UIView animateWithDuration:0.3 animations:^{
        btnCover.alpha = 0.6;
        my.alpha = 1.0;
    }];
    
    [self.tabBarController.view addSubview:my];     // 此处一定不能写成self.navigationController.view，否则会把发布界面置于最下层
    [self.tabBarController.view  bringSubviewToFront:my];
}

// 添加代理
- (void)newdelegateClickMethon
{
    demandView *de = [demandView demandView];
    self.de = de;
    de.center = self.view.center;
    de.layer.cornerRadius = 10;
    de.clipsToBounds = YES;
    de.textView.layer.borderWidth = 0.3;
    de.textView.layer.cornerRadius = 10;
    de.viewTitle.text = @"发布需求";
    de.titleTextField.placeholder = @"请输入需求标题";
    [de.sureBtn addTarget:self action:@selector(uploadDataDemand) forControlEvents:UIControlEventTouchUpInside];
    
    // 创建蒙板按钮
    UIButton *btnCover = [[UIButton alloc]init];
    // 设置蒙板按钮的大小
    btnCover.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height);
    // 设置蒙板按钮的颜色
    btnCover.backgroundColor = [UIColor blackColor];
    // 设置蒙板按钮的透明度，开始先设置为0，使用动画进行变化
    btnCover.alpha = 0.0;
    // 添加蒙板按钮至最底层的View中
    [self.tabBarController.view addSubview:btnCover];
    self.cover = btnCover;
    // 为按钮注册一个单击事件
    [btnCover addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    //设置动画，在0.5秒内把这个图片变大
    [UIView animateWithDuration:0.3 animations:^{
        btnCover.alpha = 0.6;
        de.alpha = 1.0;
    }];
    
    [self.tabBarController.view addSubview:de];     // 此处一定不能写成self.navigationController.view，否则会把发布界面置于最下层
    [self.tabBarController.view   bringSubviewToFront:de];

}

- (void)removeAll
{
    // 设置动画
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0.0;
        self.my.alpha = 0.0;
        self.de.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.my removeFromSuperview];
        [self.de removeFromSuperview];
        [self.cover removeFromSuperview];
        self.cover = nil;
        [MBProgressHUD hideHUD];
    }];
}

- (void)uploadDataDemand
{
    //    在GameScore创建一条数据，如果当前没GameScore表，则会创建GameScore表
    BmobObject  *gameScore = [BmobObject objectWithClassName:@"Test"];
    
    [gameScore setObject:[[BmobUser currentUser] valueForKey:@"objectId"] forKey:@"promulgatorId"];
    [gameScore setObject:self.de.textView.text forKey:@"Agent_Content"];
    [gameScore setObject:self.de.moneyTextField.text forKey:@"Agent_Money"];
    [gameScore setObject:self.de.titleTextField.text forKey:@"Agent_Title"];
    [gameScore setObject:[[BmobUser currentUser] objectForKey:@"user_pic"] forKey:@"user_pic"];
    [gameScore setObject:[[BmobUser currentUser] objectForKey:@"username"] forKey:@"Agent_username"];
    
    //异步保存到服务器
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            //创建对象成功，打印对象值
            NSLog(@"%@",gameScore);
            [MBProgressHUD showSuccess:@"发布成功，请稍等..."];
            [self.help loadNewData];
            [self removeAll];
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error);
        } else {
            NSLog(@"Unknow error");
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.getAgentArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cellFlag";
    //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BmobFile *file = (BmobFile*)[self.getAgentArr[indexPath.row] objectForKey:@"user_pic"];
    NSURL *url = [NSURL URLWithString:file.url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImageView *avatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
    avatarImg.image = [UIImage imageWithData:data];
    avatarImg.layer.cornerRadius = avatarImg.frame.size.width / 2;
    avatarImg.clipsToBounds = YES;
    avatarImg.layer.borderWidth = 0.5;
    avatarImg.layer.borderColor = [UIColor grayColor].CGColor;
    [cell addSubview:avatarImg];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(avatarImg.frame) + 10, avatarImg.frame.origin.y - 10, 60, 30)];
    titleLabel.text = [self.getAgentArr[indexPath.row] objectForKey:@"Agent_Title"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [cell addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame) + 10, cell.frame.size.width - titleLabel.frame.origin.x - 60, 20)];
    contentLabel.text = [self.getAgentArr[indexPath.row] objectForKey:@"Agent_Content"];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor grayColor];
    [cell addSubview:contentLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 125, titleLabel.frame.origin.y, 130, 20)];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = [self.getAgentArr[indexPath.row] objectForKey:@"createdAt"];
    [cell addSubview:timeLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 5, contentLabel.frame.origin.y, 40, 20)];
    moneyLabel.text = [NSString stringWithFormat:@"¥：%@", [self.getAgentArr[indexPath.row] objectForKey:@"Agent_Money"]];
    moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0 alpha:1.0];
    moneyLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:moneyLabel];
    
    return cell;
}

//获取当前屏幕显示的NavigationController
- (UINavigationController *)getCurrentVC
{
    UITabBarController* VC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController* vc = (UINavigationController*)VC.childViewControllers[1];
    return vc;
}

@end
