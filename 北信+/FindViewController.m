//
//  FindViewController.m
//  北信+
//
//  Created by #incloud on 16/9/13.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "FindViewController.h"
#import "OnCampusViewController.h"
#import "OutCampusViewController.h"

@interface FindViewController ()

@property (nonatomic, strong) OutCampusViewController *Out;
@property (nonatomic, strong) OnCampusViewController *on;


@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0]];
    //设置navigationbar为不透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"校内",@"校外",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = segmentedControl;
     [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];  //添加委托方法
    
    // 在这注意一点，校内得放在校内view的后边要不然会被后实例化的校外view覆盖
    OutCampusViewController *Out = [[OutCampusViewController alloc] init];
    self.Out = Out;
    [self.view addSubview:Out.view];
    OnCampusViewController *on = [[OnCampusViewController alloc] init];
    self.on = on;
    [self.view addSubview:on.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
    if (!index)
    {
        self.on.view.hidden = NO;
        self.Out.view.hidden = YES;
    }
    else
    {
        self.on.view.hidden = YES;
        self.Out.view.hidden = NO;
    }
}


@end
