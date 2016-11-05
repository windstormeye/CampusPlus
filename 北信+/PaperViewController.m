//
//  PaperViewController.m
//  北信+
//
//  Created by #incloud on 16/9/17.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "PaperViewController.h"
#import "AnswerChatListViewController.h"

#import "NSString+PJNSStringExtension.h"
#import "MZTimerLabel.h"

#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"

#import "MBProgressHUD.h"

#import <BmobSDK/Bmob.h>
#import "IQKeyboardManager.h"

#define SCREEN_WIDTH_RATIO (SCREEN.width / 320)  //屏宽比例
#define SCREEN [UIScreen mainScreen].bounds.size
@interface PaperViewController () <UIScrollViewDelegate, UIWebViewDelegate, RCIMUserInfoDataSource, RCIMGroupInfoDataSource>

@property (nonatomic, retain) NSDictionary *paperDict;
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UILabel *nowLabel;
@property (strong, nonatomic)  MZTimerLabel *timeLabel;
@property (strong, nonatomic)  MZTimerLabel *tLabel;
@property (nonatomic, retain) NSString *timeLabelPauseStr;
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, retain) NSMutableArray *xArray;   // 记录下生成的webView坐标
@property (nonatomic, assign) CGFloat lastX;
@property (assign, nonatomic) bool isTouchCheckBtn;
@property (assign, nonatomic) bool isTouchCheckBtnAgain;
@property (strong, nonatomic) UIButton *checkBtn;
@property (strong, nonatomic) UILabel *checkBtnLabel;
@property (strong, nonatomic) UIWebView *firstWebView;
@property (nonatomic, retain) NSMutableArray *webViewY;
@property (nonatomic, retain) NSMutableArray *webViewYY;
@property (nonatomic, retain) NSMutableArray *answerBomeObjArr;
@property (weak, nonatomic) UIButton *cover;
@property (nonatomic, retain) NSMutableArray *answerUsersBomeObjArr;
@property (weak, nonatomic) MBProgressHUD *MB;
@property (weak, nonatomic) UIScrollView *paperScrollView;
@property (weak, nonatomic) UIView *navigationBarView;
@property (nonatomic, retain) NSMutableArray *titleNumArr;



@end

@implementation PaperViewController
{
    int numOfQuestions;
    int trueQuestionsNum;
    float Questions;
    int answerPaperViewNums;
    int currentPaperNum;
    bool isPaper;
}

- (NSMutableArray *)titleNumArr
{
    if ((!_titleNumArr))
    {
        _titleNumArr = [[NSMutableArray alloc] init];
    }
    return _titleNumArr;
}
-(NSMutableArray *)webViewYY
{
    if(!_webViewYY)
    {
        _webViewYY = [[NSMutableArray alloc] init];
    }
    return _webViewYY;
}

-(NSMutableArray *)answerUsersBomeObjArr
{
    if (!_answerUsersBomeObjArr)
    {
        _answerUsersBomeObjArr = [[NSMutableArray alloc] init];
    }
    return _answerUsersBomeObjArr;
}

-(NSMutableArray *)answerBomeObjArr
{
    if (!_answerBomeObjArr)
    {
        _answerBomeObjArr = [[NSMutableArray alloc] init];
    }
    return _answerBomeObjArr;
}

