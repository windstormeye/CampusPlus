//
//  PJFindAcitityCollectionViewCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJFindAcitityCollectionViewCell.h"

@implementation PJFindAcitityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    _showImgView.contentMode = UIViewContentModeScaleAspectFill;
    _showImgView.clipsToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [_showImgView sd_setImageWithURL:[NSURL URLWithString:dataSource[@"url"]] placeholderImage:[UIImage imageNamed:@"nopic"]];
    _showTitleLablel.text = [NSString stringWithFormat:@"%@", dataSource[@"info"][0]];
}

@end
