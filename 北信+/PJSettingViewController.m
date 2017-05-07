//
//  PJSettingViewController.m
//  北信+
//
//  Created by pjpjpj on 2017/5/7.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJSettingViewController.h"

@interface PJSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation PJSettingViewController
{
    UITableView *_tableView;
    UIView *_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    self.automaticallyAdjustsScrollViewInsets = false;
    _tableView = self.tableView;
    _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [_tableView removeFromSuperview];
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = _view;
    [_view addSubview:_tableView];
    [self initNavigationBar];

    self.titleLabel.text = @"设置";
    _cacheLabel.text = [NSString stringWithFormat:@"%luM",(unsigned long)[[SDImageCache sharedImageCache] getSize]/1024/1024];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [PJHUD showWithStatus:@""];
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] cleanDisk];
        [PJHUD showSuccessWithStatus:@"清理完成"];
        _cacheLabel.text = [NSString stringWithFormat:@"%luM",(unsigned long)[[SDImageCache sharedImageCache] getSize]/1024/1024];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }
    return 5;
}

@end
