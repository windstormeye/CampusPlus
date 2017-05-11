//
//  PJClassTableViewCell.h
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *levelTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@property (nonatomic, strong) NSDictionary *cellDataSource;
@end
