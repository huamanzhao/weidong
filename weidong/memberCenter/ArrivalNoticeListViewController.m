//
//  ArrivalNoticeListViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/11.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ArrivalNoticeListViewController.h"
#import "GetProductNotifyRequest.h"
#import "ArrivalNotifyCell.h"
#import <MJRefresh/MJRefresh.h>

@interface ArrivalNoticeListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ArrivalNoticeListViewController {
    NSInteger pageNumber;
    BOOL inLoadMore;
    
    NSMutableArray *noticeList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到货通知";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 136;
    _table.sectionHeaderHeight = 0.01;
    _table.sectionFooterHeight = 8.0;
    [_table registerNib:[UINib nibWithNibName:@"ArrivalNotifyCell" bundle:nil] forCellReuseIdentifier:ARRIVALNOTIFY_CELLID];
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
    
    [_table setHidden:YES];
    
    pageNumber = 1;
    inLoadMore = NO;
    noticeList = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getArrivalList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    pageNumber = 1;
    
    [self getArrivalList];
}

- (void)loadMore {
    pageNumber += 1;
    inLoadMore = YES;
    
    [self getArrivalList];
}

- (void)getArrivalList {
    [SVProgressHUD showWithStatus:@"正在获取数据"];
    GetProductNotifyRequest *request = [GetProductNotifyRequest new];
    request.pageSize = 10;
    request.pageNumber = pageNumber;
    [request excuteRequest:^(BOOL isOK, GetProductNotifyResponse *response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        if (!inLoadMore) {
            noticeList = [response.list mutableCopy];
        }
        else {
            [noticeList addObjectsFromArray:response.list];
            inLoadMore = NO;
        }
        
        if ([noticeList count]) {
            [_table setHidden:NO];
            [_table reloadData];
        }
        
        [_table.mj_header endRefreshing];
        [_table.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [noticeList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArrivalNotifyCell *cell = [tableView dequeueReusableCellWithIdentifier:ARRIVALNOTIFY_CELLID forIndexPath:indexPath];
    [cell setupWithNoficeInfo:[noticeList objectAtIndex:indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
