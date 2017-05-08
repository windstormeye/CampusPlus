//
//  PJCourceCell.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJCourceCell.h"
#import "PJHomePageCourseView.h"

@implementation PJCourceCell
{
    PJHomePageCourseView *_kCourseView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initView];
    return self;
}

- (void)initView {
    // 设置我的课程
    UIView *classesView1 = [[UIView alloc] initWithFrame:CGRectMake(27, 0, 70, 70)];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView1.image = [UIImage imageNamed:@"1"];
    [classesView1 addSubview:imgView1];
    UILabel *className1 = [[UILabel alloc] initWithFrame:CGRectMake(8, 50, 70, 20)];
    className1.text = [NSString stringWithFormat:@"离散数学"];
    className1.font = [UIFont systemFontOfSize:13];
    className1.textColor = [UIColor blackColor];
    [classesView1 addSubview:className1];
    UIButton *classBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView1.frame.size.width, classesView1.frame.size.height)];
    classBtn1.backgroundColor = [UIColor redColor];
    [classBtn1 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn1.backgroundColor = [UIColor clearColor];
    [classesView1 addSubview:classBtn1];
    [self addSubview:classesView1];
    
    UIView *classesView2 = [[UIView alloc] initWithFrame:CGRectMake(27 + 70 + 27, 0, 70, 70)];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView2.image = [UIImage imageNamed:@"2"];
    [classesView2 addSubview:imgView2];
    UILabel *className2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className2.text = [NSString stringWithFormat:@"C语言"];
    className2.font = [UIFont systemFontOfSize:13];
    className2.textColor = [UIColor blackColor];
    [classesView2 addSubview:className2];
    UIButton *classBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView2.frame.size.width, classesView2.frame.size.height)];
    classBtn2.backgroundColor = [UIColor redColor];
    [classBtn2 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn2.backgroundColor = [UIColor clearColor];
    [classesView2 addSubview:classBtn2];
    [self addSubview:classesView2];
    
    UIView *classesView3 = [[UIView alloc] initWithFrame:CGRectMake(27 * 3 + 70 * 2, 0, 70, 70)];
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView3.image = [UIImage imageNamed:@"3"];
    [classesView3 addSubview:imgView3];
    UILabel *className3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 70, 20)];
    className3.text = [NSString stringWithFormat:@"电工"];
    className3.font = [UIFont systemFontOfSize:13];
    className3.textColor = [UIColor blackColor];
    [classesView3 addSubview:className3];
    UIButton *classBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView3.frame.size.width, classesView3.frame.size.height)];
    classBtn3.backgroundColor = [UIColor redColor];
    [classBtn3 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn3.backgroundColor = [UIColor clearColor];
    [classesView3 addSubview:classBtn3];
    [self addSubview:classesView3];
    
    UIView *classesView4 = [[UIView alloc] initWithFrame:CGRectMake(27, 0 + 70 + 20, 70, 70)];
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView4.image = [UIImage imageNamed:@"4"];
    [classesView4 addSubview:imgView4];
    UILabel *className4 = [[UILabel alloc] initWithFrame:CGRectMake(8, 50, 70, 20)];
    className4.text = [NSString stringWithFormat:@"高等数学"];
    className4.font = [UIFont systemFontOfSize:13];
    className4.textColor = [UIColor blackColor];
    [classesView4 addSubview:className4];
    // 设置科目点击事件
    UIButton *classBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView4.frame.size.width, classesView4.frame.size.height)];
    classBtn4.backgroundColor = [UIColor redColor];
    [classBtn4 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn4.backgroundColor = [UIColor clearColor];
    [classesView4 addSubview:classBtn4];
    [self addSubview:classesView4];
    
    UIView *classesView5 = [[UIView alloc] initWithFrame:CGRectMake(27 + 70 + 27, 0 + 70 + 20, 70, 70)];
    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 35, 35)];
    imgView5.image = [UIImage imageNamed:@"5"];
    [classesView5 addSubview:imgView5];
    UILabel *className5 = [[UILabel alloc] initWithFrame:CGRectMake(8, 50, 70, 20)];
    className5.text = [NSString stringWithFormat:@"大学物理"];
    className5.font = [UIFont systemFontOfSize:13];
    className5.textColor = [UIColor blackColor];
    [classesView5 addSubview:className5];
    UIButton *classBtn5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, classesView5.frame.size.width, classesView5.frame.size.height)];
    classBtn5.backgroundColor = [UIColor redColor];
    [classBtn5 addTarget:self action:@selector(classViewClick) forControlEvents:UIControlEventTouchUpInside];
    classBtn5.backgroundColor = [UIColor clearColor];
    [classesView5 addSubview:classBtn5];
    [self addSubview:classesView5];
    
}

@end
