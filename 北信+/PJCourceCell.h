//
//  PJCourceCell.h
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJHomePageCourseView.h"

@protocol PJCourceCellDelegate <NSObject>

- (void)PJCourceCellClick:(NSDictionary *)dict;

@end

@interface PJCourceCell : UITableViewCell <PJHomePageCourseViewDelegate>

@property (nonatomic, weak) id<PJCourceCellDelegate> cellDelegate;
@end
