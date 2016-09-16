//
//  NewsView.m
//  北信+
//
//  Created by #incloud on 16/9/15.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "NewsView.h"
#import "NewsViewController.h"

@interface NewsView ()

@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

@end

@implementation NewsView

-(void)setModel:(News *)model
{
    _model = model;
//    self.newsLabel.text = model.title;
//    self.newsLabel.font = [UIFont systemFontOfSize:10];
    
    self.newsLabel.text = [NSString stringWithFormat:@"11111"];
    self.newsImgView.image = [UIImage imageNamed:@"h1"];

//    self.newsImgView.image = model.imgView.image;
    
}



//- (UIViewController *)getPresentedViewController
//{
//    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController *topVC = appRootVC;
//    if (topVC.presentedViewController)
//    {
//        topVC = topVC.presentedViewController;
//    }
//    
//    return topVC;
//}

//- (UIViewController *)getCurrentVC
//{
//    UIViewController *result = nil;
//    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//    
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//        result = nextResponder;
//    else
//        result = window.rootViewController;
//    
//    return result;
//}


- (IBAction)newsBtnClikc:(id)sender {
}

+(instancetype)newsView
{
    // 找到xib文件，寻找过程类似寻找plist文件
    return [[[NSBundle mainBundle] loadNibNamed:@"News" owner:nil options:nil] firstObject];         // first或者last都可以，因为里面只有一个
}

@end
