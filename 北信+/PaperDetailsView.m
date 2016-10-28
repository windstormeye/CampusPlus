
//
//  PaperDetailsView.m
//  北信+
//
//  Created by #incloud on 16/9/16.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "PaperDetailsView.h"
#import "AllPaperDetailsTableViewController.h"
#import "ViewController.h"
#define SCREEN_WIDTH_RATIO (SCREEN.width / 320)  //屏宽比例
#define SCREEN [UIScreen mainScreen].bounds.size

@implementation PaperDetailsView

+(instancetype)paperView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PaperDetailsView" owner:nil options:nil] firstObject];
}

- (IBAction)previousQuestions:(id)sender
{
    AllPaperDetailsTableViewController* paper = [[AllPaperDetailsTableViewController alloc]init];
    // 解决tabelView距离左边界有15px距离的问题
    if ([paper.tableView respondsToSelector:@selector(setSeparatorInset:)])
        [paper.tableView setSeparatorInset:UIEdgeInsetsZero];
    if ([paper.tableView respondsToSelector:@selector(setLayoutMargins:)])
        [paper.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    [[self getCurrentVC] pushViewController:paper animated:YES];
    [self setExtraCellLineHidden:paper.tableView];

}

- (IBAction)IntelligentPractice:(id)sender
{
    CGFloat width = SCREEN.width * 0.5 * SCREEN_WIDTH_RATIO;
    CGFloat height = 0.3 * width;
    UIView * tip = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.5 - width / 2, self.frame.size.height * 0.45 - height / 2, width, height)];
    tip.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    tip.layer.cornerRadius = 8.0f;
    [self addSubview:tip];
//    tip.center = CGPointMake(SCREEN.width * 0.3, SCREEN.height * 0.5);;
    UILabel * label = [[UILabel alloc]init];
    label.text = @"神秘功能，敬请期待";
    //sizetofit的作用，是让label自动适应为跟文字大小等大的label
    label.font = [UIFont systemFontOfSize:12];
    [label sizeToFit];
    label.center = CGPointMake(tip.frame.size.width * 0.5, tip.frame.size.height * 0.5);
    [tip addSubview:label];
    tip.alpha = 0.0;
    [UIView animateWithDuration:1.2 animations:^{
        tip.alpha = 1;
    } completion:^(BOOL finished) {
            [tip removeFromSuperview];
    }];
}

- (IBAction)wrongNotebook:(id)sender
{
    NSLog(@"111");
}

- (IBAction)favorites:(id)sender
{
    NSLog(@"111");
}

- (IBAction)myDoubt:(id)sender
{
    NSLog(@"111");
}
//获取当前屏幕显示的viewcontroller
- (UINavigationController *)getCurrentVC
{
    UITabBarController* VC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController* vc = (UINavigationController*)VC.childViewControllers[0];
    
    return vc;
}
// 隐藏多余的cell，不过实际上还是存在的
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

@end
