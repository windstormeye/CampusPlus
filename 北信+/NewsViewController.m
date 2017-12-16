//
//  NewsViewController.m
//  北信+
//
//  Created by #incloud on 16/9/16.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];

    self.title = [NSString stringWithFormat:@"%@", [_data objectForKey:@"title"]];
    
    NSString *str = [_data objectForKey:@"url"];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self getNewsMessageWithURL:str];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getNewsMessageWithURL:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
