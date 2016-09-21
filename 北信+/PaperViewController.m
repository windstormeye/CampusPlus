//
//  PaperViewController.m
//  北信+
//
//  Created by #incloud on 16/9/17.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "PaperViewController.h"
#import "NSString+PJNSStringExtension.h"

@interface PaperViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) NSDictionary *paperDict;
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UILabel *nowLabel;
@property (nonatomic, retain) NSMutableArray *numArr;



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

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, self.navigationController.navigationBar.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    // ----------------------------------  改，未出现相关控件
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    btn1.imageView.image = [UIImage imageNamed:@"h1"];
    [view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), 0, 20, 20)];
    btn2.imageView.image = [UIImage imageNamed:@"exam_paper"];
    [view addSubview:btn2];
    
    // ----------------------------------
    [self.navigationItem setTitleView:view];
    
    NSString *paperHttpUrl = @"http://cloud.bmob.cn/17f5e4c17ad52f4a/Get_Exams";
    [self requestPaper:paperHttpUrl];
    [self initPaperViewWithDict:self.paperDict];
    
    self.nowLabel.text = [NSString stringWithFormat:@"%d",0];
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
    
    CGFloat maxX = self.scrollView.frame.size.width * arr.count;
    self.scrollView.contentSize = CGSizeMake(maxX, 0);    // 设置scrollView的分页效果，是否分页，怎么分页，取决于ScrollView的宽度，系统默认以ScrollView的宽度为一页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat imgW = self.view.frame.size.width;
    CGFloat imgH = self.view.frame.size.height;
    CGFloat imgY = 0;
    
    int j = 0;
    for (int i = 1; i < arr.count; i ++)
    {
        CGFloat imgX = (i-1) * imgW;
        NSMutableString *str = dict[@"Questions"][0];
        // 区分大题目
        if ([self IsChinese:arr[i]])
        {
            UIView *chineseView = [[UIView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
            
            UILabel *chineseLabel = [[UILabel alloc] init];
            // 切记加下面这行代码，代表允许自动换行
            chineseLabel.numberOfLines = 0;
            UIFont *font = [UIFont systemFontOfSize:10];
            CGSize textSize = [arr[i] sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:font];
            CGFloat textW = textSize.width + imgW - 200;
            CGFloat textH = textSize.height + 30;
            chineseLabel.frame = CGRectMake(5, imgW / 2, textW, textH);
            chineseLabel.text = arr[i];
            [chineseView addSubview:chineseLabel];
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
            webView.tag = j;
            [self.view addSubview: webView];
            [webView loadRequest:request];
            [scrollView addSubview:webView];
            
            j++;
        }
    }
        [self.view addSubview:scrollView];
    
    UILabel *numSumlab = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 30, view.frame.size.height)];
    numSumlab.text = [NSString stringWithFormat:@"/ %d",j];
    [view addSubview:numSumlab];
    
    UILabel *now = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 30, view.frame.size.height)];
    self.nowLabel = now;
    now.backgroundColor = [UIColor clearColor];
    now.textAlignment = NSTextAlignmentRight;
    now.textColor = [UIColor colorWithRed:191/255.0 green:62/255.0 blue:255/255.0 alpha:1.0];
    now.font = [UIFont systemFontOfSize: 24];
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
        {
            return YES;
        }
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
    for (int m = 1; m<[self.numArr count]; m++)
    {
        NSNumber *num = [self.numArr objectAtIndex:m];
        if (page != [num integerValue])
            self.nowLabel.text = [NSString stringWithFormat:@"%d",page];
    }
    
    
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
