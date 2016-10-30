//
//  HomePageViewController.m
//  北信+
//
//  Created by #incloud on 16/9/13.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "HomePageViewController.h"
#import "NewsViewController.h"
#import "SDCycleScrollView.h"
#import "NewsViewController.h"
#import "PaperDetailsView.h"
#import "MyClasses.h"
#import "NewsView.h"
#import "News.h"
#import "LLSlideMenu.h"
#import "MyAllCollectViewController.h"
#import "MyAllExpertsAnswerViewController.h"
#import "MyAllWrongBookViewController.h"
#import "MyDelegatesViewController.h"
#import "AboutUsViewController.h"
#import "MBProgressHUD+NJ.h"

#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"

#import <BmobSDK/Bmob.h>

@interface HomePageViewController () <SDCycleScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property (weak, nonatomic) UIButton *cover;
@property(nonatomic, weak) PaperDetailsView *paper;
@property (nonatomic, retain) NSDictionary *newsDict;
@property (nonatomic, strong) LLSlideMenu *slideMenu;
// 全屏侧滑手势
@property (nonatomic, strong) UIPanGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;
@property (nonatomic, retain) NSMutableArray *bomeObjArr;

@end

@implementation HomePageViewController

-(NSMutableArray *)bomeObjArr
{
    if (!_bomeObjArr)
    {
        _bomeObjArr = [[NSMutableArray alloc] init];
    }
    return _bomeObjArr;
}

