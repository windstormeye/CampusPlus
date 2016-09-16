//
//  NewsViewController.m
//  北信+
//
//  Created by #incloud on 16/9/16.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNewsMessageWithURL:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.view addSubview: webView];
    [webView loadRequest:request];
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
