//
//  PJHomePageBannerView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageBannerView.h"


@implementation PJHomePageBannerView

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
    NSArray *imagesURLStrings = @[@"http://nos.netease.com/edu-image/C5C39772ECC196D005F6EEACF98D4C9D.jpg?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/64E75B1A8458347BA49D4A77BDEA130C.jpg?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/BFABA934ABB3A4030DF95E87DEE4F167.jpg?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/EA12D3DC06397D7FAE882FA7521C33DA.png?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/05E35FD224C59CBE03120BFC0F8C1FA9.jpg?imageView&thumbnail=1205y490&quality=100"
                                  ];

    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    // 自定义分页控件小圆标颜色
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    // 设置轮播器图片
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    // 自定义轮播时间间隔
    cycleScrollView.autoScrollTimeInterval = 3.5;
    // 设置分页控制器
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self addSubview:cycleScrollView];

}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    
}

@end
