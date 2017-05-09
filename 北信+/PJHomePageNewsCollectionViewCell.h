//
//  PJHomePageNewsCollectionViewCell.h
//  北信+
//
//  Created by pjpjpj on 2017/5/9.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJHomePageNewsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *showImgView;
@property (weak, nonatomic) IBOutlet UILabel *showTitleLabel;

@property (nonatomic, strong) BmobObject *dataSource;
@end
