//
//  PJClassTableView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PJClassTableViewDelegate <NSObject>

// 这里需要改
- (void)PJClassTableViewCellClick;

@end

@interface PJClassTableView : UITableView <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSArray *tableDataArr;
@property (nonatomic, weak) id<PJClassTableViewDelegate> tableDelegate;
@end
