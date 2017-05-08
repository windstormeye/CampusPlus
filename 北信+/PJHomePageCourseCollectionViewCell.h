//
//  PJHomePageCourseCollectionViewCell.h
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJHomePageCourseCollectionViewCell : UICollectionViewCell 
@property (weak, nonatomic) IBOutlet UIImageView *showImgView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (nonatomic, assign) NSInteger cellIndex;

@property (nonatomic, strong) NSDictionary *dataSource;
@end
