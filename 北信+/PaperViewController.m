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

#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"

#define SCREEN_WIDTH_RATIO (SCREEN.width / 320)  //屏宽比例
#define SCREEN [UIScreen mainScreen].bounds.size
@interface PaperViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) NSDictionary *paperDict;
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UILabel *nowLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  MZTimerLabel *tLabel;
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, retain) NSMutableArray *xArray;   // 记录下生成的webView坐标
@property (nonatomic, assign) CGFloat lastX;
@property (assign, nonatomic) bool isTouchCheckBtn;


@end

@implementation PaperViewController

-(NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}

- (NSMutableArray *)xArray
{
    if (!_xArray)
    {
        _xArray = [[NSMutableArray alloc] init];
    }
    return _xArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isTouchCheckBtn = NO;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, self.navigationController.navigationBar.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    // 设置navigationBar标签
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, self.navigationController.navigationBar.frame.size.height - 25, self.navigationController.navigationBar.frame.size.height - 20)];
    [btn1 addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(btn1.frame.origin.x, btn1.frame.origin.y, btn1.frame.size.width, btn1.frame.size.height)];
    imgView1.image = [UIImage imageNamed:@"exam_collect"];
    [view addSubview:imgView1];
    // 设置navigationBar答题卡
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 30, btn1.frame.origin.y, btn1.frame.size.width + 8, btn1.frame.size.height)];
    [view addSubview:btn2];
    [btn2 addTarget:self action:@selector(answerViewClick) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(btn2.frame.origin.x, btn2.frame.origin.y, btn2.frame.size.width, btn2.frame.size.height)];
    imgView2.image = [UIImage imageNamed:@"exam_paper"];
    [view addSubview:imgView2];
    // 设置navigationBar纠错
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame) + 30, btn2.frame.origin.y, btn2.frame.size.width, btn2.frame.size.height)];
    [view addSubview:btn3];
    UIImageView *imgView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exam_error"]];
    imgView3.frame = CGRectMake(btn3.frame.origin.x, btn3.frame.origin.y, btn3.frame.size.width, btn3.frame.size.height);
    [view addSubview:imgView3];
    // 设置navigationBar计时器
    MZTimerLabel *timeLabel = [[MZTimerLabel alloc] initWithFrame:CGRectMake(10, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    timeLabel.timeLabel.textColor = [UIColor whiteColor];
    timeLabel.timeLabel.font = [UIFont systemFontOfSize:20.0f];
    self.timeLabel = timeLabel;
    [view addSubview:self.timeLabel];
    [timeLabel start];
    
    [self.navigationItem setTitleView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSString *paperHttpUrl = @"http://cloud.bmob.cn/17f5e4c17ad52f4a/Get_Exams";
    [self requestPaper:paperHttpUrl];
    // 让第一个出现的题目View的标签是非题目
    self.nowLabel.text = [NSString stringWithFormat:@"非题目"];
    self.nowLabel.textColor = [UIColor grayColor];
    self.nowLabel.font = [UIFont systemFontOfSize:18];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.topView removeFromSuperview];
}

- (void)initPaperViewWithDict:(NSDictionary *)dict
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, view.frame.size.height - 1)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lab.frame.size.height, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [view addSubview:lineView];
    lab.text = @"高数简答题";
    lab.font = [UIFont systemFontOfSize:15];
    [view addSubview:lab];
    self.topView = view;
    
    [self.navigationController.view addSubview:view];
    
    NSArray *arr = dict[@"Questions"];
    // 设置整个试卷题目scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = scrollView;
    
    CGFloat maxX = self.scrollView.frame.size.width * arr.count;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    CGFloat imgW = self.view.frame.size.width;
    CGFloat imgH = self.view.frame.size.height;
    CGFloat imgY = 0;
    CGFloat imgX = 0;
    int webJ = 0;
    int i;
    for (i = 1; i < arr.count; i ++)
    {
        imgX = (i - 1) * imgW;
        NSMutableString *str = dict[@"Questions"][0];
        // 区分大题目
        if ([self IsChinese:arr[i]])
        {
            // 进行标题切词
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
        }
        else
        {
            NSString *strURL = [[NSString alloc] init];
            NSString *strTMP = dict[@"Questions"][i];
            strURL = [str stringByAppendingString:strTMP];
            strURL = [strURL stringByAppendingString:@".html"];
            NSURL *url = [NSURL URLWithString:strURL];
            // 获取每个webView的X坐标
            NSNumber *x = [NSNumber numberWithFloat:imgX];
            [self.xArray addObject:x];
            UIWebView *firstwebView = [[UIWebView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, 80)];
            NSURLRequest *request =[NSURLRequest requestWithURL:url];
            firstwebView.scrollView.bounces = NO;
            [self.view addSubview: firstwebView];
            [firstwebView loadRequest:request];
            [scrollView addSubview:firstwebView];
            
            if (self.isTouchCheckBtn)
            {
                // 动态计算webView高度
                CGRect frame = firstwebView.frame;
                frame.size.height = 1;
                firstwebView.frame = frame;
                frame = firstwebView.frame;
                frame.size = [firstwebView sizeThatFits:CGSizeZero];
                firstwebView.frame = frame;
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, firstwebView.frame.size.height, 40, 40)];
                btn.backgroundColor = [UIColor blackColor];
                [firstwebView addSubview:btn];
            }

            webJ++;
        }
    }
    UIScrollView *answerView = [[UIScrollView alloc] initWithFrame:CGRectMake(imgW * (i - 1), imgY, imgW, imgH)];
    answerView.bounces = NO;
  
    // 记录下答题卡的坐标
    self.lastX = answerView.frame.origin.x;
    
    self.scrollView.contentSize = CGSizeMake(maxX, 0);
    
    // 每一行view的个0数0
    int cloumns = 6;
    CGFloat viewWidth = self.view.frame.size.width;
    // 高度
    CGFloat appW = 50;          // 每一个view的大小假定固定不变
    // 宽度
    CGFloat appH = 50;
    // 计算每一行中的每一个view之间的距离
    CGFloat maginX = (viewWidth - cloumns * appW + 60) / (cloumns + 1);

    CGFloat appX = 0;
    CGFloat appY = 0;
    // 设置第一个题目类型标签，以此为基点
    UILabel *firstChineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, 20)];
    firstChineseLabel.backgroundColor = [UIColor clearColor];
    firstChineseLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0];
    firstChineseLabel.font = [UIFont systemFontOfSize:14];
    firstChineseLabel.text = self.titleArray[0];
    [answerView addSubview:firstChineseLabel];
    
    CGFloat labY = 5;
    int titleK = 0;
    int btnK = 0;
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel = firstChineseLabel;
    for (int i = 2; i < [self.paperDict[@"Questions"] count]; i++)
    {
        
        if ([self IsChinese:self.paperDict[@"Questions"][i]])
        {
            titleK++;
            labY = appY + appH + 5;
            UILabel *chineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(firstChineseLabel.frame.origin.x, labY, firstChineseLabel.frame.size.width, firstChineseLabel.frame.size.height)];
            chineseLabel.text = self.titleArray[titleK];
            chineseLabel.font = [UIFont systemFontOfSize:14];
            chineseLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0];
            tempLabel = chineseLabel;
            [answerView addSubview:chineseLabel];
        }
        else
        {
            int p = 0;
            // 防止出现下标为18时，btn移位
            if (i == 18)
            {
                p = 20;
            }
            else
                p=i;
            int colIdx = (p - 2) % cloumns;           // 行索引
            appX = maginX + colIdx * (maginX + appW);
            appY = CGRectGetMaxY(tempLabel.frame) + 5;
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(appX, appY, appW, appH);
            btn.tag = btnK++;
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(answerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            // 设置按钮为圆形
            btn.layer.cornerRadius = btn.frame.size.width / 2;
            btn.clipsToBounds = YES;
            btn.layer.borderWidth = 1.0f;
            btn.layer.borderColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0].CGColor;
            // 题目标签
            UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 40, 30)];
            numLabel.text = self.paperDict[@"Questions"][i];
            numLabel.font = [UIFont systemFontOfSize:16];
            numLabel.textAlignment = NSTextAlignmentCenter;
            numLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0];
            numLabel.backgroundColor = [UIColor clearColor];
            [btn addSubview:numLabel];
            
            [answerView addSubview:btn];
        }
    }
      UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, appY + appH + 10, self.view.frame.size.width, 60)];
    checkBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0];
    [checkBtn addTarget:self action:@selector(checkBtnMethon) forControlEvents:UIControlEventTouchUpInside];
    UILabel *checkBtnLabel = [[UILabel alloc] init];
    checkBtnLabel.font = [UIFont systemFontOfSize:18];
    checkBtnLabel.frame = CGRectMake(80, 13, 200, 40);
