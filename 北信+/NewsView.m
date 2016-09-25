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
    self.newsLabel.text = model.title;
    self.newsLabel.font = [UIFont systemFontOfSize:10];
    
//    self.newsLabel.text = [NSString stringWithFormat:@"11111"];
//    self.newsImgView.image = [UIImage imageNamed:@"h1"];

//    self.newsImgView.image = model.imgView.image;
    
}

- (IBAction)newsBtnClikc:(id)sender {
}

+(instancetype)newsView
{
    // 找到xib文件，寻找过程类似寻找plist文件
    return [[[NSBundle mainBundle] loadNibNamed:@"News" owner:nil options:nil] firstObject];         // first或者last都可以，因为里面只有一个
}

@end
