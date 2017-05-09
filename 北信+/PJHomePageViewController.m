//
//  PJHomePageViewController.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageViewController.h"
#import "PJHomePageTableView.h"


@interface PJHomePageViewController ()

@end

@implementation PJHomePageViewController
{
    PJHomePageTableView *_kTableView;
    NSMutableArray *_dataArr;
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

@end
