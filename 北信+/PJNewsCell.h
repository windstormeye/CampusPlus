//
//  PJNewsCell.h
//  北信+
//
//  Created by pjpjpj on 2017/5/9.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJHomePageNewsCollectionView.h"

@protocol PJNewsCellDelegate <NSObject>

- (void)PJNewsCellClick:(BmobObject *)data;

@end

@interface PJNewsCell : UITableViewCell <PJHomePageNewsCollectionViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) id<PJNewsCellDelegate> cellDelegate;
@end
