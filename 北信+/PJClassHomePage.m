//
//  PJClassHomePage.m
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJClassHomePage.h"

@implementation PJClassHomePage

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    
    [self sendSubviewToBack:_bgView];
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    _classTitleLabel.text = [NSString stringWithFormat:@"%@", dataSource[@"title"]];
}

@end
