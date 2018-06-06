//
//  MyCreditsLogViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MyCreditsLogViewController.h"
#import "GetPointsLogRequest.h"
#import "GetCoinsLogRequest.h"
#import "GetWeiBeanLogsRequest.h"
#import "CreditLogCell.h"
#import <MJRefresh/MJRefresh.h>
#import "CoinDetailViewController.h"

@interface MyCreditsLogViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyCreditsLogViewController {
    NSMutableArray *dataLogList;
    UITableView *table;
    
    NSInteger pageNum;
    BOOL inLoadMore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = @"";
    if (self.type == 0) {
        title = @"我的微动币";
    }
    else if (self.type == 1) {
        title = @"我的积分";
    }
    else {
        title = @"我的微豆";
    }
    self.title = title;
    
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    dataLogList = [NSMutableArray new];
    
    pageNum = 1;
    inLoadMore = NO;
    
    [self initTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getServerData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initTable {
    table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.estimatedRowHeight = 64;
    table.rowHeight = UITableViewAutomaticDimension;
    table.sectionHeaderHeight = 0;
    table.sectionFooterHeight = 10;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerNib:[UINib nibWithNibName:@"CreditLogCell" bundle:nil] forCellReuseIdentifier:CREDITLOG_CELLID];
    [self.view addSubview:table];
    
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
}

- (void)refresh {
    pageNum = 1;
    [self getServerData];
}

- (void)loadMore {
    pageNum += 1;
    inLoadMore = YES;
    [self getServerData];
}

- (void)getServerData {
    if (self.type == 0) {   //积分查询
        [self getCreditsLogs];
    }
    else if (self.type == 0) {  //微动币查询
        [self getCoinsLogs];
    }
    else {  //微豆查询
        [self getBeanLogs];
    }
}

//积分查询
- (void)getCreditsLogs {
    [SVProgressHUD showWithStatus:@"正在加载"];
    GetPointsLogRequest *request = [GetPointsLogRequest new];
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetPointsLogResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                dataLogList = [response.list mutableCopy];
            }
            else {
                [dataLogList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            
            [table reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        
        [table.mj_header endRefreshing];
        [table.mj_footer endRefreshing];
    }];
}

//微动币查询
- (void)getCoinsLogs {
    [SVProgressHUD showWithStatus:@"正在加载"];
    GetCoinsLogRequest *request = [GetCoinsLogRequest new];
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetCoinsLogResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                dataLogList = [response.list mutableCopy];
            }
            else {
                [dataLogList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            
            [table reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        
        [table.mj_header endRefreshing];
        [table.mj_footer endRefreshing];
    }];
}

//微豆查询
- (void)getBeanLogs {
    [SVProgressHUD showWithStatus:@"正在加载"];
    GetWeiBeanLogsRequest *request = [GetWeiBeanLogsRequest new];
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, NSArray * _Nullable list, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        if (!inLoadMore) {
            dataLogList = [list mutableCopy];
        }
        else {
            [dataLogList addObjectsFromArray:list];
            inLoadMore = NO;
        }
        
        [table reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return [dataLogList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CreditLogCell *cell = [tableView dequeueReusableCellWithIdentifier:CREDITLOG_CELLID forIndexPath:indexPath];
    if (self.type == 0) {   //积分
        if (section == 0) {
            [cell setupCreditTitleStyle];
        }
        else {
            [cell setupWithCredit:[dataLogList objectAtIndex:row] Index:row];
        }
    }
    else if (self.type == 1 || self.type == 2){
        if (section == 0) {
            [cell setupCoinTitleStyle];
        }
        else {
            [cell setupWithCoin:[dataLogList objectAtIndex:row] Index:row];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        return;
    }
    
    if (self.type == 1 || self.type == 2) {
        CoinDetailViewController *detailVC = [CoinDetailViewController new];
        detailVC.coinLog = [dataLogList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

//ZC_DEBUG
- (void)getStubCreditList {
    CreditLogInfo *credit0 = [CreditLogInfo new];
    credit0.type = 1;
    credit0.credit = 10;
    credit0.debit = 0;
    credit0.balance = 125;
    
    CreditLogInfo *credit1 = [CreditLogInfo new];
    credit1.type = 3;
    credit1.credit = 0;
    credit1.debit = 5;
    credit1.balance = 115;
    
    CreditLogInfo *credit2 = [CreditLogInfo new];
    credit2.type = 2;
    credit2.credit = 0;
    credit2.debit = 5;
    credit2.balance = 110;
    
    CreditLogInfo *credit3 = [CreditLogInfo new];
    credit3.type = 2;
    credit3.credit = 20;
    credit3.debit = 0;
    credit3.balance = 115;
    
    CreditLogInfo *credit4 = [CreditLogInfo new];
    credit4.type = 2;
    credit4.credit = 20;
    credit4.debit = 0;
    credit4.balance = 115;
    
    CreditLogInfo *credit5 = [CreditLogInfo new];
    credit5.type = 2;
    credit5.credit = 20;
    credit5.debit = 0;
    credit5.balance = 115;
    
    dataLogList = @[credit0, credit1, credit2, credit3, credit4, credit5];
}


@end