-(NSDictionary *)newsDict
{
    if (!_newsDict)
    {
        _newsDict = [[NSDictionary alloc] init];
    }
    return _newsDict;
}
// -(void)viewWillAppear:(BOOL)animated 此方法小心
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
 
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"News"];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
     {
         for (BmobObject *obj in array)
         {
             [self.bomeObjArr addObject:obj];
         }
         [self initHomePageWithDict];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initHomePageWithDict
{
    CGSize ww = self.view.bounds.size;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    //当bounces属性设置为YES时，当UIScrollView中图片滑动到边界的时候会出现弹动的效果，就像是Linux中的果冻效果一样。当bounces属性设置为NO时，当UIScrollView中图片滑动到边界时会直接定在边界就不会有弹动的效果。
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0]];
    //设置navigationbar为不透明
    [self.navigationController.navigationBar setTranslucent:NO];
    // 设置titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 44)];
    UIImageView *beixingImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 20)];
    UIImageView *beixingjiaiImg = [[UIImageView alloc] initWithFrame:CGRectMake(75, 10, 10, 10)];
    beixingImg.image = [UIImage imageNamed:@"video_title_beixing"];
    beixingjiaiImg.image = [UIImage imageNamed:@"video_title_beixingjia"];
    [titleView addSubview:beixingImg];
    [titleView addSubview:beixingjiaiImg];
    self.navigationItem.titleView = titleView;
    // 设置头像View
    UIImageView *userImgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 25, 30)];
    userImgView.image = [UIImage imageNamed:@"汉堡线"];
    // 设置用户头像Button
    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(0, 0, 40, 40);
    // 把用户头像View添加到button上
    [userButton addSubview:userImgView];
    [userButton addTarget:self action:@selector(openLLSlideMenuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:userButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    // 设置图片轮播器
    NSArray *imagesURLStrings = @[@"http://nos.netease.com/edu-image/C5C39772ECC196D005F6EEACF98D4C9D.jpg?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/64E75B1A8458347BA49D4A77BDEA130C.jpg?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/BFABA934ABB3A4030DF95E87DEE4F167.jpg?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/EA12D3DC06397D7FAE882FA7521C33DA.png?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/05E35FD224C59CBE03120BFC0F8C1FA9.jpg?imageView&thumbnail=1205y490&quality=100"];// 本地图片请填写全名
    CGFloat w = self.view.bounds.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 140) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    // 自定义分页控件小圆标颜色
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    // 设置轮播器图片
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    // 自定义轮播时间间隔
    cycleScrollView.autoScrollTimeInterval = 3.5;
    // 设置分页控制器
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [scrollView addSubview:cycleScrollView];
    // 设置我的课程栏
    UIView *myClassView=[[UIView alloc] initWithFrame:CGRectMake(0, cycleScrollView.frame.size.height, w, 40)];
    myClassView.backgroundColor = [UIColor clearColor];
    UIImageView *myclassImg = [[UIImageView alloc] initWithFrame:CGRectMake(13, 10, 35, myClassView.frame.size.height - 10)];
    myclassImg.image = [UIImage imageNamed:@"blackboard"];
    [myClassView addSubview:myclassImg];
    // 设置我的课程标签
    UILabel *myclassLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 50, 20)];
    myclassLabel.text = [NSString stringWithFormat:@"我的课程"];
    myclassLabel.textColor = [UIColor blackColor];
    myclassLabel.font = [UIFont systemFontOfSize:12];
    [myClassView addSubview:myclassLabel];
    [scrollView addSubview:myClassView];
    // 设置我的课程
    UIView *classesView1 = [[UIView alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(myClassView.frame), 70, 70)];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView1.image = [UIImage imageNamed:@"1"];
    [classesView1 addSubview:imgView1];
    UILabel *className1 = [[UILabel alloc] initWithFrame:CGRectMake(8, 50, 70, 20)];
    className1.text = [NSString stringWithFormat:@"离散数学"];
    className1.font = [UIFont systemFontOfSize:13];
    className1.textColor = [UIColor blackColor];
    [classesView1 addSubview:className1];
    UIButton *classBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView1.frame.size.width, classesView1.frame.size.height)];
    classBtn1.backgroundColor = [UIColor redColor];
    [classBtn1 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn1.backgroundColor = [UIColor clearColor];
    [classesView1 addSubview:classBtn1];
    [scrollView addSubview:classesView1];
    
    UIView *classesView2 = [[UIView alloc] initWithFrame:CGRectMake(27 + 70 + 27, CGRectGetMaxY(myClassView.frame), 70, 70)];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView2.image = [UIImage imageNamed:@"2"];
    [classesView2 addSubview:imgView2];
    UILabel *className2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className2.text = [NSString stringWithFormat:@"C语言"];
    className2.font = [UIFont systemFontOfSize:13];
    className2.textColor = [UIColor blackColor];
    [classesView2 addSubview:className2];
    UIButton *classBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView2.frame.size.width, classesView2.frame.size.height)];
    classBtn2.backgroundColor = [UIColor redColor];
    [classBtn2 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn2.backgroundColor = [UIColor clearColor];
    [classesView2 addSubview:classBtn2];
    [scrollView addSubview:classesView2];
    
    UIView *classesView3 = [[UIView alloc] initWithFrame:CGRectMake(27 * 3 + 70 * 2, CGRectGetMaxY(myClassView.frame), 70, 70)];
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView3.image = [UIImage imageNamed:@"3"];
    [classesView3 addSubview:imgView3];
    UILabel *className3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className3.text = [NSString stringWithFormat:@"电工"];
    className3.font = [UIFont systemFontOfSize:13];
    className3.textColor = [UIColor blackColor];
    [classesView3 addSubview:className3];
    UIButton *classBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView3.frame.size.width, classesView3.frame.size.height)];
    classBtn3.backgroundColor = [UIColor redColor];
    [classBtn3 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn3.backgroundColor = [UIColor clearColor];
    [classesView3 addSubview:classBtn3];
    [scrollView addSubview:classesView3];
    
    UIView *classesView4 = [[UIView alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(myClassView.frame) + 70 + 20, 70, 70)];
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView4.image = [UIImage imageNamed:@"4"];
    [classesView4 addSubview:imgView4];
    UILabel *className4 = [[UILabel alloc] initWithFrame:CGRectMake(8, 50, 70, 20)];
    className4.text = [NSString stringWithFormat:@"高等数学"];
    className4.font = [UIFont systemFontOfSize:13];
    className4.textColor = [UIColor blackColor];
    [classesView4 addSubview:className4];
    // 设置科目点击事件
    UIButton *classBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView4.frame.size.width, classesView4.frame.size.height)];
    classBtn4.backgroundColor = [UIColor redColor];
    [classBtn4 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn4.backgroundColor = [UIColor clearColor];
    [classesView4 addSubview:classBtn4];
    [scrollView addSubview:classesView4];
    
    UIView *classesView5 = [[UIView alloc] initWithFrame:CGRectMake(27 + 70 + 27, CGRectGetMaxY(myClassView.frame) + 70 + 20, 70, 70)];
    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView5.image = [UIImage imageNamed:@"5"];
    [classesView5 addSubview:imgView5];
    UILabel *className5 = [[UILabel alloc] initWithFrame:CGRectMake(8, 50, 70, 20)];
    className5.text = [NSString stringWithFormat:@"大学物理"];
    className5.font = [UIFont systemFontOfSize:13];
    className5.textColor = [UIColor blackColor];
    [classesView5 addSubview:className5];
    UIButton *classBtn5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView5.frame.size.width, classesView5.frame.size.height)];
    classBtn5.backgroundColor = [UIColor redColor];
    [classBtn5 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn5.backgroundColor = [UIColor clearColor];
    [classesView5 addSubview:classBtn5];
    [scrollView addSubview:classesView5];
    
    // 设置校内热点新闻栏
    UIView *newsView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(classesView5.frame), w, 40)];
    myClassView.backgroundColor = [UIColor clearColor];
    UIImageView *newsImg = [[UIImageView alloc] initWithFrame:CGRectMake(13, 10, 35, newsView.frame.size.height - 10)];
    newsImg.image = [UIImage imageNamed:@"crown"];
    [newsView addSubview:newsImg];
    UILabel *newsLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 50, 20)];
    newsLabel.text = [NSString stringWithFormat:@"热点新闻"];
    newsLabel.textColor = [UIColor blackColor];
    newsLabel.font = [UIFont systemFontOfSize:12];
    [newsView addSubview:newsLabel];
    [scrollView addSubview:newsView];
    
    // 每一行view的个数
    int cloumns = 2;
    CGFloat viewWidth = self.view.frame.size.width;
    
    // 高度
    CGFloat appW = 140;          // 每一个view的大小假定固定不变
    // 宽度
    CGFloat appH = 120;
    // 第一行距离顶部的距离
    CGFloat maginTop = CGRectGetMaxY(newsView.frame) + 10;
    // 计算每一行中的每一个view之间的距离
    CGFloat maginX = (viewWidth - cloumns * appW) / (cloumns + 1);
    // 计算每一列中的每一个view之前的距离
    CGFloat maginY = maginX;
    
    int tmp = 0;
    
    for (int i = 0; i < self.bomeObjArr.count; i++)
    {
        NewsView  *newsView = [NewsView newsView];
        int colIdx = i % cloumns;           // 行索引
        int rowIdx = i / cloumns;           // 列索引
        CGFloat appX = maginX + colIdx * (maginX + appW);
        CGFloat appY = maginTop + rowIdx * (maginY + appH);
        newsView.frame = CGRectMake(appX, appY, appW, appH);
        newsView.newsBtn.tag = i;
        [newsView.newsBtn addTarget:self action:@selector(newsViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *s = [self.bomeObjArr[i] objectForKey:@"image_url"];
        NSString *str = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *URL = [NSURL URLWithString:str];
        NSData* data = [NSData dataWithContentsOfURL:URL];
        newsView.newsImgView.image = [UIImage imageWithData:data];
        
        newsView.newsImgView.layer.cornerRadius = 5.0f;
        newsView.newsImgView.clipsToBounds = YES;
        
        newsView.newsLabel.text = [self.bomeObjArr[i] objectForKey:@"title"];
        newsView.newsLabel.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:newsView];
        
        tmp = appY + appH + maginY * 2 + 40;
    }

    // 设置ScrollView的滚动区域
    scrollView.contentSize = CGSizeMake(ww.width, tmp);
    
    // 设置个人中心弹簧页面
    // 初始化
    _slideMenu = [[LLSlideMenu alloc] init];

    [self.tabBarController.view addSubview:_slideMenu];
    // 设置菜单宽度
    _slideMenu.ll_menuWidth = 200.f;
    UIImage *backgroundImage = [UIImage imageNamed:@"usercenterbackground"];
    //将刚刚生成的图片转换为UIColor对象。这样便可以实现平铺了。
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // 设置菜单背景色
    _slideMenu.ll_menuBackgroundColor = backgroundColor;
  
    // 设置弹力和速度，  默认的是20,15,60
    //===================
    // 添加全屏侧滑手势
    //===================
    self.leftSwipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandle:)];
    self.leftSwipe.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_leftSwipe];
    
    // 设置头像View
    UIImageView *userCenterImgView= [[UIImageView alloc] init];
    userCenterImgView.frame = CGRectMake(0, 0, 100, 100);
    userCenterImgView.image = [UIImage imageNamed:@"user_name"];
    userCenterImgView.backgroundColor = [UIColor blackColor];
    // 设置用户头像为圆形
    userCenterImgView.layer.cornerRadius = userCenterImgView.frame.size.width / 2;
    userCenterImgView.clipsToBounds = YES;
    userCenterImgView.layer.borderWidth = 1.0f;
    userCenterImgView.layer.borderColor = [UIColor blackColor].CGColor;
    // 设置用户头像Button
    UIButton *userCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userCenterButton.frame = CGRectMake((_slideMenu.ll_menuWidth - 100 )/ 2, 20, 100, 100);
    // 把用户头像View添加到button上
    [userCenterButton addSubview:userCenterImgView];
    [userCenterButton addTarget:self action:@selector(reviseUserImg) forControlEvents:UIControlEventTouchUpInside];
    [self.slideMenu addSubview:userCenterButton];

    
    UILabel *userCenterNamelab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(userCenterButton.frame) + 20, self.slideMenu.frame.size.width / 4 - 20, 30)];
    userCenterNamelab.text = @"翁培钧";
    userCenterNamelab.textColor = [UIColor colorWithRed:72/255.0 green:82/255.0 blue:94/255.0 alpha:1];
    userCenterNamelab.font = [UIFont systemFontOfSize:18];
    [self.slideMenu addSubview:userCenterNamelab];
    
    UIImageView *attestationImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userCenterNamelab.frame) + 10
