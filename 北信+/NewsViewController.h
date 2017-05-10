//
//  NewsViewController.h
//  北信+
//
//  Created by #incloud on 16/9/16.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController

@property (nonatomic, strong) BmobObject *data;

- (void)getNewsMessageWithURL:(NSString *)urlStr;

@end
