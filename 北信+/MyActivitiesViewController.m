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
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    self.titleLabel.text = @"我的活动";
}


@end
