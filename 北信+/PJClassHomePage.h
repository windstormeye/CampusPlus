//
//  PJClassHomePage.h
//  北信+
//
//  Created by pjpjpj on 2017/5/11.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PJClassHomePageDelegate <NSObject>

- (void)PJClassHomePagePushQuestionBtnClick;

@end

@interface PJClassHomePage : UIView
@property (weak, nonatomic) IBOutlet UILabel *classTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImgView;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (nonatomic, strong) NSDictionary *dataSource;

@property (nonatomic, weak) id<PJClassHomePageDelegate> viewDelegate;
@end
