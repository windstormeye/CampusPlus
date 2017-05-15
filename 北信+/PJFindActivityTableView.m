//
//  PJDelegateTableView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJFindActivityTableView.h"
#import "PJHomePageSectionView.h"
#import "PJHomePageBannerView.h"
#import "PJFindTableSectionView.h"
#import "PJFindActivityTableViewCell.h"


@implementation PJFindActivityTableView
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

- (void)setTableDataArr:(NSArray *)tableDataArr {
    _tableDataArr = tableDataArr;
    [self reloadData];
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bannerView = [[PJHomePageBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    self.tableHeaderView = _bannerView;
    
    [self registerClass:[PJFindActivityTableViewCell class] forCellReuseIdentifier:@"PJFindActivityTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (_tableDataArr.count/2 + 1) * (SCREEN_WIDTH/2*0.7 + 15) + 20;
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
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PJFindActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJFindActivityTableViewCell" forIndexPath:indexPath];
    cell.dataArr = _tableDataArr;
    return cell;
}

@end
