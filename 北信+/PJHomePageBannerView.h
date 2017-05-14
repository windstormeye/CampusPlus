//
//  PJHomePageBannerView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface PJHomePageBannerView : UIView <SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSDictionary *dataSource;
@end
