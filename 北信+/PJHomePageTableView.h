//
//  PJHomePageTableView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJNewsCell.h"
#import "PJCourceCell.h"

@protocol PJHomePageTableViewDelegate <NSObject>

- (void)PJHomePageTableViewNewsCellClick:(BmobObject *)data;
- (void)PJHomePageTableViewCourseCellClick:(NSDictionary *)dict;

@end

@interface PJHomePageTableView : UITableView <UITableViewDelegate, UITableViewDataSource, PJNewsCellDelegate, PJCourceCellDelegate>


@property (nonatomic, strong) NSArray *newsDataArr;
@property (nonatomic, weak) id<PJHomePageTableViewDelegate> tableDelegate;
@end
