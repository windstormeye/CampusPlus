//
//  PJCourceCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJCourceCell.h"


@implementation PJCourceCell
{
    PJHomePageCourseView *_kCourseView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initView];
    return self;
}

- (void)initView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _kCourseView = [[PJHomePageCourseView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[UICollectionViewFlowLayout new]];
    _kCourseView.collectionDelegate = self;
    [self.contentView addSubview:_kCourseView];
}

- (void)PJHomePageCourseViewCellClick:(NSDictionary *)dataSource {
    [_cellDelegate PJCourceCellClick:dataSource];
}

@end
