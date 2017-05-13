//
//  PJHomePageViewController.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageViewController.h"
#import "PJHomePageTableView.h"
#import "NewsViewController.h"
#import "PJClassHomePage.h"
#import "PJClassViewController.h"

@interface PJHomePageViewController () <PJHomePageTableViewDelegate, PJClassHomePageDelegate>

@end

@implementation PJHomePageViewController
{
    PJHomePageTableView *_kTableView;
    NSMutableArray *_dataArr;
    
    UIButton *_kCover;
    PJClassHomePage *_kPaper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    _dataArr = [@[] mutableCopy];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:mainDeepSkyBlue];
    [self.leftBarButton setImage:nil forState:UIControlStateNormal];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 44)];
    UIImageView *beixingImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 20)];
    UIImageView *beixingjiaiImg = [[UIImageView alloc] initWithFrame:CGRectMake(75, 10, 10, 10)];
    beixingImg.image = [UIImage imageNamed:@"video_title_beixing"];
    beixingjiaiImg.image = [UIImage imageNamed:@"video_title_beixingjia"];
    [titleView addSubview:beixingImg];
    [titleView addSubview:beixingjiaiImg];
    self.navigationItem.titleView = titleView;

    _kTableView = [[PJHomePageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _kTableView.tableDelegate = self;
    [self.view addSubview:_kTableView];
    
    [self getDataFromBmob];
}

- (void)getDataFromBmob {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"News"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
     {
         for (BmobObject *obj in array)
         {
             [_dataArr addObject:obj];
         }
         _kTableView.newsDataArr = _dataArr;
     }];
}

- (void)PJHomePageTableViewNewsCellClick:(BmobObject *)data {
    NewsViewController *vc = [NewsViewController new];
    vc.data = data;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)PJHomePageTableViewCourseCellClick:(NSDictionary *)dict {
    _kPaper = [[NSBundle mainBundle] loadNibNamed:@"PJClassHomePageView" owner:self options:nil].firstObject;
    _kPaper.frame = CGRectMake(20, 80, self.tabBarController.view.frame.size.width - 40, self.tabBarController.view.frame.size.height - 160);
    _kPaper.dataSource = dict;
    _kPaper.viewDelegate = self;
    [self.tabBarController.view addSubview:_kPaper];
    
    // 创建蒙板按钮
    UIButton *btnCover = [[UIButton alloc]init];
    // 设置蒙板按钮的大小
    btnCover.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height);
    // 设置蒙板按钮的颜色
    btnCover.backgroundColor = [UIColor blackColor];
    // 设置蒙板按钮的透明度，开始先设置为0，使用动画进行变化
    btnCover.alpha = 0.0;
    [self.tabBarController.view addSubview:btnCover];
    _kCover = btnCover;
    [btnCover addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.3 animations:^{
        btnCover.alpha = 0.6;
        _kPaper.alpha = 1.0;
    }];
    [self.tabBarController.view bringSubviewToFront:_kPaper];
}

- (void)removeAll
{
    // 设置动画
    [UIView animateWithDuration:0.3 animations:^{
        _kCover.alpha = 0.0;
        _kPaper.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_kPaper removeFromSuperview];
        [_kCover removeFromSuperview];
    }];
}

- (void)PJClassHomePagePushQuestionBtnClick {
    [_kPaper removeFromSuperview];
    [_kCover removeFromSuperview];
    PJClassViewController *vc = [PJClassViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
