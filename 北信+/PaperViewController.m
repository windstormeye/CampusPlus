//
//  PaperViewController.m
//  北信+
//
//  Created by #incloud on 16/9/17.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "PaperViewController.h"
#import "NSString+PJNSStringExtension.h"
#import "MZTimerLabel.h"

#define SCREEN_WIDTH_RATIO (SCREEN.width / 320)  //屏宽比例
#define SCREEN [UIScreen mainScreen].bounds.size

@interface PaperViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) NSDictionary *paperDict;
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UILabel *nowLabel;
@property (nonatomic, retain) NSMutableArray *numArr;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, retain) NSMutableArray *thingsArray;
@property (nonatomic, assign) int number;




@end

@implementation PaperViewController

// 初始化数组要不然拿不到数据
-(NSMutableArray *)numArr
{
    if (!_numArr)
    {
        _numArr = [[NSMutableArray alloc] init];
    }
    return _numArr;
}

-(NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}

-(NSMutableArray *)thingsArray
{
    if (!_thingsArray)
    {
        _thingsArray = [[NSMutableArray alloc] init];
    }
    return _thingsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, self.navigationController.navigationBar.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, self.navigationController.navigationBar.frame.size.height - 25, self.navigationController.navigationBar.frame.size.height - 20)];
    [btn1 addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(btn1.frame.origin.x, btn1.frame.origin.y, btn1.frame.size.width, btn1.frame.size.height)];
    imgView1.image = [UIImage imageNamed:@"exam_collect"];
    [view addSubview:imgView1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 30, btn1.frame.origin.y, btn1.frame.size.width + 8, btn1.frame.size.height)];
    [view addSubview:btn2];
    //------------------------ 未设置点击事件方法 -------------------------
    [btn1 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(btn2.frame.origin.x, btn2.frame.origin.y, btn2.frame.size.width, btn2.frame.size.height)];
    imgView2.image = [UIImage imageNamed:@"exam_paper"];
    [view addSubview:imgView2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame) + 30, btn2.frame.origin.y, btn2.frame.size.width, btn2.frame.size.height)];
    [view addSubview:btn3];
    UIImageView *imgView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exam_error"]];
    imgView3.frame = CGRectMake(btn3.frame.origin.x, btn3.frame.origin.y, btn3.frame.size.width, btn3.frame.size.height);
    [view addSubview:imgView3];
    
    MZTimerLabel *timeLabel = [[MZTimerLabel alloc] initWithFrame:CGRectMake(10, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    timeLabel.timeLabel.textColor = [UIColor whiteColor];
    timeLabel.timeLabel.font = [UIFont systemFontOfSize:20.0f];
    [view addSubview:timeLabel];
    [timeLabel start];
    
    [self.navigationItem setTitleView:view];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.number = 0;

    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
    NSString *paperHttpUrl = @"http://cloud.bmob.cn/17f5e4c17ad52f4a/Get_Exams";
    [self requestPaper:paperHttpUrl];
    [self initPaperViewWithDict:self.paperDict];
    self.nowLabel.text = [NSString stringWithFormat:@"非题目"];
    self.nowLabel.textColor = [UIColor grayColor];
    self.nowLabel.font = [UIFont systemFontOfSize:18];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.topView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initPaperViewWithDict:(NSDictionary *)dict
{
//    self.thingsArray = dict[@"Questions"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, view.frame.size.height - 1)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lab.frame.size.height, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [view addSubview:lineView];
    lab.text = @"高数简答题";
    lab.font = [UIFont systemFontOfSize:12];
    [view addSubview:lab];
    self.topView = view;
    
    [self.navigationController.view addSubview:view];
    
    NSArray *arr = dict[@"Questions"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = scrollView;
    
    CGFloat maxX = self.scrollView.frame.size.width * (arr.count - 1);
    self.scrollView.contentSize = CGSizeMake(maxX, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    CGFloat imgW = self.view.frame.size.width;
    CGFloat imgH = self.view.frame.size.height;
    CGFloat imgY = 0;
    CGFloat imgX = 0;
    int j = 0;
    for (int i = 1; i < arr.count; i ++)
    {
        imgX = (i-1) * imgW;
        NSMutableString *str = dict[@"Questions"][0];
        // 区分大题目
        if ([self IsChinese:arr[i]])
        {
            NSString *titleString = arr[i];
            NSRange range = [titleString rangeOfString:@"|"];
            titleString = [titleString substringToIndex:range.location];
            [self.titleArray addObject:titleString];
            
            UIView *chineseView = [[UIView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            UIFont *font = [UIFont systemFontOfSize:10];
            CGSize textSize = [arr[i] sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:font];
            CGFloat textW = textSize.width + imgW - 200;
            CGFloat textH = textSize.height + 30;
            titleLabel.frame = CGRectMake(5, 20, 100, 30);
            titleLabel.font = [UIFont systemFontOfSize:30];
            titleLabel.textColor = [UIColor colorWithRed:26/255.0 green:167/255.0 blue:242/255.0 alpha:1.0];
            titleLabel.text = titleString;
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame), textW, textH)];
            textLabel.text = [arr[i] substringFromIndex:range.location + 1];
            // 切记加下面这行代码，代表允许自动换行
            textLabel.numberOfLines = 0;
            [chineseView addSubview:textLabel];
            [chineseView addSubview:titleLabel];
            [scrollView addSubview:chineseView];
            
            NSNumber *num = [NSNumber numberWithInteger:i];
            [self.numArr addObject:num];
        }
        else
        {
            NSString *strULR = [[NSString alloc] init];
            NSString *strTMP = dict[@"Questions"][i];
            strULR = [str stringByAppendingString:strTMP];
            strULR = [strULR stringByAppendingString:@".html"];
            NSURL *url = [NSURL URLWithString:strULR];
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
            NSURLRequest *request =[NSURLRequest requestWithURL:url];
            [self.view addSubview: webView];
            [webView loadRequest:request];
            [scrollView addSubview:webView];
            NSNumber *num = [NSNumber numberWithInteger:i];
            [self.thingsArray addObject:num];
            j++;
        }
    }
    UIView *answerView = [[UIView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
    answerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat labX = 10;
    CGFloat labY = 5;
    CGFloat labW = 50;
    CGFloat labH = 30;
    for (int i = 0; i < self.titleArray.count; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY + (i * labH), labW, labH)];
        lab.text = self.titleArray[i];
        lab.font = [UIFont systemFontOfSize:14];
        [answerView addSubview:lab];
    }
    
    [scrollView addSubview:answerView];
    [self.view addSubview:scrollView];
    
    UILabel *numSumlab = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 30, view.frame.size.height)];
    numSumlab.text = [NSString stringWithFormat:@"/ %d",j];
    [view addSubview:numSumlab];
    
    UILabel *now = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 80, view.frame.size.height)];
    self.nowLabel = now;
    now.backgroundColor = [UIColor clearColor];
    now.textAlignment = NSTextAlignmentRight;
    now.textColor = [UIColor colorWithRed:26/255.0 green:167/255.0 blue:242/255.0 alpha:1.0];
    now.font = [UIFont systemFontOfSize: 20];
    [view addSubview:now];
    
    self.scrollView.delegate = self;

   
}

