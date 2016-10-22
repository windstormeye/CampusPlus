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
#import "demandView.h"
#import "IQKeyboardManager.h"


@interface FindViewController () <UITextFieldDelegate>

@property (nonatomic, strong) OutCampusViewController *Out;
@property (nonatomic, strong) OnCampusViewController *on;
@property (weak, nonatomic) UIButton *cover;
@property(nonatomic, weak) demandView *de;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *textStr;
@property (copy, nonatomic) NSString *moneyStr;

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
    segmentedControl.layer.masksToBounds = YES;
    segmentedControl.layer.cornerRadius = 10;
    segmentedControl.layer.borderWidth = 1;
    segmentedControl.layer.borderColor = [[UIColor whiteColor] CGColor];
    segmentedControl.frame = CGRectMake(0, 0, 100, 30);
    
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
    
    // 活动发布按钮
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 390, 50, 50)];
    [addBtn setImage:[UIImage imageNamed:@"add_activity"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.shadowOffset =  CGSizeMake(1, 1);
    addBtn.layer.shadowOpacity = 0.8;
    addBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
    [self.view addSubview:addBtn];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBtnClick
{
    demandView *de = [demandView demandView];
    [de.sureBtn addTarget:self action:@selector(demandViewSureBtnMethon) forControlEvents:UIControlEventTouchUpInside];
    de.textView.layer.borderWidth = 0.3;
    de.textView.layer.cornerRadius = 10;
    de.center = self.navigationController.view.center;
    de.layer.cornerRadius = 13.0f;
    de.clipsToBounds = YES;
    de.alpha = 0.0;
    
    de.titleTextField.delegate = self;
    de.moneyTextField.delegate = self;
    
    // 创建蒙板按钮
    UIButton *btnCover = [[UIButton alloc]init];
    // 设置蒙板按钮的大小
    btnCover.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height);
    // 设置蒙板按钮的颜色
    btnCover.backgroundColor = [UIColor blackColor];
    // 设置蒙板按钮的透明度，开始先设置为0，使用动画进行变化
    btnCover.alpha = 0.0;
    // 添加蒙板按钮至最底层的View中
    [self.tabBarController.view addSubview:btnCover];
    self.cover = btnCover;
    // 为按钮注册一个单击事件
    [btnCover addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    //设置动画，在0.5秒内把这个图片变大
    [UIView animateWithDuration:0.3 animations:^{
        btnCover.alpha = 0.6;
        de.alpha = 1.0;
    }];
    
    self.de = de;
    [self.tabBarController.view addSubview:de];     // 此处一定不能写成self.navigationController.view，否则会把发布界面置于最下层
    [self.tabBarController.view   bringSubviewToFront:de];
}

- (void)demandViewSureBtnMethon
{
    self.titleStr = self.de.titleTextField.text;
    self.textStr = self.de.textView.text;
    self.moneyStr = self.de.moneyTextField.text;
    
    [self removeAll];
    
    NSLog(@"%@\n%@\n%@",self.titleStr, self.textStr, self.moneyStr);
}

- (void)event:(UITapGestureRecognizer *)gesture
{
    [self.de endEditing:YES];
}

- (void)removeAll
{
    // 设置动画
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0.0;
        self.de.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.de removeFromSuperview];
        [self.cover removeFromSuperview];
        self.cover = nil;
    }];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.de endEditing:YES];
    return YES;
}

@end
