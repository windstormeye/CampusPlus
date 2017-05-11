//
//  PJClassHomePage.h
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJClassHomePage : UIView
@property (weak, nonatomic) IBOutlet UILabel *classTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (nonatomic, strong) NSDictionary *dataSource;
@end
