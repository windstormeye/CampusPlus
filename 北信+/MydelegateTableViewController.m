//
//  MydelegateTableViewController.m
//  北信+
//
//  Created by #incloud on 16/11/5.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "MydelegateTableViewController.h"
#import "AgentView.h"
#import "MJRefresh.h"
#import "MBProgressHUD+NJ.h"

#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>

@interface MydelegateTableViewController ()  <RCIMUserInfoDataSource, RCIMGroupInfoDataSource>
//  查询控制器
@property (nonatomic,strong)UISearchController *searchController;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (nonatomic,strong)UIButton *messageBtn;
@property (retain, nonatomic) NSMutableArray *agentArr;
@property (weak, nonatomic) UIButton *cover;
@property (nonatomic,strong) AgentView *agentView;
@end

@implementation MydelegateTableViewController
{
    UITableView *_tableView;
    UIView *_view;
}

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
    [self initView];
}

- (void)initView {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    _tableView = self.tableView;
    _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [_tableView removeFromSuperview];
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = _view;
    [_view addSubview:_tableView];
    [self initNavigationBar];
    self.titleLabel.text = @"我的代理";
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadNewData];
        [_tableView reloadData];
    }];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [_tableView.mj_header beginRefreshing];

}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadNewData
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Test"];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
     {
         for (BmobObject *obj in array)
         {
             if ([[obj objectForKey:@"Acceptor"] isEqualToString:[[BmobUser currentUser] objectForKey:@"username"]])
             {
                 [tempArr addObject:obj];
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             for (int i = 0; i < tempArr.count/2; i++)
             {
                 [tempArr  exchangeObjectAtIndex:i withObjectAtIndex:tempArr.count-1-i];
             }
             self.agentArr = tempArr;
             [_tableView reloadData];
             // 放到这进行下拉刷新的停止
             [_tableView.mj_header endRefreshing];
         });
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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
    AgentView *agent = [AgentView agentView];
    agent.Agent_getBtn.hidden = YES;
    agent.Agent_content.backgroundColor = [UIColor clearColor];
    agent.Agent_content.layer.cornerRadius = 10;
    agent.Agent_content.layer.borderColor = [UIColor whiteColor].CGColor;
    agent.Agent_content.layer.borderWidth = 1;
    agent.Agent_content.textColor = [UIColor whiteColor];
    agent.Agent_content.text = [self.agentArr[indexPath.row] objectForKey:@"Agent_Content"];
    agent.Agent_content.editable = NO;
    agent.Agent_title.text = [self.agentArr[indexPath.row] objectForKey:@"Agent_Title"];
    agent.Agent_money.text = [self.agentArr[indexPath.row] objectForKey:@"Agent_Money"];
    agent.Agent_time.text = [self.agentArr[indexPath.row] objectForKey:@"createdAt"];
    BmobFile *file = (BmobFile*)[self.agentArr[indexPath.row] objectForKey:@"user_pic"];
    NSURL *url = [NSURL URLWithString:file.url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    agent.AgentAvatarImg.image = [UIImage imageWithData:data];
    agent.AgentAvatarImg.clipsToBounds = YES;
    agent.AgentAvatarImg.layer.cornerRadius = agent.AgentAvatarImg.frame.size.width / 2;
    [agent.AvatarBtn addTarget:self action:@selector(AvatarBtnClickMethon:) forControlEvents:UIControlEventTouchUpInside];
    [agent.AvatarBtn setTitle:[self.agentArr[indexPath.row] objectForKey:@"promulgatorId"] forState:UIControlStateNormal];
    [agent.AvatarBtn setTitle:[self.agentArr[indexPath.row] objectForKey:@"Agent_username"] forState:UIControlStateHighlighted];
    agent.Agent_getBtn.tag = indexPath.row;
    [agent.Agent_getBtn addTarget:self action:@selector(Agent_getBtnClickMethon:) forControlEvents:UIControlEventTouchUpInside];
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
    //设置动画，在0.5秒内把这个图片显示出来
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

// 头像点击事件
- (void)AvatarBtnClickMethon:(UIButton *)button
{
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    chat.conversationType = ConversationType_PRIVATE;
    chat.targetId = [button titleForState:UIControlStateNormal];
    chat.enableUnreadMessageIcon = YES;
    chat.enableSaveNewPhotoToLocalSystem = YES;
    chat.enableNewComingMessageIcon = YES;
    chat.title = [button titleForState:UIControlStateHighlighted];
    //显示聊天会话界面
    
    [self removeAll];
    
    // 重要点，不用 self.hidesBottomBarWhenPushed ！！！
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    // 设置聊天界面用户头像为圆形
    [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery getObjectInBackgroundWithId:userId block:^(BmobObject *object,NSError *error){
        if (error)
        {
            NSLog(@"%@", error);
        }
        else
        {
            if (object)
            {
                RCUserInfo *user = [[RCUserInfo alloc] init];
                BmobFile *file = (BmobFile*)[object objectForKey:@"user_pic"];
                user.portraitUri = file.url;
                user.userId = userId;
                user.name = [object objectForKey:@"username"];
                return completion(user);
            }
        }
    }];
}

@end