-(NSMutableArray *)webViewY
{
    if(!_webViewY)
    {
        _webViewY = [[NSMutableArray alloc] init];
    }
    return _webViewY;
}

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

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.isTouchCheckBtn = NO;
    self.isTouchCheckBtnAgain = NO;
    isPaper = NO;
    trueQuestionsNum = 0;
    answerPaperViewNums = 0;
    currentPaperNum = 0;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    self.navigationBarView = view;
    view.backgroundColor = [UIColor grayColor];
    view.backgroundColor = [UIColor clearColor];
    // 设置navigationBar标签
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, self.navigationController.navigationBar.frame.size.height - 25, self.navigationController.navigationBar.frame.size.height - 20)];
    [btn1 addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn1.frame.size.width, btn1.frame.size.height)];
    imgView1.image = [UIImage imageNamed:@"exam_collect"];
    [btn1 addSubview:imgView1];
    // 设置navigationBar答题卡
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 30, btn1.frame.origin.y, btn1.frame.size.width + 8, btn1.frame.size.height)];
    [view addSubview:btn2];
    [btn2 addTarget:self action:@selector(answerViewClick) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn2.frame.size.width, btn2.frame.size.height)];
    imgView2.image = [UIImage imageNamed:@"exam_paper"];
    [btn2 addSubview:imgView2];
    // 设置navigationBar纠错
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame) + 30, btn2.frame.origin.y, btn2.frame.size.width + 8, btn2.frame.size.height)];
    [view addSubview:btn3];
    [btn3 addTarget:self action:@selector(messageBtnClickMethon) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn2.frame.size.width, btn2.frame.size.height)];
    imgView3.image = [UIImage imageNamed:@"message"];
    [btn3 addSubview:imgView3];
    // 设置navigationBar计时器
    MZTimerLabel *timeLabel = [[MZTimerLabel alloc] initWithFrame:CGRectMake(10, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    timeLabel.timeLabel.textColor = [UIColor whiteColor];
    timeLabel.timeLabel.font = [UIFont systemFontOfSize:20.0f];
    self.timeLabel = timeLabel;
    [view addSubview:self.timeLabel];
    
    
    numOfQuestions = 0;
    
    MBProgressHUD *MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MB.label.text = @"正在加载试卷，请稍后...";
    [self.view bringSubviewToFront:MB];
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Questions"];
    // 按照升序排列
    [bquery orderByAscending:@"Q_num"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        numOfQuestions = (int)array.count;
        for (BmobObject *obj in array)
        {
            [self.answerBomeObjArr addObject:obj];
        }
        [self initPaperViewWithDict];
        [MB hideAnimated:YES];
        [timeLabel start];
    }];
    
    [self.navigationItem setTitleView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.topView removeFromSuperview];
}

