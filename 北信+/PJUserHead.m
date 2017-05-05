//
//  PJUserHead.m
//  北信+
//
//  Created by pjpjpj on 2017/5/5.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJUserHead.h"

@implementation PJUserHead

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 205);
    self.layer.masksToBounds = false;
    _userImgView.layer.cornerRadius = 35;
    _userImgView.layer.masksToBounds = true;
    _userImgView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _userImgView.layer.borderWidth = 2;
    
    [self setData];
}

- (void)setData {
    BmobFile *file = (BmobFile*)[[BmobUser currentUser] objectForKey:@"user_pic"];
    NSURL *url = [NSURL URLWithString:file.url];
    [_userImgView sd_setImageWithURL:url];
    
    _usernameLabel.text = [NSString stringWithFormat:@"%@", [[BmobUser currentUser] objectForKey:@"username"]];
    _usercollegeLabel.text = [NSString stringWithFormat:@"%@", [[BmobUser currentUser] objectForKey:@"School"]];
    _userschoolLabel.text = [NSString stringWithFormat:@"%@", [[BmobUser currentUser] objectForKey:@"Class"]];
}

@end
