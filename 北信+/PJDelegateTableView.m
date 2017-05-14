//
//  PJDelegateTableView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJDelegateTableView.h"
#import "PJHomePageSectionView.h"
#import "PJHomePageBannerView.h"
#import "PJFindTableSectionView.h"

@implementation PJDelegateTableView
{
    PJHomePageBannerView *_bannerView;
}

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initView];
    return self;
}

- (void)setBannerArr:(NSArray *)bannerArr {
    _bannerView.dataArr = bannerArr;
    [self reloadData];
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    
    _bannerView = [[PJHomePageBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    self.tableHeaderView = _bannerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PJFindTableSectionView *view = [PJFindTableSectionView new];
    view = [[NSBundle mainBundle] loadNibNamed:@"PJFindTableSectionView" owner:self options:nil].firstObject;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end
