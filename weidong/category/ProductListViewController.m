//
//  ProductListViewController.m
//  weidong
//
//  Created by zhccc on 2017/10/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductItemCell.h"
#import "Constants.h"
#import "ProductSearchRequest.h"
#import "ProductDetailViewController.h"
#import "NavibarSearchView.h"
#import "DropdownTableView.h"
#import "GetCategoryProductListRequest.h"
#import "GetPromoteProductRequest.h"
#import "ProductFilterView.h"
#import "Enum.h"
#import <MJRefresh/MJRefresh.h>
#import "CategoryInfo.h"

@interface ProductListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NavibarSearchViewDelegate, SortDropDownDelegate, ProductFilterDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NavibarSearchView *searchView;

@end

@implementation ProductListViewController {
    NSMutableArray *productList;
    ProductOrderType orderType;
    
    NSArray *sortTypeList;
    DropdownTableView *sortDropView;
    
    NSArray *funcNameList;
    NSArray *funcImageList;
    DropdownTableView *funcDropView;
    
    BOOL firstTime;
    
    NSArray *filterList;
    ProductFilterView *filterView;
    CGFloat filterWidth;
    UIControl *filterControl;
    BOOL filterShown;
    
    NSInteger pageNum;
    BOOL inLoadMore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _searchKey;
    
    [self.view bringSubviewToFront:_searchView];
    _searchView.delegate = self;
    if (!STRING_NULL(_searchKey)) {
        [_searchView setSearchTitle:_searchKey];
    }
    
    [_collection registerNib:[UINib nibWithNibName:@"ProductItemCell" bundle:nil] forCellWithReuseIdentifier:PRODUCTITEM_CELLID];
    
    pageNum = 1;
    firstTime = YES;
    inLoadMore = NO;
    orderType = OrderType_TopDesc;
    sortTypeList = @[@"综合", @"价格从低到高", @"价格从高到低"];
    funcNameList = @[@"首页", @"购物车", @"会员中心"];
    funcImageList = @[@"tabbar_home", @"tabbar_cart", @"tabbar_member"];
    
    _collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    _collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_category) {
        filterList = _category.childList;
    }
    
    if (firstTime) {
        [self loadServerData];
        firstTime = NO;
    }
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadServerData {
    if (_inJinMuMode) {
        [self getJinMuFamilyProductlist];
        return;
    }
    if (!STRING_NULL(_searchKey)) {
        [self searchProducts];
    }
    else if (_category) {
        [self getCategoryProducts];
    }
    else if (!STRING_NULL(_categoryId)) {
        [self getCategoryIDProducts];
    }
    else if (!STRING_NULL(_promotionId)) {
        [self getPromotionProducts];
    }
    else if (_inZhiyouMode) { //直邮模式
        [self getCategoryIDProducts];
    }
    else if (_inHotSelling) {
        [self getHotSellingProducts];
    }
}

- (void)refresh {
    pageNum = 1;
    [self loadServerData];
}

- (void)loadMore {
    pageNum += 1;
    inLoadMore = YES;
    [self loadServerData];
}

- (void)getCategoryIDProducts {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    GetCategoryProductListRequest *request = [GetCategoryProductListRequest new];
    if (!STRING_NULL(_categoryId)) {
        request.productCategoryId = _categoryId;
    }
    if (_inZhiyouMode) {
        request.productType = _productType;
    }
    request.orderType = orderType;
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetProductListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                productList = [response.list mutableCopy];
            }
            else {
                [productList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            
            if (productList && [productList count]) {
                [_collection setHidden:NO];
                [_collection reloadData];
            }
            else {
                [_collection setHidden:YES];
            }
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        
        [_collection.mj_header endRefreshing];
        [_collection.mj_footer endRefreshing];
    }];
}

- (void)getJinMuFamilyProductlist {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    GetCategoryProductListRequest *request = [GetCategoryProductListRequest new];
    request.productCategoryId = nil;
    request.productSupplierId = @"52";
    request.pageSize = 100000;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetProductListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                productList = [response.list mutableCopy];
            }
            else {
                [productList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            
            if (productList && [productList count]) {
                [_collection setHidden:NO];
                [_collection reloadData];
            }
            else {
                [_collection setHidden:YES];
            }
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        
        [_collection.mj_header endRefreshing];
        [_collection.mj_footer endRefreshing];
    }];
}

