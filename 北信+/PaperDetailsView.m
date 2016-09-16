
//
//  PaperDetailsView.m
//  北信+
//
//  Created by #incloud on 16/9/16.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "PaperDetailsView.h"
#import "HelpViewController.h"

@implementation PaperDetailsView

+(instancetype)paperView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PaperDetailsView" owner:nil options:nil] firstObject];
}

- (IBAction)previousQuestions:(id)sender
{
    //挑转哪个页面？
    HelpViewController* hp = [[HelpViewController alloc]init];
    [[self getCurrentVC] pushViewController:hp animated:YES];

}

- (IBAction)IntelligentPractice:(id)sender
{
    
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
@end
