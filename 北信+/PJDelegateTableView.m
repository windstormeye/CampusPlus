//
//  PJDelegateTableView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJDelegateTableView.h"
#import "PJSlideshowTableViewCell.h"
#import "PJHomePageSectionView.h"

@implementation PJDelegateTableView
{
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

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    [self registerClass:[PJSlideshowTableViewCell class] forCellReuseIdentifier:@"PJSlideshowTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 170;
    } else {
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PJHomePageSectionView *view = [PJHomePageSectionView new];
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        view.showImgView.image = [UIImage imageNamed:@"fire_balloon"];
        view.showTitleLabel.text = @"high翻全场";
        view.showTitleLabel.textColor = RGB(119, 119, 119);
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PJSlideshowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJSlideshowTableViewCell" forIndexPath:indexPath];
        cell.dataSource = @{@"1":@"1"};
        return cell;
    } else {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
}

@end
