//
//  OnCampusViewController.m
//  北信+
//
//  Created by #incloud on 16/10/17.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "OnCampusViewController.h"
#import "SDCycleScrollView.h"
#include "NewsViewController.h"
#include "HomePageViewController.h"
#import <BmobSDK/Bmob.h>


@interface OnCampusViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *bomeObjArr;
//@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


@end

@implementation OnCampusViewController

-(NSMutableArray *)bomeObjArr
{
    if (!_bomeObjArr)
    {
        _bomeObjArr = [[NSMutableArray alloc] init];
    }
    return _bomeObjArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.cycleScrollView.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"LunBo"];
//    [bquery selectKeys:@[@"Activity_InfoArray",@"Poster_UrlString"]];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
    {
        for (BmobObject *obj in array)
        {
            [self.bomeObjArr addObject:obj];
        }
        [self initView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 5, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *topViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    topViewLabel.text = @"跟着达人一起玩";
    topViewLabel.font = [UIFont systemFontOfSize:14];
    topViewLabel.textColor = [UIColor grayColor];
    [topView addSubview:topViewLabel];
    
    NSMutableArray *imagesURLStrings = [[NSMutableArray alloc] init];
    int i = 0;
    while (i != self.bomeObjArr.count)
    {
        NSString *url = [self.bomeObjArr[i] objectForKey:@"Image_Url"];
        // 解决URL带有中文
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [imagesURLStrings addObject:url];
        i ++;
    }
        
    CGFloat w = self.view.bounds.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5, CGRectGetMaxY(topView.frame), w - 10, 160) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    self.cycleScrollView = cycleScrollView;
    cycleScrollView.delegate = self;
    cycleScrollView.layer.cornerRadius = 10.f;
    // 自定义分页控件小圆标颜色
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    // 设置轮播器图片
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    // 自定义轮播时间间隔
    cycleScrollView.autoScrollTimeInterval = 3.5;
    // 设置分页控制器
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [scrollView addSubview:cycleScrollView];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSString *str = [self.bomeObjArr[index] objectForKey:@"Url"];
    //  把中文URL进行编码
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NewsViewController *help = [[NewsViewController alloc] init];
    [help getNewsMessageWithURL:str];
    [[self getCurrentVC] pushViewController:help animated:YES];
}

//获取当前屏幕显示的NavigationController
- (UINavigationController *)getCurrentVC
{
    UITabBarController* VC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController* vc = (UINavigationController*)VC.childViewControllers[2];
    
    return vc;
}

@end





