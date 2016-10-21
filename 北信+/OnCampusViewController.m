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
#import "NewsView.h"


@interface OnCampusViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *bomeObjArr;
@property (nonatomic, retain) NSMutableArray *ActiviesBomeObjArr;

@property (nonatomic, retain) UIScrollView *scrollView;

@end

@implementation OnCampusViewController
{
    CGFloat topMaxY;
}

-(NSMutableArray *)bomeObjArr
{
    if (!_bomeObjArr)
    {
        _bomeObjArr = [[NSMutableArray alloc] init];
    }
    
   
    return _bomeObjArr;

}

- (NSMutableArray *)ActiviesBomeObjArr
{
    if (!_ActiviesBomeObjArr)
    {
        _ActiviesBomeObjArr = [[NSMutableArray alloc] init];
    }
    return _ActiviesBomeObjArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"LunBo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
     {
         for (BmobObject *obj in array)
         {
             [self.bomeObjArr addObject:obj];
         }
         [self initTopView];
         BmobQuery   *ActiviesBquery = [BmobQuery queryWithClassName:@"Activies"];
         [ActiviesBquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
          {
              for (BmobObject *obj in array)
              {
                  [self.ActiviesBomeObjArr addObject:obj];
              }
              [self initMiddleView];
          }];

     }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTopView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 5, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:topView];
    UILabel *topViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    topViewLabel.text = @"跟着达人一起玩";
    topViewLabel.font = [UIFont systemFontOfSize:14];
    topViewLabel.textColor = [UIColor grayColor];
    [topView addSubview:topViewLabel];
    
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(topViewLabel.frame) + 110, 10, 50, 20)];
    moreBtn.layer.borderWidth = 1;
    moreBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    moreBtn.layer.borderColor =  [[UIColor grayColor] CGColor];
    moreBtn.layer.cornerRadius = moreBtn.frame.size.width / 5;
    UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 20)];
    moreLabel.textColor = [UIColor grayColor];
    moreLabel.text = @"More";
    moreLabel.font = [UIFont systemFontOfSize: 13.0];
    [moreBtn addSubview:moreLabel];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:moreBtn];
    
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
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(cycleScrollView.frame) + 5, self.view.frame.size.width - 5, 40)];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:middleView];
    UILabel *middleViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    middleViewLabel.text = @"同校Go";
    middleViewLabel.font = [UIFont systemFontOfSize:14];
    middleViewLabel.textColor = [UIColor grayColor];
    [middleView addSubview:middleViewLabel];

    topMaxY = CGRectGetMaxY(middleView.frame);
}

- (void)initMiddleView
{
    // 每一行view的个数
    int cloumns = 2;
    CGFloat viewWidth = self.view.frame.size.width;
    
    // 高度
    CGFloat appW = 140;          // 每一个view的大小假定固定不变
    // 宽度
    CGFloat appH = 140;
    // 第一行距离顶部的距离
    CGFloat maginTop = topMaxY;
    // 计算每一行中的每一个view之间的距离
    CGFloat maginX = (viewWidth - cloumns * appW) / (cloumns + 1);
    // 计算每一列中的每一个view之前的距离
    CGFloat maginY = maginX;
    
    int tmp = 0;
    for (int i = 0; i < self.ActiviesBomeObjArr.count; i++)
    {
        NewsView  *newsView = [NewsView newsView];
        int colIdx = i % cloumns;           // 行索引
        int rowIdx = i / cloumns;           // 列索引
        CGFloat appX = maginX + colIdx * (maginX + appW);
        CGFloat appY = maginTop + rowIdx * (maginY + appH);
        newsView.frame = CGRectMake(appX, appY, appW, appH);
        newsView.newsBtn.tag = i;
        [newsView.newsBtn addTarget:self action:@selector(newsViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *s = [self.ActiviesBomeObjArr[i] objectForKey:@"Poster_Url"];
        NSString *str = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *URL = [NSURL URLWithString:str];
        NSData* data = [NSData dataWithContentsOfURL:URL];
        newsView.newsImgView.image = [UIImage imageWithData:data];
        
        newsView.newsImgView.layer.cornerRadius = 5.0f;
        newsView.newsImgView.clipsToBounds = YES;

        NSArray *tempArr = [[NSArray alloc] initWithArray:[self.ActiviesBomeObjArr[i] objectForKey:@"Activity_Info"]];
        
        newsView.newsLabel.text = tempArr[0];
        newsView.newsLabel.font = [UIFont systemFontOfSize:14];
        [self.scrollView addSubview:newsView];
        
        tmp = appY + appH;
    }
    
    // 设置ScrollView的滚动区域
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, tmp);

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

- (void)moreBtnClick
{
    NSLog(@"111");
}

-(void )newsViewBtnClick:(UIButton *)sender
{    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    int i = (int)sender.tag;
    NSString *str = [self.bomeObjArr[i] objectForKey:@"url"];
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