, userCenterNamelab.frame.origin.y + 8, 50, 15)];
    attestationImg.image = [UIImage imageNamed:@"authenticated"];
    [self.slideMenu addSubview:attestationImg];
    
    UIImageView *goldImg= [[UIImageView alloc] initWithFrame:CGRectMake(self.slideMenu.frame.size.width / 2 + 5, CGRectGetMaxY(attestationImg.frame), 25, 25)];
    goldImg.image = [UIImage imageNamed:@"mine_gold"];
    [self.slideMenu addSubview:goldImg];
    
    UILabel *goldNumsLab = [[UILabel alloc] initWithFrame:CGRectMake(self.slideMenu.frame.size.width / 3 + 5, CGRectGetMidY(goldImg.frame) - 10, 50, 20)];
    goldNumsLab.text = @"31";
    goldNumsLab.font = [UIFont systemFontOfSize:13];
    goldNumsLab.textAlignment = NSTextAlignmentRight;
    goldNumsLab.textColor = [UIColor whiteColor];
    [self.slideMenu addSubview:goldNumsLab];

    UILabel *schoolNameLab = [[UILabel alloc] initWithFrame:CGRectMake(userCenterNamelab.frame.origin.x, CGRectGetMidY(userCenterNamelab.frame) + 15, 100, 20)];
    schoolNameLab.text = @"北京信息科技大学";
    schoolNameLab.textColor = [UIColor colorWithRed:72/255.0 green:82/255.0 blue:94/255.0 alpha:1];
    schoolNameLab.font = [UIFont systemFontOfSize:12];
    [self.slideMenu addSubview:schoolNameLab];
    
    UILabel *collegeNameAndClassNum = [[UILabel alloc] initWithFrame:CGRectMake(schoolNameLab.frame.origin.x, CGRectGetMaxY(schoolNameLab.frame), schoolNameLab.frame.size.width + 20, schoolNameLab.frame.size.height)];
    collegeNameAndClassNum.text = @"计算机学院 1503班";
    collegeNameAndClassNum.textColor = [UIColor colorWithRed:72/255.0 green:82/255.0 blue:94/255.0 alpha:1];
    collegeNameAndClassNum.font = [UIFont systemFontOfSize:12];
    [self.slideMenu addSubview:collegeNameAndClassNum];
    
    UIView *focusView1 = [[UIView alloc] initWithFrame:CGRectMake(2, CGRectGetMaxY(collegeNameAndClassNum.frame) + 20, self.slideMenu.frame.size.width / 3.5 + 5, 30)];
    focusView1.backgroundColor = [UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:0.4];
    [self.slideMenu addSubview:focusView1];
    UILabel *myAttentionLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.slideMenu.frame.size.width / 3.5, 30)];
    focusView1.layer.cornerRadius = 10;
    myAttentionLab.text = @"我的关注 11";
    myAttentionLab.textColor = [UIColor whiteColor];
    myAttentionLab.textAlignment = NSTextAlignmentCenter;
    myAttentionLab.font = [UIFont systemFontOfSize:14];
    [focusView1 addSubview:myAttentionLab];
    
    UIView *focusView2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(focusView1.frame) + 1, CGRectGetMaxY(collegeNameAndClassNum.frame) + 20, self.slideMenu.frame.size.width / 3.5 + 5, 30)];
    focusView2.backgroundColor = [UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:0.4];
    [self.slideMenu addSubview:focusView2];
    UILabel *myFansLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.slideMenu.frame.size.width / 3.5, 30)];
    focusView2.layer.cornerRadius = 10;
    myFansLab.text = @"我的粉丝 19";
    myFansLab.textColor = [UIColor whiteColor];
    myFansLab.textAlignment = NSTextAlignmentCenter;
    myFansLab.font = [UIFont systemFontOfSize:14];
    [focusView2 addSubview:myFansLab];
    
    CGFloat tempY = 0;
    CGFloat btnW = 200.f;
    CGFloat btnH = 30;
    CGFloat btnY = CGRectGetMaxY(focusView1.frame) + 25;
    CGFloat btnMaginTop = 15;
    for (int i = 0; i < 5; i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        tempY = btnY + i * (btnMaginTop + btnH);
        btn.frame = CGRectMake(15, tempY, btnW - 30, btnH);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        switch (i)
        {
            case 0:
                [btn setTitle:@"我的收藏" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(toMyAllCollect) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"all_of_my_collect"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:39/255.0 green:38/255.0 blue:54/255.0 alpha:1.0] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
                break;
            case 1:
                [btn setTitle:@"我的答疑" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(toMyAllExpertsAnswers) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"all_of_my_answer"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:39/255.0 green:38/255.0 blue:54/255.0 alpha:1.0] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
                break;
            case 2:
                [btn setTitle:@"错题本" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(toMyAllWrongBook) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"all_of_my_wrong"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:39/255.0 green:38/255.0 blue:54/255.0 alpha:1.0] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
                break;
            case 3:
                [btn setTitle:@"我的代理" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(toMyDelegates) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"mydelegate"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:39/255.0 green:38/255.0 blue:54/255.0 alpha:1.0] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
                break;
            case 4:
                [btn setTitle:@"关于我们" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(toAboutUs) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"aboutme"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:39/255.0 green:38/255.0 blue:54/255.0 alpha:1.0] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
                break;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.tintColor = [UIColor blackColor];
        [self.slideMenu addSubview:btn];
    }
    
    UIButton *outLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, tempY + btnH + 30, self.slideMenu.frame.size.width / 2 + 15, 40)];
    outLoginBtn.backgroundColor = [UIColor colorWithRed:205/255.0 green:0 blue:0 alpha:1] ;
    [outLoginBtn setTitle:@"退出" forState:UIControlStateNormal];
    [self.slideMenu addSubview:outLoginBtn];
}

