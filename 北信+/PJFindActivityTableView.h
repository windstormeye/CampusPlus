//
//  PJDelegateTableView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJFindActivityTableView : UITableView <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSArray *bannerArr;
@property (nonatomic, strong) NSArray *tableDataArr;
@end
