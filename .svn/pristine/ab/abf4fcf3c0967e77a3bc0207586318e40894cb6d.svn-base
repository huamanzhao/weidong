//
//  ConsulationListViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/11.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ConsulationListViewController.h"
#import "ConsulateProductCell.h"
#import "GetConsulationRequest.h"
#import "ProductDetailViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface ConsulationListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ConsulationListViewController {
    NSInteger pageNumber;
    NSInteger pageSize;
    BOOL inLoadMore;
    
    NSMutableArray *consulateList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的咨询";
    [self initNaviBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    
    consulateList = [NSMutableArray new];
    pageNumber = 1;
    pageSize = 10;
    
    [_table setHidden:YES];
    _table.rowHeight = 132;
    _table.sectionFooterHeight = 8;
    _table.sectionHeaderHeight = 0.01;
    [_table registerNib:[UINib nibWithNibName:@"ConsulateProductCell" bundle:nil] forCellReuseIdentifier:CONSULATE_CELLID];
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getConsulationList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    pageNumber = 1;
    
    [self getConsulationList];
}

- (void)loadMore {
    pageNumber += 1;
    inLoadMore = YES;
    
    [self getConsulationList];
}

- (void)getConsulationList {
    [SVProgressHUD showWithStatus:@"正在同步数据"];
    GetConsulationRequest *request = [GetConsulationRequest new];
    request.pageNumber = pageNumber;
    request.pageSize = pageSize;
    [request excuteRequest:^(BOOL isOK, GetConsulationResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        if (!inLoadMore) {
            consulateList = [response.list mutableCopy];
        }
        else {
            [consulateList addObjectsFromArray:response.list];
            inLoadMore = NO;
        }
        
        if ([consulateList count] > 0) {
            [_table setHidden:NO];
            [_table reloadData];
        }
        else {
            [_table setHidden:YES];
        }
        
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [consulateList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsulateProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CONSULATE_CELLID forIndexPath:indexPath];
    [cell setupWithConsulation:[consulateList objectAtIndex:indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ConsultationInfo *consulation = [consulateList objectAtIndex:indexPath.section];
    ProductDetailViewController *detailVC = [ProductDetailViewController new];
    detailVC.productId = consulation.productId;
    detailVC.showConsulation = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
