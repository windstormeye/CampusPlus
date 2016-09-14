//
//  HomePageViewController.m
//  北信+
//
//  Created by #incloud on 16/9/13.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "HomePageViewController.h"
#import "SDCycleScrollView.h"


@interface HomePageViewController () <SDCycleScrollViewDelegate>


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHomePage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initHomePage
{
    CGSize ww = self.view.bounds.size;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    //当bounces属性设置为YES时，当UIScrollView中图片滑动到边界的时候会出现弹动的效果，就像是Linux中的果冻效果一样。当bounces属性设置为NO时，当UIScrollView中图片滑动到边界时会直接定在边界就不会有弹动的效果。
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    // 设置ScrollView的滚动区域
    scrollView.contentSize = CGSizeMake(ww.width, 800); // -----------------改
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0]];
    //设置navigationbar为不透明
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
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
    UIImageView *userImgView= [[UIImageView alloc] init];
    userImgView.frame = CGRectMake(16, 22, 40, 40);
    userImgView.image = [UIImage imageNamed:@"user_name"];
    userImgView.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:userImgView];
    // 设置用户头像为圆形
    userImgView.layer.cornerRadius = userImgView.frame.size.width / 2;
    userImgView.clipsToBounds = YES;
    userImgView.layer.borderWidth = 1.0f;
    userImgView.layer.borderColor = [UIColor blackColor].CGColor;
    // 设置用户头像Button
    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(0, 0, 40, 40);
    userButton.backgroundColor = [UIColor clearColor];
    [userButton addTarget:self action:@selector(userMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:userButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    // 设置图片轮播器
    NSArray *imagesURLStrings = @[@"http://nos.netease.com/edu-image/C5C39772ECC196D005F6EEACF98D4C9D.jpg?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/64E75B1A8458347BA49D4A77BDEA130C.jpg?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/BFABA934ABB3A4030DF95E87DEE4F167.jpg?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/EA12D3DC06397D7FAE882FA7521C33DA.png?imageView&thumbnail=1205y490&quality=100",
        @"http://nos.netease.com/edu-image/05E35FD224C59CBE03120BFC0F8C1FA9.jpg?imageView&thumbnail=1205y490&quality=100"];// 本地图片请填写全名
    CGFloat w = self.view.bounds.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
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
    myclassLabel.font = [UIFont systemFontOfSize:11];
    [myClassView addSubview:myclassLabel];
    [scrollView addSubview:myClassView];
    // 设置我的课程
    UIView *classesView1 = [[UIView alloc] initWithFrame:CGRectMake(27, 175, 70, 70)];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView1.image = [UIImage imageNamed:@"1"];
    [classesView1 addSubview:imgView1];
    UILabel *className1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className1.text = [NSString stringWithFormat:@"离散数学"];
    className1.font = [UIFont systemFontOfSize:11];
    className1.textColor = [UIColor blackColor];
    [classesView1 addSubview:className1];
    [scrollView addSubview:classesView1];
    
    UIView *classesView2 = [[UIView alloc] initWithFrame:CGRectMake(27 + 70 + 27, 175, 70, 70)];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView2.image = [UIImage imageNamed:@"2"];
    [classesView2 addSubview:imgView2];
    UILabel *className2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className2.text = [NSString stringWithFormat:@"C语言"];
    className2.font = [UIFont systemFontOfSize:11];
    className2.textColor = [UIColor blackColor];
    [classesView2 addSubview:className2];
    [scrollView addSubview:classesView2];
    
    UIView *classesView3 = [[UIView alloc] initWithFrame:CGRectMake(27 * 3 + 70 * 2, 175, 70, 70)];
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView3.image = [UIImage imageNamed:@"3"];
    [classesView3 addSubview:imgView3];
    UILabel *className3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className3.text = [NSString stringWithFormat:@"电工"];
    className3.font = [UIFont systemFontOfSize:11];
    className3.textColor = [UIColor blackColor];
    [classesView3 addSubview:className3];
    [scrollView addSubview:classesView3];
    
    UIView *classesView4 = [[UIView alloc] initWithFrame:CGRectMake(27, 175 + 70 + 20, 70, 70)];
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView4.image = [UIImage imageNamed:@"4"];
    [classesView4 addSubview:imgView4];
    UILabel *className4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className4.text = [NSString stringWithFormat:@"高等数学"];
    className4.font = [UIFont systemFontOfSize:11];
    className4.textColor = [UIColor blackColor];
    [classesView4 addSubview:className4];
    [scrollView addSubview:classesView4];
    
    UIView *classesView5 = [[UIView alloc] initWithFrame:CGRectMake(27 + 70 + 27, 175 + 70 + 20, 70, 70)];
    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView5.image = [UIImage imageNamed:@"5"];
    [classesView5 addSubview:imgView5];
    UILabel *className5 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className5.text = [NSString stringWithFormat:@"大学物理"];
    className5.font = [UIFont systemFontOfSize:11];
    className5.textColor = [UIColor blackColor];
    [classesView5 addSubview:className5];
    [scrollView addSubview:classesView5];
}

- (void)userMessage
{
    NSLog(@"111");
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)classBtnClick:(id)sender {
}
@end