- (void)getCategoryProducts {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    GetCategoryProductListRequest *request = [GetCategoryProductListRequest new];
    if (!_category) {
        return;
    }
    request.productCategoryId = _category.id;
    request.orderType = orderType;
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetProductListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                productList = [response.list mutableCopy];
            }
            else {
                [productList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            
            if (productList && [productList count]) {
                [_collection setHidden:NO];
                [_collection reloadData];
            }
            else {
                [_collection setHidden:YES];
            }
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        
        [_collection.mj_header endRefreshing];
        [_collection.mj_footer endRefreshing];
    }];
}

- (void)getHotSellingProducts {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    GetCategoryProductListRequest *request = [GetCategoryProductListRequest new];
    request.productType = ProductType_Trade;
    request.orderType = orderType;
    request.pageSize = 10;
    request.pageNumber = pageNum;
    [request excuteRequest:^(BOOL isOK, GetProductListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                productList = [response.list mutableCopy];
            }
            else {
                [productList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            
            if (productList && [productList count]) {
                [_collection setHidden:NO];
                [_collection reloadData];
            }
            else {
                [_collection setHidden:YES];
            }
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        
        [_collection.mj_header endRefreshing];
        [_collection.mj_footer endRefreshing];
    }];
}

- (void)getPromotionProducts {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    GetPromoteProductRequest *request = [GetPromoteProductRequest new];
    request.promotionId = _promotionId;
    [request excuteRequest:^(BOOL isOK, GetPromoteProductResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                productList = [response.list mutableCopy];
            }
            else {
                [productList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            [_collection reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        [_collection.mj_header endRefreshing];
        [_collection.mj_footer endRefreshing];
    }];
}

- (void)searchProducts {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    ProductSearchRequest *request = [ProductSearchRequest new];
    request.keyword = _searchKey;
    request.orderType = orderType;
    request.pageNumber = pageNum;
    request.pageSize = 10;
    [request excuteRequst:^(Boolean isOK, ProductSearchResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            if (!inLoadMore) {
                productList = [response.list mutableCopy];
            }
            else {
                [productList addObjectsFromArray:response.list];
                inLoadMore = NO;
            }
            [_collection reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        [_collection.mj_header endRefreshing];
        [_collection.mj_footer endRefreshing];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [productList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    ProductInfo *product = [productList objectAtIndex:row];
    
    ProductItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PRODUCTITEM_CELLID forIndexPath:indexPath];
    [cell setupWithProduct:product];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = (SCREEN_WIDTH - 1) / 2;
    CGFloat itemHeight = itemWidth * 1.4;
    
    return CGSizeMake(itemWidth, itemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    //打开产品详情界面
    NSInteger row = indexPath.row;
    ProductInfo *product = [productList objectAtIndex:row];
    
    ProductDetailViewController *detailVC = [ProductDetailViewController new];
    detailVC.productId = product.id;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchProductWithKey:(NSString *)keyword {
    [self dismissSortView];
    [self dismissFuncView];
    
    pageNum = 1;
    _searchKey = keyword;
    [self searchProducts];
}

- (void)showSortDropdownView {
    [self dismissFuncView];
    if (sortDropView) {
        [self dismissSortView];
        return;
    }
    
    sortDropView = [[NSBundle mainBundle] loadNibNamed:@"DropdownTableView" owner:self options:nil].firstObject;
    sortDropView.frame = CGRectMake(0, 93, 100, 100);
    sortDropView.delegate = self;
    [sortDropView setupWithTitles:sortTypeList];
    [self.view addSubview:sortDropView];
}

- (void)showFuncDropdownView {
    //收起下拉选择视图
    [self dismissSortView];
    if (funcDropView) {
        [self dismissFuncView];
        return;
    }
    
    CGFloat originX = SCREEN_WIDTH * 0.6;
    funcDropView = [[NSBundle mainBundle] loadNibNamed:@"DropdownTableView" owner:self options:nil].firstObject;
    funcDropView.frame = CGRectMake(originX, 60, 100, 100);
    funcDropView.delegate = self;
    [funcDropView setupWithTitles:funcNameList Images:funcImageList];
    [self.view addSubview:funcDropView];
}

- (void)showFilterView {
    if (filterShown) {
        [self dismissFilterView];
        return;
    }
    filterShown = YES;
    
    if (!_category) {
        return;
    }
    
    if (_category.childList && [_category.childList count]) {  //如果有下一级，则筛选列表为下一级；如果没有，则为当前这一级
        filterList = _category.childList;
    }
    
    CGFloat originY = _searchView.frame.size.height + 20;
    CGFloat originX = SCREEN_WIDTH * 0.2;
    CGFloat width  = SCREEN_WIDTH - originX;
    CGFloat height = SCREEN_HEIGH - originY;
    if (!filterView) {
        filterView = [[ProductFilterView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, width, height)];
        filterView.delegate = self;
        filterControl = [[UIControl alloc] initWithFrame:CGRectMake(0, originY, SCREEN_WIDTH, height)];
        filterControl.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.4];
        [filterControl addTarget:self action:@selector(dismissFilterView) forControlEvents:UIControlEventTouchUpInside];
        [filterControl addSubview:filterView];
    }
    
    [self.view addSubview:filterControl];
    [filterView setupWithCategoryList:filterList];
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        filterView.transform = CGAffineTransformTranslate(filterView.transform, -width, 0);
    } completion:nil];
}

- (void)dismissFilterView {
    filterShown = NO;
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        filterView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [filterControl removeFromSuperview];
    }];
}

//选中筛选条件：分类的ID
- (void)filterCategoryIdSelected:(NSString *)categoryId {
    if (STRING_NULL(categoryId)) {
        return;
    }
    
    for (CategoryInfo *info in _category.childList) {
        if ([info.id isEqualToString:categoryId]) {
            _category = info;
            break;
        }
    }
    [self getCategoryProducts];
}

- (void)setSearchSortType:(ProductOrderType)type {
    //收起下拉选择视图
    [self dismissSortView];
    [self dismissFuncView];
    
    //执行搜索
    orderType = type;
    pageNum = 1;
    [self loadServerData];
}

- (void)selectSortItemAtIndex:(NSInteger)index {
    //收起下拉选择视图
    [self dismissSortView];
    
    //更新navi视图里面的搜索按钮标题
    NSString *sortType = index == 0 ? @"综合" : @"价格";
    [self.searchView updateComplexType:sortType];
    
    //执行搜索
    orderType = index;
    pageNum = 1;
    [self loadServerData];
}

- (void)selectFuncItemAtIndex:(NSInteger)index {
    [self dismissFuncView];
    
    switch (index) {
        case 0:
            [self openHomeViewController];
            break;
        case 1:
            [self openCartViewController];
            break;
        case 2:
            [self openMemberViewController];
            break;
            
        default:
            break;
    }
}

- (void)dismissSortView {
    if (sortDropView) {
        [sortDropView removeFromSuperview];
        sortDropView = nil;
    }
}

- (void)dismissFuncView {
    if (funcDropView) {
        [funcDropView removeFromSuperview];
        funcDropView = nil;
    }
}

- (void)openHomeViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)openCartViewController {
    [self.tabBarController setSelectedIndex:2];
}

- (void)openMemberViewController {
    [self.tabBarController setSelectedIndex:3];
}

- (NSArray *)stub_getCategoryList {
    CategoryInfo *category0 = [CategoryInfo new];
    category0.id  = @"11";
    category0.name = @"西餐";
    
    CategoryInfo *category1 = [CategoryInfo new];
    category1.id  = @"12";
    category1.name = @"火锅";
    
    CategoryInfo *category2 = [CategoryInfo new];
    category2.id  = @"13";
    category2.name = @"中餐";
    
    NSArray *list = @[category0, category1, category2];
    return list;
}

@end
