//
//  PJClassViewController.m
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJClassViewController.h"
#import "PJClassTableView.h"
#import "PaperViewController.h"

@interface PJClassViewController () <PJClassTableViewDelegate>

@end

@implementation PJClassViewController
{
    PJClassTableView *_kTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.title = @"历届真题";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _kTableView = [PJClassTableView new];
    _kTableView.tableDelegate = self;
    _kTableView.tableDataArr = [@[] mutableCopy];
    [self.view addSubview:_kTableView];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)PJClassTableViewCellClick {
    PaperViewController *vc = [PaperViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