-(void)requestPaper: (NSString*)httpUrl
{

    // 如果网址中存在中文,进行URLEncode
    NSString *newUrlStr = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 2.构建网络URL对象, NSURL
    NSURL *url = [NSURL URLWithString:newUrlStr];
    // 3.创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    // 创建同步链接
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.paperDict = dict;
}

-(BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
                return YES;
    }
    return NO;
}

// 控制题数    ---------------------------------------------------------改，没做好
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    // 当滑过一半的时候就跳到下一页
    offSetX = offSetX + (self.scrollView.frame.size.width / 2);
    int page = offSetX / self.scrollView.frame.size.width;

    NSNumber *num = [NSNumber numberWithInt:page + 1];
//    NSNumber *num2 = [NSNumber numberWithInt:page];
    if ([self.numArr containsObject:num])
    {
        self.nowLabel.text = [NSString stringWithFormat:@"非题目"];
        self.nowLabel.textColor = [UIColor grayColor];
        self.nowLabel.font = [UIFont systemFontOfSize:18];
        self.number++;
    }
    else if ([self.thingsArray containsObject:num])
    {
        self.nowLabel.text = [NSString stringWithFormat:@"%d",page];
        self.nowLabel.textColor = [UIColor colorWithRed:26/255.0 green:167/255.0 blue:242/255.0 alpha:1.0];
        self.nowLabel.font = [UIFont systemFontOfSize: 20];
    }
//    NSLog(@"%@",self.thingsArray);
//    NSLog(@"%@ ---",self.numArr);
//    NSLog(@"%d",self.number);

}

- (void)collect
{
    CGFloat width = SCREEN.width * 0.5 * SCREEN_WIDTH_RATIO;
    CGFloat height = 0.3 * width;
    UIView * tip = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.5 - width / 2, self.view.frame.size.height - (self.view.frame.size.height * 0.45 / 3 * 2), width, height)];
    tip.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    tip.layer.cornerRadius = 8.0f;
    [self.view addSubview:tip];
    UILabel * label = [[UILabel alloc]init];
    label.text = @"收藏成功 (◕ω ◕｀ヽ)";
//    label.tintColor = [UIColor whiteColor];
    //sizetofit的作用，是让label自动适应为跟文字大小等大的label
    label.font = [UIFont systemFontOfSize:12];
    [label sizeToFit];
    label.center = CGPointMake(tip.frame.size.width * 0.5, tip.frame.size.height * 0.5);
    [tip addSubview:label];
    tip.alpha = 0.0;
    [UIView animateWithDuration:0.8 animations:^{
        tip.alpha = 1;
    } completion:^(BOOL finished) {
        [tip removeFromSuperview];
    }];
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
