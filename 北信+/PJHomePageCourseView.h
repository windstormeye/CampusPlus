//
//  PJHomePageCourseView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PJHomePageCourseViewDelegate <NSObject>

- (void)PJHomePageCourseViewCellClick:(NSDictionary *)dataSource;

@end

@interface PJHomePageCourseView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<PJHomePageCourseViewDelegate> collectionDelegate;
@end
