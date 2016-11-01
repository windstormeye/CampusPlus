//
//  AnswerChatListViewController.m
//  北信+
//
//  Created by #incloud on 16/10/28.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "AnswerChatListViewController.h"
#import "HelpTableViewController.h"
#import <BmobSDK/Bmob.h>


@interface AnswerChatListViewController ()

@end

@implementation AnswerChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.title = @"我的答疑";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 隐藏未显示的cell并且已显示的cell
    self.conversationListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    // 设置聊天列表界面和聊天界面用户头像为圆形
    [RCIM sharedRCIM].globalConversationAvatarStyle=RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;

    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery getObjectInBackgroundWithId:conversationVC.targetId block:^(BmobObject *object,NSError *error){
        if (error)
        {
            //进行错误处理
            NSLog(@"%@", error);
        }
        else
        {
            if (object)
            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                });
                // 设置从聊天列表界面进入当前聊天界面时的titleView
                conversationVC.title = [object objectForKey:@"username"];
            }
        }
    }];
    
    [self.navigationController pushViewController:conversationVC animated:YES];
}

@end