- (void)initPaperViewWithDict
{
    Questions = 0;
    
    // 让第一个出现的题目View的标签是非题目
    self.nowLabel.text = [NSString stringWithFormat:@"非题目"];
    self.nowLabel.textColor = [UIColor grayColor];
    self.nowLabel.font = [UIFont systemFontOfSize:18];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height - 45, self.view.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, view.frame.size.height - 1)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lab.frame.size.height, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [view addSubview:lineView];
    lab.text = @"14年高数期末试卷";
    lab.font = [UIFont systemFontOfSize:15];
    [view addSubview:lab];
    self.topView = view;
    
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    
    // 设置整个试卷题目scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = scrollView;
    
    CGFloat maxX = self.scrollView.frame.size.width * (numOfQuestions + 1);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    CGFloat imgW = self.view.frame.size.width;
    CGFloat imgH = self.view.frame.size.height;
    CGFloat imgY = 0;
    CGFloat imgX = 0;
    int webJ = 0;
    __block CGFloat lastY = 0.0;
    int i, j;
    for (i = 0, j = 0; i < numOfQuestions; i ++)
    {
        imgX = i * imgW;
        // 区分大题目
        if ([self.answerBomeObjArr[i] objectForKey:@"Title"])
        {
            // 进行标题切词
            NSString *titleString = [self.answerBomeObjArr[i] objectForKey:@"Title"];
            NSRange range = [titleString rangeOfString:@"|"];
            titleString = [titleString substringToIndex:range.location];
            [self.titleArray addObject:titleString];
            
            UIView *chineseView = [[UIView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            UIFont *font = [UIFont systemFontOfSize:10];
            CGSize textSize = [[self.answerBomeObjArr[i] objectForKey:@"Title" ] sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:font];
            CGFloat textW = textSize.width + imgW - 200;
            CGFloat textH = textSize.height + 30;
            titleLabel.frame = CGRectMake(5, 20, 100, 30);
            titleLabel.font = [UIFont systemFontOfSize:30];
            titleLabel.textColor = [UIColor colorWithRed:26/255.0 green:167/255.0 blue:242/255.0 alpha:1.0];
            titleLabel.text = titleString;
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame), textW, textH)];
            textLabel.text = [[self.answerBomeObjArr[i] objectForKey:@"Title"] substringFromIndex:range.location + 1];
            // 切记加下面这行代码，代表允许自动换行
            textLabel.numberOfLines = 0;
            [chineseView addSubview:textLabel];
            [chineseView addSubview:titleLabel];
            [scrollView addSubview:chineseView];
            
            if (self.titleNumArr.count <= self.answerBomeObjArr.count)
            {
                [self.titleNumArr addObject:titleString];
            }
        }
        else
        {
            Questions ++;
            if (self.titleNumArr.count <= self.answerBomeObjArr.count)
            {
                NSNumber *tempNum = [NSNumber numberWithInt:Questions];
                [self.titleNumArr addObject:tempNum];
            }
         
            UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
            view.backgroundColor = [UIColor whiteColor];
            [scrollView addSubview:view];
            NSString *strURL = [self.answerBomeObjArr[i] objectForKey:@"Q_url"];
            strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:strURL];
            // 获取每个webView的X坐标
            NSNumber *x = [NSNumber numberWithFloat:imgX];
            [self.xArray addObject:x];
            UIWebView *firstwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, imgW, imgH)];
            NSURLRequest *request =[NSURLRequest requestWithURL:url];
            firstwebView.delegate = self;
            firstwebView.scrollView.bounces = NO;
            [firstwebView loadRequest:request];
            [view addSubview:firstwebView];
            
            if (self.isTouchCheckBtn)
            {
                UIView *firstLineView = [[UIView alloc] initWithFrame:CGRectMake(0, [self.webViewY[j] floatValue] + 1, firstwebView.frame.size.width, 1)];
                firstLineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
                [view addSubview:firstLineView];
                
                UIWebView *secondWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(firstLineView.frame), imgW, 300)];
                NSString *url = [self.answerBomeObjArr[i] objectForKey:@"A_url"];
                // 解决URL带有中文
                url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *URL = [NSURL URLWithString:url];
                NSURLRequest *request =[NSURLRequest requestWithURL:URL];
                secondWebView.delegate = self;
                secondWebView.scrollView.bounces = NO;
                [self.view addSubview: secondWebView];
                [secondWebView loadRequest:request];
                [view addSubview:secondWebView];
                
                // 设置正确和错误答题按钮
                UIButton *trueBtn = [[UIButton alloc] initWithFrame:CGRectMake(190, CGRectGetMaxY(secondWebView.frame) + 10, 60, 60)];
                trueBtn.tag = imgX + imgW;
                trueBtn.selected = NO;
                [trueBtn setImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
                [trueBtn setImage:[UIImage imageNamed:@"right_selected"] forState:UIControlStateSelected];
                [trueBtn addTarget:self action:@selector(trueBtnClickMethon:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:trueBtn];
                UIButton *falseBtn = [[UIButton alloc] initWithFrame:CGRectMake(255, CGRectGetMaxY(secondWebView.frame) + 10, 60, 60)];
                falseBtn.selected = NO;
                [falseBtn addTarget:self action:@selector(falseBtnClickMethon:) forControlEvents:UIControlEventTouchUpInside];
                falseBtn.tag = imgX + imgW;
                [falseBtn setImage:[UIImage imageNamed:@"wrong_normal"] forState:UIControlStateNormal];
                [falseBtn setImage:[UIImage imageNamed:@"wrong_selected"] forState:UIControlStateSelected];
                [view addSubview:falseBtn];

                UIView *secondLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(trueBtn.frame) + 10, secondWebView.frame.size.width, 30)];
                secondLineView.backgroundColor = [UIColor whiteColor];
                [view addSubview:secondLineView];
                UILabel *secondLineViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
                secondLineViewLabel.text = @"不会做？看这里！";
                secondLineViewLabel.font = [UIFont systemFontOfSize:14];
                secondLineViewLabel.textColor = [UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0];
                [secondLineView addSubview:secondLineViewLabel];
