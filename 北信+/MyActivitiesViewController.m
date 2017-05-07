//
//  MyActivitiesViewController.m
//  北信+
//
//  Created by #incloud on 16/10/30.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "MyActivitiesViewController.h"

@interface MyActivitiesViewController ()

@end

@implementation MyActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    self.titleLabel.text = @"我的活动";

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
