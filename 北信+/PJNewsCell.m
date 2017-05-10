//
//  PJNewsCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/9.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJNewsCell.h"


@implementation PJNewsCell
{
    PJHomePageNewsCollectionView *_collectionView;
}

//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    return self;
//}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self initView];
}

- (void)initView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _collectionView = [[PJHomePageNewsCollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[UICollectionViewFlowLayout new]];
    _collectionView.dataArr = _dataArr;
    _collectionView.collectionDelegate = self;
    [self.contentView addSubview:_collectionView];
}

- (void)PJHomePageNewsCollectionViewCellClick:(BmobObject *)data {
    [_cellDelegate PJNewsCellClick:data];
}

@end