//                //关联对象表
                BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
                // 每一行view的个数
                int cloumns = 5;
                CGFloat viewWidth = self.view.frame.size.width;
                // 高度
                CGFloat appW = 55;          // 每一个view的大小假定固定不变
                // 宽度
                CGFloat appH = 55;
                // 计算每一行中的每一个view之间的距离
                CGFloat maginX = (viewWidth - cloumns * appW + 60) / (cloumns + 1);
                // 计算每一列中的每一个view之前的距离
                CGFloat maginY = 10;
                CGFloat maginTop = CGRectGetMaxY(secondLineView.frame);;
                
                NSMutableArray *userArr = [[NSMutableArray alloc] init];
                //需要查询的列
                BmobObject *post = [BmobObject objectWithoutDataWithClassName:@"Questions" objectId:[self.answerBomeObjArr[i] objectForKey:@"objectId"]];
                [bquery whereObjectKey:@"Users" relatedTo:post];
                [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
                 {
                    if (error)
                    {
                        NSLog(@"%@",error);
                    } else
                    {
                        for (BmobObject *user in array)
                        {
                            [userArr addObject:user];
                        }
                        for (int j = 0; j < userArr.count; j++)
                        {
                            int colIdx = j % cloumns;           // 行索引
                            int rowIdx = j / cloumns;           // 列索引
                            CGFloat appX = maginX + colIdx * (maginX + appW);
                            CGFloat appY = maginTop + rowIdx * (maginY + appH);
                            UIButton *userImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(appX, appY, appW, appH)];
                            BmobFile *file = (BmobFile*)[userArr[j] objectForKey:@"user_pic"];
                            NSURL *url = [NSURL URLWithString:file.url];
                            NSData *data = [NSData dataWithContentsOfURL:url];
                            [userImgBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                            [userImgBtn addTarget:self action:@selector(userImgBtnClickMethon:) forControlEvents:UIControlEventTouchUpInside];
                            userImgBtn.tintColor = [UIColor clearColor];
                            [userImgBtn setTitle:[userArr[j] objectForKey:@"objectId"] forState:UIControlStateNormal];
                            [userImgBtn setTitle:[userArr[j] objectForKey:@"username"] forState:UIControlStateHighlighted];
                            userImgBtn.imageView.layer.cornerRadius = userImgBtn.frame.size.width / 2;
                            [view addSubview:userImgBtn];
                            lastY = CGRectGetMaxY(userImgBtn.frame);
                            view.contentSize = CGSizeMake(0, lastY + 80);
                        }
                    }
                }];
                
                j++;
            }
            
            webJ++;
        }
    }

    UIScrollView *answerView = [[UIScrollView alloc] initWithFrame:CGRectMake(imgW * i, imgY, imgW, imgH)];
    answerView.bounces = NO;
    // 记录下答题卡的坐标
    self.lastX = answerView.frame.origin.x;

    self.scrollView.contentSize = CGSizeMake(maxX, 0);
    self.paperScrollView = answerView;
    
    // 每一行view的个0数0
    int cloumns = 6;
    CGFloat viewWidth = self.view.frame.size.width;
    // 高度
    CGFloat appW = 45;          // 每一个view的大小假定固定不变
    // 宽度
    CGFloat appH = 45;
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
    int titleK = 1, numJ = 1, question = 1;
    int btnK = 0;
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel = firstChineseLabel;
    for (int i = 1; i < numOfQuestions; i++)
    {
        if ([self.answerBomeObjArr[i] objectForKey:@"Title"])
        {
            labY = appY + appH + 5;
            UILabel *chineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(firstChineseLabel.frame.origin.x, labY, firstChineseLabel.frame.size.width, firstChineseLabel.frame.size.height)];
            chineseLabel.text = self.titleArray[titleK];
            chineseLabel.font = [UIFont systemFontOfSize:14];
            chineseLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0];
            tempLabel = chineseLabel;
            [answerView addSubview:chineseLabel];
            
            numJ++;
            titleK++;
        }
        else
        {
            int p = 0;
            // 防止出现下标为18时，btn移位
            if (i == 17)
            {
                p = 19;
            }
            else
                p=i;
            int colIdx = (p - 1) % cloumns;           // 行索引
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
            UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 12, 30, 20)];
            numLabel.center = numLabel.center;
            numLabel.text = [NSString stringWithFormat:@"%d", question];
            numLabel.font = [UIFont systemFontOfSize:16];
            numLabel.textAlignment = NSTextAlignmentCenter;
            numLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0];
            numLabel.backgroundColor = [UIColor clearColor];
            [btn addSubview:numLabel];
            
            [answerView addSubview:btn];
            question ++;
        }
    }
      UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, answerView.frame.size.height - 100, self.view.frame.size.width, 60)];
    self.checkBtn = checkBtn;
    checkBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0];
    [checkBtn addTarget:self action:@selector(checkBtnMethon) forControlEvents:UIControlEventTouchUpInside];
    UILabel *checkBtnLabel = [[UILabel alloc] init];
    checkBtnLabel.font = [UIFont systemFontOfSize:18];
    checkBtnLabel.frame = CGRectMake((checkBtn.frame.size.width - 165) / 2, (checkBtn.frame.size.height - 40) / 2, 165, 40);
    checkBtnLabel.textAlignment = NSTextAlignmentCenter;
    if (self.isTouchCheckBtn)
    {
        checkBtnLabel.text = @"完成批改并查看报告";
        checkBtn.backgroundColor = [UIColor colorWithRed:50/255.0 green:205/255.0 blue:50/255.0 alpha:1.0];
    }
    else
    {
        checkBtnLabel.text = @"查看答案并自我批改";
    }
    checkBtnLabel.textColor = [UIColor whiteColor];
    self.checkBtnLabel = checkBtnLabel;
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

