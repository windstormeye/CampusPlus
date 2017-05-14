//
//  PJHomePageBannerView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageBannerView.h"


@implementation PJHomePageBannerView
{
    SDCycleScrollView *_kView;
}

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initView];
    return self;
}

- (void)initView {
    
    _kView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    // 自定义分页控件小圆标颜色
    _kView.currentPageDotColor = [UIColor whiteColor];
    // 自定义轮播时间间隔
    _kView.autoScrollTimeInterval = 3.5;
    // 设置分页控制器
    _kView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self addSubview:_kView];

}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    _kView.imageURLStringsGroup = dataArr;
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    
}

@end
