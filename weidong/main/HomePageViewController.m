//
//  HomePageViewController.m
//  weidong
//
//  Created by zhccc on 2017/9/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "HomePageViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "Util.h"
#import "Constants.h"
#import "LoopView.h"
#import "BannerView.h"
#import "CollectionTableViewCell.h"
#import "PromotionTableViewCell.h"
#import "ScrollTableViewCell.h"
#import "CategoryTableViewCell.h"
#import "ProductListViewController.h"
#import "AdvertisementViewController.h"
#import "ProductDetailViewController.h"
#import "ChargeCenterViewController.h"
#import "ChargeWebViewController.h"
#import "LoginViewController.h"

#import "ProductSearchRequest.h"
#import "GetHotSearchRequest.h"
#import "GetBannerAdsRequest.h"
#import "GetPromotionRequest.h"
#import "GetHomeCategoryRequest.h"
#import "GetFuncCategoryRequest.h"
#import "GetArticalDetailRequest.h"

#import "CheckVersionRequest.h"
#import "RefreshTokenReqeust.h"
#import "GetProductCommentRequest.h"
#import "GetProductConsultRequest.h"

#import "RealNameVerifyViewController.h"


@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource, BannerViewDelegate, LoopDelegate, ScrollCellDelegate, CategoryCellDelegate, CollectionFuncDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation HomePageViewController {
    NSArray *colorList;
    UITextField *searchText;
    HeaderSearchView *searchView;
    BannerView *banner;
    
    NSArray *bannerAdList;
    NSArray *searchList;
    NSArray *hotKeyList;
    NSArray *btnCateList;
    NSArray *promotionList;
    NSArray *hotspotAdList;
    NSArray *categoryList;
    
    //网络请求是否完毕
    BOOL getBtnCategoryDone;
    BOOL getPromotionsDone;
    BOOL getHotpotAdsDone;
    BOOL getCategoriesDone;
    
    BOOL firstLoad;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initStatusBarBGColor];
    [self setTintColor:ZHAO_BLUE];
    
    [self initNaviBarLeftItem];
    [self initNaviBarRightItem];
    [self initNaviBarTitle];
    
    [self initTableView];
    
    colorList = @[[UIColor colorWithHex:0xff6437], [UIColor colorWithHex:0xe04f5f], [UIColor colorWithHex:0x008aff]];
    
    firstLoad = YES;
    //初始置为未完毕
    getBtnCategoryDone = NO;
    getPromotionsDone = NO;
    getHotpotAdsDone  = NO;
    getCategoriesDone = NO;
    
    bannerAdList = [NSArray new];
    btnCateList = [NSArray new];
    promotionList = [NSArray new];
    hotspotAdList = [NSArray new];
    categoryList = [NSArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self initNaviBackGroundImage:YES];
    
    if (firstLoad) {
        //服务端数据请求
        [self loadServerData];
        
        firstLoad = NO;
    }
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (searchView) {
        [searchView dismiss];
        searchView = nil;   //避免从其他界面返回后，此界面出不来
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self initNaviBackGroundImage:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNaviBarLeftItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:UIImageWithName(@"navi_more") style:UIBarButtonItemStylePlain target:self action:@selector(naviLeftBarItemPressed)];
    [item setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)initNaviBarRightItem {
    UIBarButtonItem *userItem = [[UIBarButtonItem alloc] initWithImage:UIImageWithName(@"navi_user") style:UIBarButtonItemStylePlain target:self action:@selector(naviRightBarItemPressed)];
    [userItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = userItem;
}

- (void)initNaviBarTitle {
    //背景View
    CGFloat titleHeight = 32;
    CGFloat titleWidth  = SCREEN_WIDTH * 0.65;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleHeight)];
    bgView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    bgView.layer.cornerRadius = 6.0;
    
    //搜索图标
    CGFloat imageTopMargin = 8.0;
    CGFloat imageLength = titleHeight - imageTopMargin * 2;
    CGFloat imageLeadingMagin = imageTopMargin;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageLeadingMagin, imageTopMargin, imageLength, imageLength)];
    imageView.image = UIImageWithName(@"navi_search");
    [imageView setTintColor:[UIColor grayColor]];
    [bgView addSubview:imageView];
    
    //搜索Textfield
    CGFloat textLeadingMargin = 4.0;
    CGFloat textWidth  = titleWidth - textLeadingMargin - imageLeadingMagin - imageLength;
    CGFloat textHeight = titleHeight;
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(imageLeadingMagin + imageLength + textLeadingMargin, 0, textWidth, textHeight)];
    searchText.text = @"搜索商品";
    searchText.font = [UIFont systemFontOfSize:16.0];
    searchText.textColor = [UIColor grayColor];
    [bgView addSubview:searchText];
    

    UIButton *maskBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleHeight)];
    maskBtn.backgroundColor = [UIColor clearColor];
    [maskBtn addTarget:self action:@selector(showProductSearchView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:maskBtn];
    
    self.navigationItem.titleView = bgView;
}