- (void)trueBtnClickMethon:(UIButton *)button
{
    trueQuestionsNum ++;
    button.selected = !button.selected;
    [NSThread sleepForTimeInterval:0.2];
    [self.scrollView setContentOffset:CGPointMake(button.tag, 0) animated:YES];
    
    BmobObject *author = [BmobObject objectWithoutDataWithClassName:@"Questions" objectId:[self.answerBomeObjArr[currentPaperNum] objectForKey:@"objectId"]];
    //新建relation对象
    BmobRelation *relation = [[BmobRelation alloc] init];
    // 注意！！！取currentuser的id时，应该使用valueforkey而不是objectforkey
    [relation addObject:[BmobObject objectWithoutDataWithClassName:@"_User" objectId:[[BmobUser currentUser] valueForKey:@"objectId"]]];
    //添加关联关系到postlist列中
    [author addRelation:relation forKey:@"Users"];
    //异步更新obj的数据
    [author updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"successful");
        }else{
            NSLog(@"error %@",[error description]);
        }
    }];
}

- (void)falseBtnClickMethon:(UIButton *)button
{
    button.selected = !button.selected;
    [NSThread sleepForTimeInterval:0.2];
    [self.scrollView setContentOffset:CGPointMake(button.tag, 0) animated:YES];
    
    // 上传错误题目
    BmobObject *author = [BmobObject objectWithoutDataWithClassName:@"_User" objectId:[[BmobUser currentUser] valueForKey:@"objectId"]];
    //新建relation对象
    BmobRelation *relation = [[BmobRelation alloc] init];
    // 注意！！！取currentuser的id时，应该使用valueforkey而不是objectforkey
    [relation addObject:[BmobObject objectWithoutDataWithClassName:@"Questions" objectId:[self.answerBomeObjArr[currentPaperNum] objectForKey:@"objectId"]]];
    //添加关联关系到postlist列中
    [author addRelation:relation forKey:@"wrong_questions"];
    //异步更新obj的数据
    [author updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"successful");
        }else{
            NSLog(@"error %@",[error description]);
        }
    }];
}