//    checkBtnLabel.center = checkBtn.center;
    checkBtnLabel.text = @"查看答案并自我批改";
    checkBtnLabel.textColor = [UIColor whiteColor];
    
    [checkBtn addSubview:checkBtnLabel];
    [answerView addSubview:checkBtn];
    
    answerView.contentSize = CGSizeMake(0, appY + appH + checkBtn.frame.size.height+ 50);
    [scrollView addSubview:answerView];
    [self.view addSubview:scrollView];
    
    UILabel *numSumlab = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 30, view.frame.size.height)];
    numSumlab.text = [NSString stringWithFormat:@"/ %d",webJ];
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

- (void)checkBtnMethon
{
    self.isTouchCheckBtn = !self.isTouchCheckBtn;
    [self initPaperViewWithDict:self.paperDict];
}

// 同步请求
-(void)requestPaper: (NSString*)httpUrl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:httpUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        self.paperDict = dic;
        [self initPaperViewWithDict:self.paperDict];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
        
    }];
}

// 当前题目设置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    // 当滑过一半的时候就跳到下一页
    offSetX = offSetX + (self.scrollView.frame.size.width / 2);
    int page = offSetX / self.scrollView.frame.size.width;

    //防止直接调用字典的时候出错，特殊点
    if (page == 0)
        page = 1;
    else if (page == 1)
        page = 2;
    else if (page == [self.paperDict[@"Questions"] count] - 1)
        page = 1;
    else
        page += 1;
    
    NSString *str = self.paperDict[@"Questions"][page];
    if ([self isPureFloat:str])
    {
        self.nowLabel.text = [NSString stringWithFormat:@"%@",self.paperDict[@"Questions"][page]];
        self.nowLabel.textColor = [UIColor colorWithRed:26/255.0 green:167/255.0 blue:242/255.0 alpha:1.0];
        self.nowLabel.font = [UIFont systemFontOfSize: 20];
    }
    else
    {
        self.nowLabel.text = [NSString stringWithFormat:@"非题目"];
        self.nowLabel.textColor = [UIColor grayColor];
        self.nowLabel.font = [UIFont systemFontOfSize:18];
    }
}
// 收藏按钮点击事件
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
// 答题卡题目按钮点击事件
- (void)answerBtnClick:(UIButton *)sender
{
    [self.scrollView setContentOffset:CGPointMake([self.xArray[sender.tag] floatValue], 0) animated:YES];
}
// navigationBar答题卡点击事件
- (void)answerViewClick
{
    [self.scrollView setContentOffset:CGPointMake(_lastX, 0) animated:YES];
}

#pragma mark 正则表达式
-(BOOL)MatchLetter:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[0-9]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}

// 判断是否以小数开头
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

// 判断是否以整数开头
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
//判断是否是中文字符串
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
@end
