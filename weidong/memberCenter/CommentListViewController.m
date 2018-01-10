//
//  CommentListViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/11.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CommentListViewController.h"
#import "GetCommentLIstRequest.h"
#import "ConsulateProductCell.h"
#import <MJRefresh/MJRefresh.h>
#import "ProductDetailViewController.h"

@interface CommentListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation CommentListViewController {
    NSInteger pageNumber;
    NSInteger pageSize;
    BOOL inLoadMore;
    
    NSMutableArray *commentList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.title = @"我的评论";
    
    commentList = [NSMutableArray new];
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
    
    [self getCommentList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    pageNumber = 1;
    
    [self getCommentList];
}

- (void)loadMore {
    pageNumber += 1;
    inLoadMore = YES;
    
    [self getCommentList];
}

- (void)getCommentList {
    [SVProgressHUD showWithStatus:@"正在同步数据"];
    GetCommentLIstRequest *request = [GetCommentLIstRequest new];
    request.pageNumber = pageNumber;
    request.pageSize = pageSize;
    [request excuteRequest:^(BOOL isOK, GetCommentListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        if (!inLoadMore) {
            commentList = [response.list mutableCopy];
        }
        else {
            [commentList addObjectsFromArray:response.list];
            inLoadMore = NO;
        }
        
        if ([commentList count] > 0) {
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
    return [commentList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsulateProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CONSULATE_CELLID forIndexPath:indexPath];
    [cell setupWithComment:[commentList objectAtIndex:indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CommentInfo *comment = [commentList objectAtIndex:indexPath.section];
    ProductDetailViewController *detailVC = [ProductDetailViewController new];
    detailVC.productId = comment.productId;
    detailVC.showComment = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