-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    CGFloat webViewHeight=[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue] + self.topView.frame.size.height / 2;      // 加上20，不让webview.scrollview动
    NSNumber *num = [NSNumber numberWithFloat:webViewHeight];
    [self.webViewY addObject: num];
}

- (void)checkBtnMethon
{
    if (self.isTouchCheckBtn)
    {
        self.isTouchCheckBtnAgain = YES;
        // 设置完为yes后，要么刷新当前视图，要么向下边这么做
        self.nowLabel.text = [NSString stringWithFormat:@"答题报告"];
        self.nowLabel.textColor = [UIColor colorWithRed:50/255.0 green:205/255.0 blue:50/255.0 alpha:1.0];
    }
    
    if (self.isTouchCheckBtnAgain)
    {
        MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mb.label.text = @"正在生成答题报告,请稍等...";
        // 采用GCD模式模拟计算生成答题报告所需时间
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            float trueNums = (trueQuestionsNum / Questions ) * 100;
            UIScrollView *finalView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.answerBomeObjArr.count * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
            finalView.bounces = NO;
            finalView.backgroundColor = [UIColor whiteColor];
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
            [finalView addSubview:topView];
            topView.backgroundColor = [UIColor colorWithRed:50/255.0 green:205/255.0 blue:50/255.0 alpha:1.0];
            UILabel *accuracyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 30)];
            accuracyNumLabel.text = @"正确率";
            accuracyNumLabel.font = [UIFont systemFontOfSize:18];
            accuracyNumLabel.textColor = [UIColor whiteColor];
            [topView addSubview:accuracyNumLabel];
            
            self.paperScrollView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame), self.view.frame.size.width, self.view.frame.size.height);
            
            [finalView addSubview:self.paperScrollView];
            
            UILabel *percentageNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 170, 80)];
            percentageNumLabel.text = [NSString stringWithFormat:@"%2.1f", trueNums];
            percentageNumLabel.textColor = [UIColor whiteColor];
            percentageNumLabel.font = [UIFont systemFontOfSize:80];
            
            UILabel *percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(percentageNumLabel.frame), CGRectGetMaxY(percentageNumLabel.frame) - 20, 20, 20)];
            percentageLabel.textColor = [UIColor whiteColor];
            percentageLabel.text = @"%";
            [topView addSubview:percentageLabel];
            [topView addSubview:percentageNumLabel];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accuracyNumLabel.frame)  + 60, accuracyNumLabel.frame.origin.y, self.view.frame.size.width - CGRectGetMaxX(accuracyNumLabel.frame) - 40, 30)];
            timeLabel.textColor = [UIColor whiteColor];
            timeLabel.text = [NSString stringWithFormat:@"共耗时：%@", self.timeLabelPauseStr];
            timeLabel.font = [UIFont systemFontOfSize:18];
            [topView addSubview:timeLabel];
            
            [self.scrollView addSubview:finalView];
            finalView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.scrollView.frame) + self.topView.frame.size.height);
        });
        [mb hideAnimated:YES afterDelay:1.5];
    }
    else
    {
        [self.timeLabel pause];
        MBProgressHUD *MB = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication]keyWindow] animated:YES];
        MB.label.text = @"答案正在加载，请耐心等待...";
        self.timeLabelPauseStr = self.timeLabel.text;
        self.isTouchCheckBtn = YES;
        self.isTouchCheckBtnAgain = NO;
        [self initPaperViewWithDict];
        [MB hideAnimated:YES afterDelay:2];
    }
}

