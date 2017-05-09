//
//  PJHomePageCourseCollectionViewCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageCourseCollectionViewCell.h"

@implementation PJHomePageCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    
}

- (void)setCellIndex:(NSInteger)cellIndex {
    _cellIndex = cellIndex;
    _showImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", (int)self.cellIndex]];
    NSLog(@"%d", (int)cellIndex);
    switch (self.cellIndex) {
        case 0:
            _showLabel.text = @"离散数学"; break;
        case 1:
            _showLabel.text = @"C语言"; break;
        case 2:
            _showLabel.text = @"电工"; break;
        case 3:
            _showLabel.text = @"高等数学"; break;
        case 4:
            _showLabel.text = @"大学物理"; break;
    }

}

- (void)setDataSource:(NSDictionary *)dataSource {
   
}

@end
