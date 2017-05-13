//
//  PJHomePageSectionView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/9.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageSectionView.h"

@implementation PJHomePageSectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (id)init {
    self = [super init];
    self = [[NSBundle mainBundle] loadNibNamed:@"PJHomePageSectionView" owner:self options:nil].firstObject;
    [self initView];
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
}

@end
