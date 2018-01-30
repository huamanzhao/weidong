//
//  OrderListViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/12.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "OrderListViewController.h"
#import "GetOrderListRequest.h"
#import <MJRefresh/MJRefresh.h>

@interface OrderListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation OrderListViewController {
    NSInteger pageNumber;
    BOOL inLoadMore;
    
    NSMutableArray *orderList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    pageNumber = 1;
    orderList = [NSMutableArray new];

    [_table setHidden:YES]; 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getOrderList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getOrderList {
    [SVProgressHUD showWithStatus:@"正在同步数据"];
    GetOrderListRequest *request = [GetOrderListRequest new];
    request.pageNumber = pageNumber;
    request.pageSize = 10;
    request.status = _orderType;
    [request excuteRequest:^(BOOL isOK, GetOrderListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        if (inLoadMore) {
            [orderList addObjectsFromArray:response.list];
            inLoadMore = NO;
            
        }
        else {
            orderList = [response.list mutableCopy];
        }
        
        if ([orderList count]) {
            [_table setHidden:NO];
        }
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [orderList count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}


@end
