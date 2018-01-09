//
//  CategoryMainViewController.m
//  weidong
//
//  Created by zhccc on 2017/9/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CategoryMainViewController.h"
#import "GetProductCategoryRequest.h"
#import "CategoryPrimaryCell.h"
#import "ProductListViewController.h"
#import "CategoryInfo.h"
#import <MJRefresh/MJRefresh.h>

@interface CategoryMainViewController () <UITableViewDelegate, UITableViewDataSource, CetegoryPrimaryDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation CategoryMainViewController {
    NSArray *categoryList;
    CGFloat sectionHeaderHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStatusBarBGColor];
    [self setTintColor:ZHAO_BLUE];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.title = @"商品分类";
    
    categoryList = [NSArray new];
    sectionHeaderHeight = 10.0;
    
    [_table registerNib:[UINib nibWithNibName:@"CategoryPrimaryCell" bundle:nil] forCellReuseIdentifier:CATEGORYPRIMARY_CELLID];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 160;
    _table.sectionHeaderHeight = sectionHeaderHeight;
    _table.sectionFooterHeight = 0.01;
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getCategoryList];
    }];
    
    [self getCategoryList];
    
    if (@available(iOS 11.0, *)) {
        _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_table.mj_header endRefreshing];
}

- (void)getCategoryList {
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    GetProductCategoryRequest *request = [GetProductCategoryRequest new];
    [request excuteRequest:^(BOOL isOK, GetCategoryResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            categoryList = [NSArray new];
            categoryList = response.list;
            [_table reloadData];
        }
        
        [_table.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [categoryList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    
    CategoryPrimaryCell *cell = [tableView dequeueReusableCellWithIdentifier:CATEGORYPRIMARY_CELLID forIndexPath:indexPath];
    [cell setupWithCategory:[categoryList objectAtIndex:index]];
    cell.delegate = self;
    return cell;
}

- (void)selectPrimaryCategory:(CategoryInfo *)category {
    [self showProductListOfCategory:category];
}

- (void)selectChildCategory:(CategoryInfo *)category {
    [self showProductListOfCategory:category];
}

- (void)showProductListOfCategory:(CategoryInfo *)category {
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.category = category;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
