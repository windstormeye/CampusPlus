//
//  PJDelegateTableView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/16.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJDelegateTableView : UITableView <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSArray *dataArr;
@end
