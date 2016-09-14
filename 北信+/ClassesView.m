//
//  ClassesView.m
//  北信+
//
//  Created by #incloud on 16/9/14.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "ClassesView.h"

@interface ClassesView ()
@property (weak, nonatomic) IBOutlet UIImageView *classImgView;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
- (IBAction)classBtnClick:(id)sender;



@end

@implementation ClassesView

-(void)setModel:(MyClasses *)model
{
    _model = model;
    
}

+ (instancetype)ClassView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"classes" owner:nil options:nil] firstObject];         // first或者last都可以，因为里面只有一个
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)classBtnClick:(id)sender {
}
@end
