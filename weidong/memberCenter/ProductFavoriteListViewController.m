//
//  ProductFavoriteListViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductFavoriteListViewController.h"
#import "FavoriteProductCell.h"
#import "GetFavoriteListRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "ProductDetailViewController.h"
#import "RemoveFavoriteReqeust.h"

@interface ProductFavoriteListViewController () <UITableViewDelegate, UITableViewDataSource, FavoriteProductCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ProductFavoriteListViewController {
    NSInteger pageNumber;
    NSInteger pageSize;
    BOOL inLoadMore;
    
    NSMutableArray *favoriteList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品收藏";
    [self initNaviBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    [self.table setHidden:YES];
    favoriteList = [NSMutableArray new];
    
    pageNumber = 1;
    pageSize = 10;
    
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 80;
    _table.sectionHeaderHeight = 0.01;
    _table.sectionFooterHeight = 8.0;
    [_table registerNib:[UINib nibWithNibName:@"FavoriteProductCell" bundle:nil] forCellReuseIdentifier:FAVORITE_CELLID];
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getFavoriteList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    pageNumber = 1;
    
    [self getFavoriteList];
}

- (void)loadMore {
    pageNumber += 1;
    inLoadMore = YES;
    
    [self getFavoriteList];
}

- (void)getFavoriteList {
    [SVProgressHUD showWithStatus:@"正在同步数据"];
    GetFavoriteListRequest *request = [GetFavoriteListRequest new];
    request.pageNumber = pageNumber;
    request.pageSize = pageSize;
    [request excuteRequest:^(BOOL isOK, GetFavoriteListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        if (!inLoadMore) {
            favoriteList = [response.list mutableCopy];
        }
        else {
            [favoriteList addObjectsFromArray:response.list];
            inLoadMore = NO;
        }
        
        if ([favoriteList count] > 0) {
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
    return [favoriteList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteProductCell *cell = [tableView dequeueReusableCellWithIdentifier:FAVORITE_CELLID forIndexPath:indexPath];
    [cell setupWithFavoriteProduct: [favoriteList objectAtIndex:indexPath.section]];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = indexPath.section;
    FavoriteProductInfo *favorite = [favoriteList objectAtIndex:index];
    [self openProductDetailVC:favorite.productId];
}

- (void)removeProductWithId:(NSString *)favoriteId {
    [SVProgressHUD showWithStatus:@"正在删除"];
    RemoveFavoriteReqeust *request = [RemoveFavoriteReqeust new];
    request.id = favoriteId;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [self getFavoriteList];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

- (void)openProductDetailVC:(NSString *)productId {
    ProductDetailViewController *detailVC = [ProductDetailViewController new];
    detailVC.productId = productId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
