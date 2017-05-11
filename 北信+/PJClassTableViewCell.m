//
//  PJClassTableViewCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJClassTableViewCell.h"

@implementation PJClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    
}

- (void)setCellDataSource:(NSDictionary *)cellDataSource {
    _levelTitleLabel.text = [NSString stringWithFormat:@"14级"];
    _titleLabel.text = [NSString stringWithFormat:@"14级高数期中试题"];
    _detailsLabel.text = [NSString stringWithFormat:@"平均正确率：78%"];
}

@end