// 当前题目设置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    // 当滑过一半的时候就跳到下一页
    offSetX = offSetX + (self.scrollView.frame.size.width / 2);
    int page = offSetX / self.scrollView.frame.size.width;
    
    if (page < 21)
    {
        
        NSString *tempstr = [NSString stringWithFormat:@"%@", self.titleNumArr[page]];
        if ([self isPureInt:tempstr])
        {
            self.nowLabel.text = tempstr;
            self.nowLabel.textColor = [UIColor colorWithRed:26/255.0 green:167/255.0 blue:242/255.0 alpha:1.0];
            self.nowLabel.font = [UIFont systemFontOfSize: 20];
            currentPaperNum = page;
            isPaper = YES;
        }
        else
        {
            self.nowLabel.text = [NSString stringWithFormat:@"非题目"];
            self.nowLabel.textColor = [UIColor grayColor];
            self.nowLabel.font = [UIFont systemFontOfSize:18];
            isPaper = NO;
        }
    }
    else if (page == 21)
    {
        if (self.isTouchCheckBtnAgain)
        {
            self.nowLabel.text = [NSString stringWithFormat:@"答题报告"];
            self.nowLabel.textColor = [UIColor colorWithRed:50/255.0 green:205/255.0 blue:50/255.0 alpha:1.0];
            self.nowLabel.font = [UIFont systemFontOfSize:18];
            
        }
        else
        {
            self.nowLabel.text = [NSString stringWithFormat:@"答题卡"];
            self.nowLabel.textColor = [UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0];
            self.nowLabel.font = [UIFont systemFontOfSize:18];
        }
    }
}

// 收藏按钮点击事件
- (void)collect
{
    if (isPaper)
    {
        // 上传收藏题目
        BmobObject *author = [BmobObject objectWithoutDataWithClassName:@"_User" objectId:[[BmobUser currentUser] valueForKey:@"objectId"]];
        //新建relation对象
        BmobRelation *relation = [[BmobRelation alloc] init];
        // 注意！！！取currentuser的id时，应该使用valueforkey而不是objectforkey
        [relation addObject:[BmobObject objectWithoutDataWithClassName:@"Questions" objectId:[self.answerBomeObjArr[currentPaperNum] objectForKey:@"objectId"]]];
        //添加关联关系到postlist列中
        [author addRelation:relation forKey:@"collect_questions"];
        //异步更新obj的数据
        [author updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                NSLog(@"successful");
            }else{
                NSLog(@"error %@",[error description]);
            }
        }];

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
    else
    {
        CGFloat width = SCREEN.width * 0.5 * SCREEN_WIDTH_RATIO;
        CGFloat height = 0.3 * width;
        UIView * tip = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.5 - width / 2, self.view.frame.size.height - (self.view.frame.size.height * 0.45 / 3 * 2), width, height)];
        tip.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        tip.layer.cornerRadius = 8.0f;
        [self.view addSubview:tip];
        UILabel * label = [[UILabel alloc]init];
        label.text = @"这不是题目噢~";
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

// 我的答疑点击事件
- (void)messageBtnClickMethon
{
    self.hidesBottomBarWhenPushed = YES;
    AnswerChatListViewController * AC = [[AnswerChatListViewController alloc] init];
    AC.isShowNetworkIndicatorView = YES;
    [self.navigationController pushViewController:AC animated:YES];
}

// 答疑同学头像点击事件
- (void)userImgBtnClickMethon:(UIButton *)button
{
    self.hidesBottomBarWhenPushed = YES;
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    chat.conversationType = ConversationType_PRIVATE;
    chat.targetId = [button titleForState:UIControlStateNormal];
    chat.enableUnreadMessageIcon = YES;
    chat.enableSaveNewPhotoToLocalSystem = YES;
    chat.enableNewComingMessageIcon = YES;
    chat.title = [button titleForState:UIControlStateHighlighted];
    
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    // 设置聊天界面用户头像为圆形
    [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery getObjectInBackgroundWithId:userId block:^(BmobObject *object,NSError *error){
        if (error)
        {
            NSLog(@"%@", error);
        }
        else
        {
            if (object)
            {
                RCUserInfo *user = [[RCUserInfo alloc] init];
                BmobFile *file = (BmobFile*)[object objectForKey:@"user_pic"];
                user.portraitUri = file.url;
                user.userId = userId;
                user.name = [object objectForKey:@"username"];
                return completion(user);
            }
        }
    }];
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
