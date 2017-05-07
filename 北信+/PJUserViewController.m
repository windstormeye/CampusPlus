//
//  PJUserViewController.m
//  北信+
//
//  Created by pjpjpj on 2017/5/5.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJUserViewController.h"
#import "PJUserHead.h"
#import "MyAllCollectTableViewController.h"
#import "MyAllWrongBookDetailTableViewController.h"
#import "MydelegateTableViewController.h"
#import "MyActivitiesViewController.h"


@interface PJUserViewController ()

@end

@implementation PJUserViewController
{
    PJUserHead *_tableHead;
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
    self.navigationBar.alpha = 0;
    [self.leftBarButton setImage:[UIImage imageNamed:@"notice"] forState:0];
    [self.leftBarButton addTarget:self action:@selector(messageAction) forControlEvents:1<<6];
    [self.rightBarButton setImage:[UIImage imageNamed:@"setting"] forState:0];
    [self.rightBarButton addTarget:self action:@selector(settingAction) forControlEvents:1<<6];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.masksToBounds = false;
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PJUserHead" owner:self options:nil];
    _tableHead = views.firstObject;
    _tableView.tableHeaderView = _tableHead;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.01;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MyAllCollectTableViewController *vc = [MyAllCollectTableViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            MyAllWrongBookDetailTableViewController *vc = [MyAllWrongBookDetailTableViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            MydelegateTableViewController *vc = [MydelegateTableViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            MyActivitiesViewController *vc = [MyActivitiesViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset<0) {
        _tableHead.backView.frame = CGRectMake(offset / 2, -64+offset, SCREEN_WIDTH-offset, 220-offset);
    }else{
        self.navigationBar.alpha = offset/134.0;
    }
    if (offset>70) {
        [self.leftBarButton setImage:[[UIImage imageNamed:@"notice"] imageWithColor:[UIColor blackColor]] forState:0];
        [self.rightBarButton setImage:[[UIImage imageNamed:@"setting"] imageWithColor:[UIColor blackColor]] forState:0];
    }else{
        [self.leftBarButton setImage:[UIImage imageNamed:@"notice"] forState:0];
        [self.rightBarButton setImage:[UIImage imageNamed:@"setting"] forState:0];
    }
}

/*
 * 设置按钮
 */
-(void)settingAction{
   
}
/*
 * 消息按钮
 */
-(void)messageAction{

}

@end
