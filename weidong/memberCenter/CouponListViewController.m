//
//  CouponListViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/25.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CouponListViewController.h"
#import "CouponListCell.h"
#import "GetCouponListRequest.h"
#import <MJRefresh/MJRefresh.h>

@interface CouponListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation CouponListViewController {
    NSInteger pageNumber;
    BOOL inLoadMore;
    NSMutableArray *couponList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    pageNumber = 1;
    couponList = [NSMutableArray new];
    
    [_table setHidden:YES];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 160;
    _table.sectionHeaderHeight = 0.01;
    _table.sectionFooterHeight = 8.0;
    [_table registerNib:[UINib nibWithNibName:@"CouponListCell" bundle:nil] forCellReuseIdentifier:COUPON_CELLID];
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getCouponList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    pageNumber = 1;
    [self getCouponList];
}

- (void)loadMore {
    pageNumber += 1;
    inLoadMore = YES;
    [self getCouponList];
}

- (void)getCouponList {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    GetCouponListRequest *request = [GetCouponListRequest new];
    request.pageSize = 10;
    request.pageNumber = pageNumber;
    [request excuteRequest:^(BOOL isOK, GetCouponListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        if (!inLoadMore) {
            couponList = [response.list mutableCopy];
        }
        else {
            [couponList addObjectsFromArray:response.list];
            inLoadMore = NO;
        }
        
        if ([couponList count]) {
            [_table setHidden:NO];
            [_table reloadData];
        }
        
        [_table.mj_header endRefreshing];
        [_table.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [couponList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:COUPON_CELLID forIndexPath:indexPath];
    [cell setupWithCoupon:[couponList objectAtIndex:indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
