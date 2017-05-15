//
//  PJDelegateViewController.m
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJFindViewController.h"
#import "PJFindActivityTableView.h"

@interface PJFindViewController ()

@end

@implementation PJFindViewController
{
    PJFindActivityTableView *_kTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    [self initNavigationBar];
    self.titleLabel.text = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.leftBarButton setImage:nil forState:0];
    
    _kTableView = [[PJFindActivityTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:_kTableView];
    
    [self getBannerDataFromBmob];
    [self getCollectionDataFromBmob];
}

- (void)getBannerDataFromBmob {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"LunBo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
     {
         NSMutableArray *dataArr = [@[] mutableCopy];
         for (BmobObject *obj in array)
         {
             NSString *url = [obj objectForKey:@"Image_Url"];
             // 解决URL带有中文
             url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             [dataArr addObject:url];
         }
         _kTableView.bannerArr = dataArr;
     }];
}

- (void)getCollectionDataFromBmob {
    BmobQuery   *ActiviesBquery = [BmobQuery queryWithClassName:@"Activies"];
    [ActiviesBquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
     {
         NSMutableArray *dataArr = [@[] mutableCopy];
         for (BmobObject *obj in array)
         {
             NSString *s = [obj objectForKey:@"Poster_Url"];
             NSString *urlStr = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             NSArray *infoArr = [[NSArray alloc] initWithArray:[obj objectForKey:@"Activity_Info"]];
             NSDictionary *dict = @{@"url":urlStr,
                                    @"info":infoArr};
             [dataArr addObject:dict];
         }
         _kTableView.tableDataArr = dataArr;
     }];
}

@end
