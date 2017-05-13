//
//  PJSlideshowTableViewCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJSlideshowTableViewCell.h"
#import "PJHomePageBannerView.h"


@implementation PJSlideshowTableViewCell
{
    PJHomePageBannerView *_bannerView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initView];
    return self;
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [self initView];
}

- (void)initView {
    _bannerView = [[PJHomePageBannerView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 160)];
    [self addSubview:_bannerView];
    _bannerView.layer.cornerRadius = 10;
    _bannerView.layer.masksToBounds = YES;
}

@end
