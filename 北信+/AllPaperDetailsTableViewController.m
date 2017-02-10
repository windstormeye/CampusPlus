//
//  AllPaperDetailsTableViewController.m
//  北信+
//
//  Created by #incloud on 16/9/17.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "AllPaperDetailsTableViewController.h"
#import "PaperViewController.h"

@interface AllPaperDetailsTableViewController ()

@end

@implementation AllPaperDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.title = @"历届真题";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:12];
    lab.text = @"北京信息科技大学 · BISTU";
    // 动态计算label中的字符串长度得到label的宽度
    CGSize size = [lab.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:lab.font,NSFontAttributeName, nil]];
    CGFloat labX = (self.view.frame.size.width - size.width )/ 2;
    lab.frame = CGRectMake(labX, 0, size.width, view.frame.size.height);
    
    lab.tintColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [view addSubview:lab];
    view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.tableView.tableHeaderView = view;

    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"paperDetailsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    else
    {
        // 进行cell重用的时候如果这个cell是之前有的，所以重用这个cell的时候需要把它上面的全部控件去除掉
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
    imgView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [cell addSubview:imgView];
    CGFloat height = 20;
    UILabel *gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, imgView.frame.size.width, height)];
    gradeLabel.font = [UIFont systemFontOfSize:16];
    gradeLabel.text = @"14级";
    [imgView addSubview:gradeLabel];
    CGFloat width2 = 200;
    CGFloat height2 = 20;
    UILabel *gradePaperLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 10, imgView.frame.origin.y, width2, height2)];
    gradePaperLabel.font = [UIFont systemFontOfSize:14];
    gradePaperLabel.text = @"14级高数期末试卷";
    [cell addSubview:gradePaperLabel];
    UILabel *correct = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 10, CGRectGetMaxY(gradePaperLabel.frame)+15, 75, 10)];
    correct.text = @"平均正确率：";
    correct.font = [UIFont systemFontOfSize:12];
    correct.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [cell addSubview:correct];
    UILabel *rate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(correct.frame), correct.frame.origin.y, 40, 10)];
    rate.text = @"89.9%";
    rate.font = [UIFont systemFontOfSize:12];
    rate.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [cell addSubview:rate];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    PaperViewController *paper = [[PaperViewController alloc] init];
    [self.navigationController pushViewController:paper animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}



@end
