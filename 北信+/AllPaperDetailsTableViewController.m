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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
    PaperViewController *paper = [[PaperViewController alloc] init];
    [self.navigationController pushViewController:paper animated:YES];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