- (void)reviseUserImg
{
    NSLog(@"点我干嘛。。。");
}

- (void)classViewClick
{
    PaperDetailsView *paper = [PaperDetailsView paperView];
    paper.frame = CGRectMake(20, 80, self.tabBarController.view.frame.size.width - 40, self.tabBarController.view.frame.size.height - 160);
    paper.layer.cornerRadius = 13.0f;
    paper.alpha = 0.0;
    paper.clipsToBounds = YES;

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
        paper.alpha = 1.0;
    }];
    
    self.paper = paper;
    [self.tabBarController.view addSubview:paper];
    [self.tabBarController.view   bringSubviewToFront:paper];

}
- (void)removeAll
{
    
    // 设置动画
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0.0;
        self.paper.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.paper removeFromSuperview];
        [self.cover removeFromSuperview];
        self.cover = nil;
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeAll];
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
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:help animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

// 全屏侧滑手势监听
- (void)swipeLeftHandle:(UIScreenEdgePanGestureRecognizer *)recognizer {
    // 如果菜单已打开则禁止滑动
    if (_slideMenu.ll_isOpen) {
        return;
    }
    // 计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.navigationController.view].x / (self.navigationController.view.bounds.size.width * 1.0);
    // 把这个百分比限制在 0~1 之间
    progress = MIN(1.0, MAX(0.0, progress));
    
    // 当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        // 当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percent updateInteractiveTransition:progress];
        _slideMenu.ll_distance = [recognizer translationInView:self.navigationController.view].x;
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        // 当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.4) {
            [self.percent finishInteractiveTransition];
            [_slideMenu ll_openSlideMenu];
        }else{
            [self.percent cancelInteractiveTransition];
            [_slideMenu ll_closeSlideMenu];
        }
        self.percent = nil;
    }
}

