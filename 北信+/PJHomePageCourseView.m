//
//  PJHomePageCourseView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageCourseView.h"
#import "PJHomePageCourseCollectionViewCell.h"

@implementation PJHomePageCourseView

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
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.33);
    [self registerNib:[UINib nibWithNibName:@"PJHomePageCourseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PJHomePageCourseCollectionViewCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PJHomePageCourseCollectionViewCell *cell = (PJHomePageCourseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *titleStr = cell.showLabel.text;
    NSDictionary *dict = @{@"title":titleStr};
    [_collectionDelegate PJHomePageCourseViewCellClick:dict];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PJHomePageCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PJHomePageCourseCollectionViewCell" forIndexPath:indexPath];
    cell.cellIndex = indexPath.row;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = SCREEN_WIDTH/4 - 15;
    return CGSizeMake(width, width+10);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);    // 上、左、下、右
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}


@end
