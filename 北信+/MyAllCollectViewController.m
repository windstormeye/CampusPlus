//
//  MyAllCollectViewController.m
//  北信+
//
//  Created by #incloud on 16/10/3.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "MyAllCollectViewController.h"

@interface MyAllCollectViewController ()

@end

@implementation MyAllCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的收藏";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
