//
//  PJUserSectionHeadView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/7.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJUserSectionHeadView.h"

@implementation PJUserSectionHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIButton *attBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 50)];
    [self addSubview:attBtn];
    [attBtn setTitle:@" 我的关注" forState:UIControlStateNormal];
    [attBtn setImage:[UIImage imageNamed:@"att"] forState:UIControlStateNormal];
    attBtn.backgroundColor = [UIColor whiteColor];
    attBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [attBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [attBtn addTarget:self action:@selector(attBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *fensBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(attBtn.frame), 0, attBtn.frame.size.width, 50)];
    [self addSubview:fensBtn];
    [fensBtn setTitle:@" 我的粉丝" forState:UIControlStateNormal];
    [fensBtn setImage:[UIImage imageNamed:@"fens"] forState:UIControlStateNormal];
    fensBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    fensBtn.backgroundColor = [UIColor whiteColor];
    [fensBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [fensBtn addTarget:self action:@selector(fensBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)attBtnClick {
    
}

- (void)fensBtnClick {
    
}

@end
