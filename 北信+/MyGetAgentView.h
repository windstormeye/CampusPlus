//
//  MyGetAgentView.h
//  北信+
//
//  Created by #incloud on 16/11/3.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGetAgentView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (instancetype)getAgentView;
@end
