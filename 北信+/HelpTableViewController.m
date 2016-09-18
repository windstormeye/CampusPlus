//
//  HelpTableViewController.m
//  北信+
//
//  Created by #incloud on 16/9/18.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "HelpTableViewController.h"
#import "HelpDateilsViewController.h"
#import "HelpThings.h"

@interface HelpTableViewController () <UISearchControllerDelegate, UISearchResultsUpdating>

//  查询控制器
@property (nonatomic,strong)UISearchController *searchController;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (strong,nonatomic) NSMutableArray  *dataList;

@end

@implementation HelpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:184/255.0 blue:242/255.0 alpha:1.0]];
    //设置navigationbar为不透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationItem.title = @"搜索";
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = YES;
    //搜索时，背景变模糊
//    _searchController.obscuresBackgroundDuringPresentation = YES;
    _searchController.searchBar.placeholder = @"输入想要帮助内容";
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.dataList=[NSMutableArray arrayWithCapacity:100];
    
    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld-FlyElephant",(long)i]];
    }
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

    if (self.searchController.active) {
        return [self.searchList count];
    }else{
        return [self.dataList count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpDateilsViewController *help = [[HelpDateilsViewController alloc] init];
    [self.navigationController pushViewController:help animated:YES];
}




@end
