//
//  PJHomePageNewsCollectionView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/9.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageNewsCollectionView.h"
#import "PJHomePageNewsCollectionViewCell.h"

@implementation PJHomePageNewsCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    [self initView];
    return self;
}

- (void)initView {
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"PJHomePageNewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PJHomePageNewsCollectionViewCell"];
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, (_dataArr.count/2 + 1) * (SCREEN_WIDTH/2*0.7 + 15));
    [self reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_collectionDelegate PJHomePageNewsCollectionViewCellClick:_dataArr[indexPath.row]];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PJHomePageNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PJHomePageNewsCollectionViewCell" forIndexPath:indexPath];
    cell.dataSource = _dataArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = SCREEN_WIDTH/2 - 30;
    return CGSizeMake(width, width*0.8);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);    // 上、左、下、右
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}


@end
