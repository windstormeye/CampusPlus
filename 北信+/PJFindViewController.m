//
//  PJDelegateViewController.m
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJFindViewController.h"
#import "PJDelegateTableView.h"

@interface PJFindViewController ()

@end

@implementation PJFindViewController
{
    PJDelegateTableView *_kTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    [self initNavigationBar];
    self.titleLabel.text = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.leftBarButton setImage:nil forState:0];
    
    _kTableView = [[PJDelegateTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:_kTableView];
}

@end
