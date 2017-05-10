//
//  PJHomePageNewsCollectionView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/9.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PJHomePageNewsCollectionViewDelegate <NSObject>

- (void)PJHomePageNewsCollectionViewCellClick:(BmobObject *)data;

@end

@interface PJHomePageNewsCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) id<PJHomePageNewsCollectionViewDelegate> collectionDelegate;
@end
