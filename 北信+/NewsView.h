//
//  NewsView.h
//  北信+
//
//  Created by #incloud on 16/9/15.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>

@interface NewsView : UIView
@property(nonatomic, strong) BmobObject *obj;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIImageView *newsImgView;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

+(instancetype)newsView;
@end
