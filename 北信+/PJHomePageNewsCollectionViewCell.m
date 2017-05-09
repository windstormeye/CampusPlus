//
//  PJHomePageNewsCollectionViewCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/9.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageNewsCollectionViewCell.h"

@implementation PJHomePageNewsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    _showImgView.layer.cornerRadius = 5;
    _showImgView.layer.masksToBounds = YES;
}

- (void)setDataSource:(BmobObject *)dataSource {
    _dataSource = dataSource;
    [_showImgView sd_setImageWithURL:[NSURL URLWithString:[[dataSource objectForKey:@"image_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"nopic"]];
    _showTitleLabel.text = [NSString stringWithFormat:@"%@", [dataSource objectForKey:@"title"]];
}

@end
