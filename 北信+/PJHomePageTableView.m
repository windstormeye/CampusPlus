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

@implementation PJHomePageTableView
{
    PJHomePageBannerView *_bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    [self initView];
    return self;
}

- (void)initView {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    _bannerView = [PJHomePageBannerView new];
    self.tableHeaderView = _bannerView;
    
    [self registerClass:[PJCourceCell class] forCellReuseIdentifier:@"PJCourceCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_WIDTH/4 + 50;
      
    } else {
        return 90;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        // 设置我的课程栏
        UIView *myClassView=[[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
        myClassView.backgroundColor = [UIColor whiteColor];
        UIImageView *myclassImg = [[UIImageView alloc] initWithFrame:CGRectMake(13, 10, 35, myClassView.frame.size.height - 10)];
        myclassImg.image = [UIImage imageNamed:@"blackboard"];
        [myClassView addSubview:myclassImg];
        // 设置我的课程标签
        UILabel *myclassLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 50, 20)];
        myclassLabel.text = [NSString stringWithFormat:@"我的课程"];
        myclassLabel.textColor = [UIColor blackColor];
        myclassLabel.font = [UIFont systemFontOfSize:12];
        [myClassView addSubview:myclassLabel];
        return myClassView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PJCourceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJCourceCell" forIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
}

@end