// 按钮监听
- (void)openLLSlideMenuAction{
    if (_slideMenu.ll_isOpen) {
        [_slideMenu ll_closeSlideMenu];
    } else {
        [_slideMenu ll_openSlideMenu];
    }
}

- (void)toMyAllCollect
{
    [_slideMenu ll_closeSlideMenu];
    if (_slideMenu.ll_isOpen)
    {
        [_slideMenu ll_closeSlideMenu];
        self.hidesBottomBarWhenPushed=YES;
        MyAllCollectViewController *collect = [[MyAllCollectViewController alloc] init];
        [self.navigationController pushViewController:collect animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }

}

- (void)toMyAllExpertsAnswers
{
    [_slideMenu ll_closeSlideMenu];
    if (_slideMenu.ll_isOpen)
    {
        [_slideMenu ll_closeSlideMenu];
        self.hidesBottomBarWhenPushed=YES;
        MyAllExpertsAnswerViewController *answer = [[MyAllExpertsAnswerViewController alloc] init];
        [self.navigationController pushViewController:answer animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}

- (void)toMyAllWrongBook
{
    
    [_slideMenu ll_closeSlideMenu];
    if (_slideMenu.ll_isOpen)
    {
        [_slideMenu ll_closeSlideMenu];
        self.hidesBottomBarWhenPushed=YES;
        MyAllWrongBookViewController *book = [[MyAllWrongBookViewController alloc] init];
        [self.navigationController pushViewController:book animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}

- (void)toMyDelegates
{
    [_slideMenu ll_closeSlideMenu];
    if (_slideMenu.ll_isOpen)
    {
        [_slideMenu ll_closeSlideMenu];
        self.hidesBottomBarWhenPushed=YES;
        MyDelegatesViewController *dele = [[MyDelegatesViewController alloc] init];
        [self.navigationController pushViewController:dele animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}

- (void)toAboutUs
{
    [_slideMenu ll_closeSlideMenu];
    if (_slideMenu.ll_isOpen)
    {
        [_slideMenu ll_closeSlideMenu];
        self.hidesBottomBarWhenPushed=YES;
        AboutUsViewController *us = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:us animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}
@end
