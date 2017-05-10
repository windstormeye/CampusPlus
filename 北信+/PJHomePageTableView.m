//
//  PJHomePageTableView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageTableView.h"
#import "PJHomePageBannerView.h"
#import "PJCourceCell.h"
#import "PJHomePageSectionView.h"
#import "NewsViewController.h"


@implementation PJHomePageTableView
{
    PJHomePageBannerView *_bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    [self initView];
    return self;
}

- (id)init {
    self = [super init];
    [self initView];
    return self;
}
- (void)initView {
    _newsDataArr = [@[] mutableCopy];
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-48);
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    _bannerView = [PJHomePageBannerView new];
    self.tableHeaderView = _bannerView;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[PJCourceCell class] forCellReuseIdentifier:@"PJCourceCell"];
    [self registerClass:[PJNewsCell class] forCellReuseIdentifier:@"PJNewsCell"];
}

- (void)setNewsDataArr:(NSArray *)newsDataArr {
    _newsDataArr = newsDataArr;
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_HEIGHT * 0.33;
    } else {
        return (_newsDataArr.count/2 + 1) * (SCREEN_WIDTH/2*0.7 + 15);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PJHomePageSectionView *sectionView = [[PJHomePageSectionView alloc] init];
    sectionView = [[NSBundle mainBundle] loadNibNamed:@"PJHomePageSectionView" owner:self options:nil].firstObject;
    if (section == 0) {
        sectionView.showImgView.image = [UIImage imageNamed:@"blackboard"];
        sectionView.showTitleLabel.text = @"我的课程";
        return sectionView;
    } else {
        sectionView.showImgView.image = [UIImage imageNamed:@"crown"];
        sectionView.showTitleLabel.text = @"热点新闻";
        return  sectionView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PJCourceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJCourceCell" forIndexPath:indexPath];
        return cell;
    } else {
        PJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJNewsCell" forIndexPath:indexPath];
        cell.dataArr = _newsDataArr;
        cell.cellDelegate = self;
        return cell;
    }
}

- (void)PJNewsCellClick:(BmobObject *)data {
    [_tableDelegate PJHomePageTableViewNewsCellClick:data];
}

@end
