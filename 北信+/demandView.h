//
//  demandView.h
//  北信+
//
//  Created by #incloud on 16/10/20.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface demandView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;


+ (instancetype)demandView;

@end
