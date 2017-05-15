//
//  PJFindActivityCollectionView.h
//  北信+
//
//  Created by pjpjpj on 2017/5/13.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJFindActivityCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArr;
@end
