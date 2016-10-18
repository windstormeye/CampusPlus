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


@end

@implementation NewsView


// 此方法不能删！！！删掉后点击新闻会崩掉
- (IBAction)newsBtnClikc:(id)sender
{
    // 千万不能删
}

+(instancetype)newsView
{
    // 找到xib文件，寻找过程类似寻找plist文件
    return [[[NSBundle mainBundle] loadNibNamed:@"News" owner:nil options:nil] firstObject];         // first或者last都可以，因为里面只有一个
}

@end
