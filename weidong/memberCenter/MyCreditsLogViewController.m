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
#import "CreditLogCell.h"
#import <MJRefresh/MJRefresh.h>

@interface MyCreditsLogViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyCreditsLogViewController {
    NSMutableArray *creditLogList;
    NSMutableArray *coinLogList;
    UITableView *table;
    
    NSInteger pageNum;
    BOOL inLoadMore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _showCoinLog ? @"我的微动币" : @"我的积分";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    creditLogList = [NSMutableArray new];
    coinLogList = [NSMutableArray new];
    
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
    table.rowHeight = 48;
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
    if (!_showCoinLog) {
        [self getCreditsLogs];
    }
    else {
        [self getCoinsLogs];
    }
}

- (void)getCreditsLogs {
    [SVProgressHUD showWithStatus:@"正在加载"];
    GetPointsLogRequest *request = [GetPointsLogRequest new];
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetPointsLogResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                creditLogList = [response.list mutableCopy];
            }
            else {
                [creditLogList addObjectsFromArray:response.list];
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

- (void)getCoinsLogs {
    [SVProgressHUD showWithStatus:@"正在加载"];
    GetCoinsLogRequest *request = [GetCoinsLogRequest new];
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetCoinsLogResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                coinLogList = [response.list mutableCopy];
            }
            else {
                [coinLogList addObjectsFromArray:response.list];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return _showCoinLog ? [coinLogList count] : [creditLogList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CreditLogCell *cell = [tableView dequeueReusableCellWithIdentifier:CREDITLOG_CELLID forIndexPath:indexPath];
    if (!_showCoinLog) {
        if (section == 0) {
            [cell setupCreditTitleStyle];
        }
        else {
            [cell setupWithCredit:[creditLogList objectAtIndex:row] Index:row];
        }
    }
    else {
        if (section == 0) {
            [cell setupCoinTitleStyle];
        }
        else {
            [cell setupWithCoin:[coinLogList objectAtIndex:row] Index:row];
        }
    }
    return cell;
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
    
    creditLogList = @[credit0, credit1, credit2, credit3, credit4, credit5];
}


@end
