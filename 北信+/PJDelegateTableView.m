//
//  PJDelegateTableView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/16.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJDelegateTableView.h"

@implementation PJDelegateTableView

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end
