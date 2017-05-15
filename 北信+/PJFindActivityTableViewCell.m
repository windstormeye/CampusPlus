//
//  PJFindActivityTableViewCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/15.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJFindActivityTableViewCell.h"
#import "PJFindActivityCollectionView.h"

@implementation PJFindActivityTableViewCell
{
    PJFindActivityCollectionView *_collection;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initView];
    return self;
}
-(void)initView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _collection = [[PJFindActivityCollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.contentView addSubview:_collection];
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    _collection.dataArr = dataArr;
}

@end
