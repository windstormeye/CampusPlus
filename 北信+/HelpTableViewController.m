//
//  HelpTableViewController.m
//  北信+
//
//  Created by #incloud on 16/9/18.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "HelpTableViewController.h"
#import "HelpDateilsViewController.h"
#import "HelpThings.h"
#import "MyDelegatesViewController.h"
#import "AgentView.h"

#import <BmobSDK/Bmob.h>

@interface HelpTableViewController ()

//  查询控制器
@property (nonatomic,strong)UISearchController *searchController;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (nonatomic,strong)UIButton *messageBtn;
@property (retain, nonatomic) NSMutableArray *agentArr;
@property (weak, nonatomic) UIButton *cover;
@property (nonatomic,strong) AgentView *agentView;



@end

@implementation HelpTableViewController

-(NSMutableArray *)agentArr
{
    if (!_agentArr)
    {
        _agentArr = [[NSMutableArray alloc] init];
    }
    return _agentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
 
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Test"];
    //查找GameScore表的数据
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
    {
        for (BmobObject *obj in array)
        {
            [tempArr addObject:obj];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.agentArr = tempArr;
            [self.tableView reloadData];
        });
    }];
    
//    在GameScore创建一条数据，如果当前没GameScore表，则会创建GameScore表
//    BmobObject  *gameScore = [BmobObject objectWithClassName:@"Test"];
//    
//    NSLog(@"%@", [[BmobUser currentUser] valueForKey:@"objectId"]);
//    
//    [gameScore setObject:[[BmobUser currentUser] valueForKey:@"objectId"] forKey:@"promulgatorId"];
//    [gameScore setObject:[NSString stringWithFormat:@"帮我取快递"] forKey:@"Agent_Content"];
//    [gameScore setObject:[NSString stringWithFormat:@"100"] forKey:@"Agent_Money"];
//    [gameScore setObject:[NSString stringWithFormat:@"取快递"] forKey:@"Agent_Title"];
//    [gameScore setObject:[[BmobUser currentUser] objectForKey:@"user_pic"] forKey:@"user_pic"];
//    [gameScore setObject:[[BmobUser currentUser] objectForKey:@"username"] forKey:@"Agent_username"];
//
//
//    //异步保存到服务器
//    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        if (isSuccessful) {
//            //创建成功后会返回objectId，updatedAt，createdAt等信息
//            //创建对象成功，打印对象值
//            NSLog(@"%@",gameScore);
//        } else if (error){
//            //发生错误后的动作
//            NSLog(@"%@",error);
//        } else {
//            NSLog(@"Unknow error");
//        }
//    }];
    
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0]];
    //设置navigationbar为不透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationItem.title = @"校园代理";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:@selector(messageBtnClickMethon)];
//
    
    UIButton *messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width - 40, 5, 30, 30)];
    self.messageBtn = messageBtn;
    [messageBtn setImage:[UIImage imageNamed:@"mydelegate_white"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageBtnClickMethon) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:messageBtn];
}

// 我的答疑点击事件
- (void)messageBtnClickMethon
{
    self.hidesBottomBarWhenPushed = YES;
    MyDelegatesViewController * AC = [[MyDelegatesViewController alloc] init];
    [self.navigationController pushViewController:AC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.agentArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BmobFile *file = (BmobFile*)[self.agentArr[indexPath.row] objectForKey:@"user_pic"];
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
    titleLabel.text = [self.agentArr[indexPath.row] objectForKey:@"Agent_Title"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [cell addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame) + 10, cell.frame.size.width - titleLabel.frame.origin.x - 60, 20)];
    contentLabel.text = [self.agentArr[indexPath.row] objectForKey:@"Agent_Content"];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor grayColor];
    [cell addSubview:contentLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 125, titleLabel.frame.origin.y, 130, 20)];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = [self.agentArr[indexPath.row] objectForKey:@"createdAt"];
    [cell addSubview:timeLabel];
    
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 5, contentLabel.frame.origin.y, 40, 20)];
    moneyLabel.text = [NSString stringWithFormat:@"¥：%@", [self.agentArr[indexPath.row] objectForKey:@"Agent_Money"]];
    moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0 alpha:1.0];
    moneyLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:moneyLabel];
      
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.hidesBottomBarWhenPushed = YES;
//    HelpDateilsViewController *help = [[HelpDateilsViewController alloc] init];
//    [self.navigationController pushViewController:help animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
    
    AgentView *agent = [AgentView agentView];
    agent.Agent_content.backgroundColor = [UIColor clearColor];
    agent.Agent_content.layer.cornerRadius = 10;
    agent.Agent_content.layer.borderColor = [UIColor whiteColor].CGColor;
    agent.Agent_content.layer.borderWidth = 1;
    agent.Agent_content.textColor = [UIColor whiteColor];
    agent.view.frame = CGRectMake(0, 0, 250, 330);
    agent.view.center = self.navigationController.view.center;
    agent.view.layer.cornerRadius = 13.0f;
    agent.view.alpha = 0.0;
    agent.view.clipsToBounds = YES;
    
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
        agent.view.alpha = 1.0;
    }];
    
    self.agentView = agent;
    [self.tabBarController.view addSubview:agent.view];
    [self.tabBarController.view   bringSubviewToFront:agent.view];
}

- (void)removeAll
{
    // 设置动画
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0.0;
        self.agentView.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.agentView.view removeFromSuperview];
        [self.cover removeFromSuperview];
        self.cover = nil;
    }];
}


@end