- (void)initNaviBackGroundImage:(BOOL)flag {
    UIImage *image = flag ? UIImageWithName(@"navi_background") : nil;
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)initTableView {
    if (@available(iOS 11.0, *)) {
    }
    else {
        _table.transform = CGAffineTransformTranslate(_table.transform, 0, 64);
    }
    
    _table.estimatedRowHeight = 100;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadServerData];
    }];
    
    banner = [[BannerView alloc] initWithFrame:CGRectMake(0, -44, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 20)];
    banner.delegate = self;
//    _table.tableHeaderView = banner;
    
    [_table registerNib:[UINib nibWithNibName:@"CollectionTableViewCell" bundle:nil] forCellReuseIdentifier:COLLECTION_CELL_ID];
//    [_table registerNib:[UINib nibWithNibName:@"PromotionTableViewCell" bundle:nil] forCellReuseIdentifier:RECOMMEND_CELL_ID];
    [_table registerNib:[UINib nibWithNibName:@"ScrollTableViewCell" bundle:nil] forCellReuseIdentifier:SCROLL_CELL_ID];
    [_table registerNib:[UINib nibWithNibName:@"CategoryTableViewCell" bundle:nil] forCellReuseIdentifier:CATEGORY_CELL_ID];
}

- (void)naviLeftBarItemPressed {
    [self showProductSearchView];
}

- (void)showProductSearchView {
    if (searchView == nil) {
        searchView = [HeaderSearchView new];
        searchView.delegate = self;
    }
    [searchView showWithTitles:hotKeyList];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)naviRightBarItemPressed {
    self.tabBarController.selectedIndex = 3;
}

- (void)loadServerData {
    [self getTopBannerAdList];      //获取顶部滚动广告
//    [self getFuncBtnCategory];      //获取第二列4个按钮分类
////    [self getPromotionList];        //获取促销列表（礼包后面上下滚动部分）
//    [self getHotspotAdList];        //获取热点广告（scroll视图部分）
//    [self getProductCategoryList];  //底部分类产品
//    [self getHotSearchKeywords];    //获取热搜关键词
}

//根据所有网络请求是否已完成来刷新table数据
- (void)reloadTableIfFinished {
    [_table reloadData];
    [_table.mj_header endRefreshing];
}

//MARK: 各种Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 + [categoryList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return nil;
    }
    
    //产品分类标题
    return [self getCategoryHeaderView:(section - 2)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return 0.01;
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLLECTION_CELL_ID forIndexPath:indexPath];
        cell.delegate = self;
        [cell setupWithCategoryList:btnCateList];
        return cell;
    }
//    else if (section == 1) {
//        PromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECOMMEND_CELL_ID forIndexPath:indexPath];
//        cell.delegate = self;
//        [cell showPromotionList:promotionList];
//
//        return cell;
//    }
    else if (section == 1) {
        ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SCROLL_CELL_ID forIndexPath:indexPath];
        cell.delegate = self;
        [cell setupByAdList:hotspotAdList];
        
        return cell;
    }
    else {
        CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CATEGORY_CELL_ID forIndexPath:indexPath];
        cell.delegate = self;
        NSInteger section = indexPath.section;
        NSInteger index = section - 2;
        CategoryInfo *category = [categoryList objectAtIndex:index];
        [cell setupByCategory:category];
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)getCategoryHeaderView: (NSInteger)index {
    CGFloat headHeight = 40;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headHeight)];
    header.backgroundColor = [UIColor whiteColor];
    
    //薯条
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, headHeight)];
    bar.backgroundColor = [colorList objectAtIndex:index];
    [header addSubview:bar];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 200, headHeight)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = [colorList objectAtIndex:index];
    [header addSubview:titleLabel];
    
    CategoryInfo *category = [categoryList objectAtIndex:index];
    titleLabel.text = category.name;
    
    [header addSubview:titleLabel];
    
    return header;
}

//HeaderSearchViewDelegate
- (void)productSearch:(NSString *)keyStr {
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.searchKey = keyStr;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)searchHeaderDismissed {
    self.navigationController.navigationBar.hidden = NO;
}

//打开广告详情界面
- (void)selectAdWithId: (AdInfo *)adInfo {
    switch (adInfo.type) {
        case 1:
            [self getAdArticalWithId:adInfo.articleId];
            break;
            
        case 2:
            [self selectProductWithID:adInfo.articleId];
            break;
            
        case 3:
            [self openCategoryWithID:adInfo.articleId];
            break;
            
        default:
            break;
    }
}

//促销部分点击回调
- (void)selectPromotionWithId: (NSString *)promotionId {
    //打开促销产品列表视图
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.promotionId = promotionId;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

//产品列表回调
- (void)selectProductWithID:(NSString *)productId {
    //打开产品详情界面
    ProductDetailViewController *productVC = [ProductDetailViewController new];
    productVC.productId = productId;
    productVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productVC animated:YES];
}

//MARK: CollectionFuncDelegate
//打开商品分类
- (void)openCategoryVC {
    self.tabBarController.selectedIndex = 1;
}

