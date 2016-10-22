//
//  OutCampusViewController.m
//  北信+
//
//  Created by #incloud on 16/10/17.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "OutCampusViewController.h"

@interface OutCampusViewController ()

@end

@implementation OutCampusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210, 20)];
    label.center = self.view.center;
    label.text = @"该模块暂未开放，敬请期待！";
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
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
