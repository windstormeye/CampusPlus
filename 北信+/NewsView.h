//
//  NewsView.h
//  北信+
//
//  Created by #incloud on 16/9/15.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsView : UIView
@property(nonatomic, strong) News *model;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIImageView *newsImgView;


+(instancetype)newsView;
@end