//打开积分乐园
- (void)openCreditPark {
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.categoryId = CREDIT_PARK_CATEGORY_ID;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

//打开充值中心
- (void)openChargeCenter {
    self.hidesBottomBarWhenPushed = YES;
//    ChargeCenterViewController *chargeVC = [ChargeCenterViewController new];
    ChargeWebViewController *chargeVC = [ChargeWebViewController new];
    [self.navigationController pushViewController:chargeVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

//打开会员中心
- (void)openMemberCenter {
    self.tabBarController.selectedIndex = 3;
}

//打开分类界面
- (void)openCategoryWithID:(NSString *)categoryID {
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.categoryId = categoryID;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

//打开金木之家
- (void)openJinMuFamily {
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.inJinMuMode = YES;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

//打开直邮到家界面  通过productType获取列表
- (void)openZhiyouProductList {
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.inZhiyouMode = YES;
    listVC.productType = ProductType_Deliver;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)openHotSellingProducts {
    ProductListViewController *listVC = [ProductListViewController new];
    listVC.inHotSelling = YES;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)showTableBanner {
    _table.tableHeaderView = banner;
}

- (void)hideTableBanner {
    _table.tableHeaderView = nil;
}

//MARK: 服务端请求
//获取搜索热词
- (void)getHotSearchKeywords {
    GetHotSearchRequest *request = [GetHotSearchRequest new];
    [request excuteRequst:^(Boolean isOK, NSArray * _Nullable list, NSString * _Nullable errorMsg) {
        hotKeyList = list;
    }];
}

//获取顶部滚动广告列表
- (void)getTopBannerAdList {
    GetBannerAdsRequest *request = [GetBannerAdsRequest new];
    request.adPosition = AdPostion_Banner;
    [request excuteRequest:^(BOOL isOK, GetBannerAdsResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            bannerAdList = [response.list copy];
//            bannerAdList = [NSArray new];
            if (!bannerAdList || [bannerAdList count] == 0) {
                [self hideTableBanner];
            }
            else {
                [self showTableBanner];
                [banner showViewWithBanners:response.list];
            }
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"内容获取失败，下拉刷新一下~"];
        }
        
        //ZC_DEBUG
        [self getFuncBtnCategory];      //获取第二列4个按钮分类
    }];
}

//获取促销列表
- (void)getPromotionList {
    getPromotionsDone = NO;
    GetPromotionRequest *request = [GetPromotionRequest new];
    [request excuteRequest:^(BOOL isOK, GetPromotionResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            promotionList = [response.list copy];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"内容获取失败，下拉刷新一下~"];
        }
        getPromotionsDone = YES;
        [self reloadTableIfFinished];
    }];
}

//获取功能区下边4个按钮的分类
- (void)getFuncBtnCategory {
    getBtnCategoryDone = NO;
    GetFuncCategoryRequest *request = [GetFuncCategoryRequest new];
    [request excuteRequest:^(BOOL isOK, GetCategoryResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            btnCateList = response.list;
            [_table reloadData];
        }
        getBtnCategoryDone = YES;
        
        //ZC_DEBUG
        [self getHotspotAdList];        //获取热点广告（scroll视图部分）
    }];
}

//获取中间热点广告
- (void)getHotspotAdList {
    getHotpotAdsDone = NO;
    GetBannerAdsRequest *request = [GetBannerAdsRequest new];
    request.adPosition = AdPostion_Hotspot;
    [request excuteRequest:^(BOOL isOK, GetBannerAdsResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            hotspotAdList = [response.list copy];
            [_table reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"内容获取失败，下拉刷新一下~"];
        }
        getHotpotAdsDone = YES;
        
        //ZC_DEBUG
        [self getProductCategoryList];  //底部分类产品
    }];
}

//获取商品分类列表
- (void)getProductCategoryList {
    getCategoriesDone = NO;
    GetHomeCategoryRequest *request = [GetHomeCategoryRequest new];
    [request excuteRequest:^(BOOL isOK, GetCategoryResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            categoryList = [response.list copy];
            [_table reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"内容获取失败，下拉刷新一下~"];
        }
        getCategoriesDone = YES;
        [self reloadTableIfFinished];
        
        //ZC_DEBUG
        [self getHotSearchKeywords];    //获取热搜关键词
    }];
}

//获取文章内容
- (void)getAdArticalWithId:(NSString *)artId {
    if (STRING_NULL(artId)) {
        [SVProgressHUD showErrorWithStatus:@"传入参数错误"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    GetArticalDetailRequest *request = [GetArticalDetailRequest new];
    request.articleId = artId;
    [request excuteRequest:^(BOOL isOK, ArticalInfo * _Nullable artical, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            AdvertisementViewController *advertiseVC = [AdvertisementViewController new];
            advertiseVC.artical = artical;
            [self.navigationController pushViewController:advertiseVC animated:YES];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"文章暂时走丢了。"];
        }
    }];
}

//检测是否需要升级版本
- (void)checkVersionUpdate {
    CheckVersionRequest *request = [CheckVersionRequest new];
    request.version_code = [Util getAppVersion];
    [request excuteRequst:^(Boolean isOK, CheckVersionResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            if (response.is_need_update) {
                //TODO: 打开appstore应用url
            }
         }
        else {
        }
    }];
}

@end
