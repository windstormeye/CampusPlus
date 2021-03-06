//
//  MyAllWrongBookDetailTableViewController.m
//  北信+
//
//  Created by #incloud on 16/11/5.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "MyAllWrongBookDetailTableViewController.h"
#import "MyAllWrongBookViewController.h"
#import "MJRefresh.h"

@interface MyAllWrongBookDetailTableViewController () <UIWebViewDelegate>

@property (nonatomic, retain) NSMutableArray *collectQuestionsArr;
@property (nonatomic, retain) NSMutableArray *webViewY;

@end

@implementation MyAllWrongBookDetailTableViewController
{
    UIView *_view;
    UITableView *_tableView;
}

- (NSMutableArray *)webViewY
{
    if (!_webViewY)
    {
        _webViewY = [[NSMutableArray alloc] init];
    }
    return _webViewY;
}

- (NSMutableArray *)collectQuestionsArr
{
    if (!_collectQuestionsArr)
    {
        _collectQuestionsArr = [[NSMutableArray alloc] init];
    }
    return _collectQuestionsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    self.titleLabel.text = @"错题本";
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

- (void)loadNewData
{
    //关联对象表
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Questions"];
    
    //需要查询的列
    BmobObject *post = [BmobObject objectWithoutDataWithClassName:@"_User" objectId:[[BmobUser currentUser] valueForKey:@"objectId"]];
    [bquery whereObjectKey:@"wrong_questions" relatedTo:post];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            for (BmobObject *user in array)
            {
                [tempArr addObject:user];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0; i < tempArr.count/2; i++)
            {
                [tempArr  exchangeObjectAtIndex:i withObjectAtIndex:tempArr.count-1-i];
            }
            self.collectQuestionsArr = tempArr;
            [_tableView reloadData];
            // 放到这进行下拉刷新的停止
            [_tableView.mj_header endRefreshing];
        });
    }];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.collectQuestionsArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
    UIWebView *secondWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, (cell.frame.size.height - 60 ) / 2, cell.frame.size.width, 100)];
    NSString *url = [self.collectQuestionsArr[indexPath.row] objectForKey:@"Q_url"];
    // 解决URL带有中文
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:URL];
    secondWebView.delegate = self;
    secondWebView.scrollView.bounces = NO;
    [secondWebView loadRequest:request];
    [cell addSubview: secondWebView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, -secondWebView.frame.origin.y, secondWebView.frame.size.width, secondWebView.frame.size.height)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:[self.collectQuestionsArr[indexPath.row] objectForKey:@"objectId"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(anction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:btn];
    [cell bringSubviewToFront:btn];
    
    return cell;
}

- (void)anction:(UIButton *)button
{
    self.hidesBottomBarWhenPushed = YES;
    MyAllWrongBookViewController *de = [[MyAllWrongBookViewController alloc] init];
    de.paperId = [button titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:de animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom=0.8"];
}


@end
