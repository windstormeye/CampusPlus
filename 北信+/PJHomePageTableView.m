//
//  PJHomePageTableView.m
//  北信+
//
//  Created by pjpjpj on 2017/5/8.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "PJHomePageTableView.h"
#import "PJHomePageBannerView.h"
#import "PJHomePageSectionView.h"
#import "NewsViewController.h"


@implementation PJHomePageTableView
{
    PJHomePageBannerView *_bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    [self initView];
    return self;
}

- (id)init {
    self = [super init];
    [self initView];
    return self;
}
- (void)initView {
    NSArray *imagesURLStrings = @[@"http://nos.netease.com/edu-image/C5C39772ECC196D005F6EEACF98D4C9D.jpg?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/64E75B1A8458347BA49D4A77BDEA130C.jpg?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/BFABA934ABB3A4030DF95E87DEE4F167.jpg?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/EA12D3DC06397D7FAE882FA7521C33DA.png?imageView&thumbnail=1205y490&quality=100",
                                  @"http://nos.netease.com/edu-image/05E35FD224C59CBE03120BFC0F8C1FA9.jpg?imageView&thumbnail=1205y490&quality=100"
                                  ];

    
    _newsDataArr = [@[] mutableCopy];
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-48);
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    
    _bannerView = [[PJHomePageBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    self.tableHeaderView = _bannerView;
    _bannerView.dataArr =imagesURLStrings;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[PJCourceCell class] forCellReuseIdentifier:@"PJCourceCell"];
    [self registerClass:[PJNewsCell class] forCellReuseIdentifier:@"PJNewsCell"];
}

- (void)setNewsDataArr:(NSArray *)newsDataArr {
    _newsDataArr = newsDataArr;
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_HEIGHT * 0.33;
    } else {
        return (_newsDataArr.count/2 + 1) * (SCREEN_WIDTH/2*0.7 + 15);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PJHomePageSectionView *sectionView = [[PJHomePageSectionView alloc] init];
    sectionView = [[NSBundle mainBundle] loadNibNamed:@"PJHomePageSectionView" owner:self options:nil].firstObject;
    if (section == 0) {
        sectionView.showImgView.image = [UIImage imageNamed:@"blackboard"];
        sectionView.showTitleLabel.text = @"我的课程";
        return sectionView;
    } else {
        sectionView.showImgView.image = [UIImage imageNamed:@"crown"];
        sectionView.showTitleLabel.text = @"热点新闻";
        return  sectionView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PJCourceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJCourceCell" forIndexPath:indexPath];
        cell.cellDelegate = self;
        return cell;
    } else {
        PJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJNewsCell" forIndexPath:indexPath];
        cell.dataArr = _newsDataArr;
        cell.cellDelegate = self;
        return cell;
    }
}

- (void)PJNewsCellClick:(BmobObject *)data {
    [_tableDelegate PJHomePageTableViewNewsCellClick:data];
}

- (void)PJCourceCellClick:(NSDictionary *)dict {
    [_tableDelegate PJHomePageTableViewCourseCellClick:dict];
}

@end
