//
//  PJClassTableView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJClassTableView.h"
#import "PJClassTableViewCell.h"

@implementation PJClassTableView

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    [self registerNib:[UINib nibWithNibName:@"PJClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"PJClassTableViewCell"];
}

- (void)setTableDataArr:(NSArray *)tableDataArr {
    _tableDataArr = tableDataArr;
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _tableDataArr.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PJClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJClassTableViewCell" forIndexPath:indexPath];
    cell.cellDataSource = @{@"1":@"1"};
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableDelegate PJClassTableViewCellClick];
    PJClassTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

@end
