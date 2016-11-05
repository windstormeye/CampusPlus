//
//  MyAllCollectDetailViewController.m
//  北信+
//
//  Created by #incloud on 16/11/5.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "MyAllCollectDetailViewController.h"
#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>

@interface MyAllCollectDetailViewController () <RCIMUserInfoDataSource, RCIMGroupInfoDataSource>
@property (nonatomic ,retain) NSMutableArray *paperArr;



@end

@implementation MyAllCollectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    __block CGFloat lastY = 0.0;
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Questions"];
    [bquery getObjectInBackgroundWithId:self.paperId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            if (object)
            {
                UIWebView *firstWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3 + 20)];
                NSString *url1 = [object objectForKey:@"Q_url"];
                // 解决URL带有中文
                url1 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *URL = [NSURL URLWithString:url1];
                NSURLRequest *request =[NSURLRequest requestWithURL:URL];
                firstWebView.scrollView.bounces = NO;
                [firstWebView loadRequest:request];
                [view addSubview:firstWebView];
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(firstWebView.frame) + 1, self.view.frame.size.width, 1)];
                lineView.backgroundColor = [UIColor grayColor];
                lineView.alpha = 0.3;
                [view addSubview:lineView];
                
                UIWebView *secondWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame) + 1, self.view.frame.size.width, self.view.frame.size.height / 2)];
                NSString *url2 = [object objectForKey:@"A_url"];
                // 解决URL带有中文
                url2 = [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *URL2 = [NSURL URLWithString:url2];
                NSURLRequest *request2 =[NSURLRequest requestWithURL:URL2];
                secondWebView.scrollView.bounces = NO;
                [secondWebView loadRequest:request2];
                [view addSubview: secondWebView];
                
                UIView *secondLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(secondWebView.frame) + 10, secondWebView.frame.size.width, 30)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                [view addSubview:secondLineView];
                UILabel *secondLineViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
                secondLineViewLabel.text = @"不会做？看这里！";
                secondLineViewLabel.font = [UIFont systemFontOfSize:14];
                secondLineViewLabel.textColor = [UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0];
                [secondLineView addSubview:secondLineViewLabel];
                //                //关联对象表
                BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
                // 每一行view的个数
                int cloumns = 5;
                CGFloat viewWidth = self.view.frame.size.width;
                // 高度
                CGFloat appW = 55;          // 每一个view的大小假定固定不变
                // 宽度
                CGFloat appH = 55;
                // 计算每一行中的每一个view之间的距离
                CGFloat maginX = (viewWidth - cloumns * appW + 60) / (cloumns + 1);
                // 计算每一列中的每一个view之前的距离
                CGFloat maginY = 10;
                CGFloat maginTop = CGRectGetMaxY(secondLineView.frame);;
                
                NSMutableArray *userArr = [[NSMutableArray alloc] init];
                //需要查询的列
                BmobObject *post = [BmobObject objectWithoutDataWithClassName:@"Questions" objectId:[object objectForKey:@"objectId"]];
                [bquery whereObjectKey:@"Users" relatedTo:post];
                [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
                 {
                     if (error)
                     {
                         NSLog(@"%@",error);
                     } else
                     {
                         for (BmobObject *user in array)
                         {
                             [userArr addObject:user];
                         }
                         for (int j = 0; j < userArr.count; j++)
                         {
                             int colIdx = j % cloumns;           // 行索引
                             int rowIdx = j / cloumns;           // 列索引
                             CGFloat appX = maginX + colIdx * (maginX + appW);
                             CGFloat appY = maginTop + rowIdx * (maginY + appH);
                             UIButton *userImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(appX, appY, appW, appH)];
                             BmobFile *file = (BmobFile*)[userArr[j] objectForKey:@"user_pic"];
                             NSURL *url = [NSURL URLWithString:file.url];
                             NSData *data = [NSData dataWithContentsOfURL:url];
                             [userImgBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                             [userImgBtn addTarget:self action:@selector(userImgBtnClickMethon:) forControlEvents:UIControlEventTouchUpInside];
                             userImgBtn.tintColor = [UIColor clearColor];
                             [userImgBtn setTitle:[userArr[j] objectForKey:@"objectId"] forState:UIControlStateNormal];
                             [userImgBtn setTitle:[userArr[j] objectForKey:@"username"] forState:UIControlStateHighlighted];
                             userImgBtn.imageView.layer.cornerRadius = userImgBtn.frame.size.width / 2;
                             [view addSubview:userImgBtn];
                             lastY = CGRectGetMaxY(userImgBtn.frame);
                             view.contentSize = CGSizeMake(0, lastY + 80);
                         }
                     }
                 }];
            }
        }
    }];
}

// 答疑同学头像点击事件
- (void)userImgBtnClickMethon:(UIButton *)button
{
    self.hidesBottomBarWhenPushed = YES;
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    chat.conversationType = ConversationType_PRIVATE;
    chat.targetId = [button titleForState:UIControlStateNormal];
    chat.enableUnreadMessageIcon = YES;
    chat.enableSaveNewPhotoToLocalSystem = YES;
    chat.enableNewComingMessageIcon = YES;
    chat.title = [button titleForState:UIControlStateHighlighted];
    
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
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

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
