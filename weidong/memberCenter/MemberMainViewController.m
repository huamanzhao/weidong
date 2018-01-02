//
//  MemberMainViewController.m
//  weidong
//
//  Created by zhccc on 2017/9/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MemberMainViewController.h"
#import "LoginViewController.h"
#import "MemberHeaderView.h"
#import "MemberFunctionView.h"
#import "MemberTableSectionView.h"
#import "MemberOrderCell.h"
//#import "MemberMessageCell.h"
#import "MemberToolsCell.h"
#import "MemberToolsCell.h"
#import "MemberLogoutCell.h"
#import "LogoutRequest.h"
#import "GetMemberInfoRequest.h"
#import "ChangePswdViewController.h"
#import "ProductFavoriteViewController.h"
#import "MyOrdersViewController.h"
#import "MyCreditsLogViewController.h"
#import "AddressListViewController.h"
#import "PersonalInfoViewController.h"
#import "ChargeCenterViewController.h"
#import "OrderWebViewController.h"
#import "ArrivalNoticeListViewController.h"
#import "CommentListViewController.h"
#import "ConsulationListViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "ProductFavoriteListViewController.h"
#import "OrderListViewController.h"
#import "CouponListViewController.h"
#import "MemberTitleView.h"
#import "ChargeWebViewController.h"
#import "ModifyPayPasswordViewController.h"

@interface MemberMainViewController () <UITableViewDelegate, UITableViewDataSource, MemberToolsDelegate, MemberLogoutDelegate, MemberTableSectionDelegate, MemberOrderDelegate, MemberFunctionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MemberMainViewController {
//    UITableView *table;
    UIView *tableHeader;
    MemberTitleView *headerView;
    MemberFunctionView *functionView;
    MemberLoginInfo *memInfo;
    SelfInfo *selfInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStatusBarBGColor];
    [self setTintColor:ZHAO_BLUE];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;

    self.title = @"会员中心";
    
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![Util userIsLogin] ) {
        [self openLoginController];
        return;
    }

    [self getMemberInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 界面初始化
- (void)initTableView {
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100;
    _table.tableFooterView = nil;
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getMemberInfo];
    }];
    
    //Table的顶部试图
    tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.2 + 48)];
    tableHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _table.tableHeaderView = tableHeader;
    
    //1. 用户头像昵称视图
    headerView = [[MemberTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
    //2. 4个功能按钮：商品收藏、到货通知、……
    functionView = [[MemberFunctionView alloc] initFuncViewFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_WIDTH * 0.2 + 8)];
    functionView.delegate = self;
    [tableHeader addSubview:headerView];
    [tableHeader addSubview:functionView];
    
    [_table registerNib:[UINib nibWithNibName:@"MemberOrderCell" bundle:nil] forCellReuseIdentifier:ORDER_CELLID];
//    [_table registerNib:[UINib nibWithNibName:@"MemberMessageCell" bundle:nil] forCellReuseIdentifier:MESSAGE_CELLID];
    [_table registerNib:[UINib nibWithNibName:@"MemberToolsCell" bundle:nil] forCellReuseIdentifier:TOOLS_CELLID];
    [_table registerNib:[UINib nibWithNibName:@"MemberLogoutCell" bundle:nil] forCellReuseIdentifier:LOGOUT_CELLID];
}

- (void)openLoginController {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)setupViewWithMemberInfo:(MemberLoginInfo *)memberInfo {
    memInfo = memberInfo;
    
    [self.table reloadData];
    [headerView setupWithUserName:[Util getUserName] Ranking:memberInfo.memberRankName];
    [functionView setupBadgeWithFavorite:memInfo.productFavoriteCount
                                Delivery:memInfo.productNotifyCount
                                 Comment:memInfo.reviewCount
                                 Consult:memInfo.consultationCount];
}

#pragma mark - 获取服务端数据
- (void)getMemberInfo {
    GetMemberInfoRequest *request = [GetMemberInfoRequest new];
    [request excuteRequest:^(BOOL isOK, MemberLoginInfo * _Nullable memberInfo, NSString * _Nullable errorMsg) {
        if (isOK) {
            [self setupViewWithMemberInfo:memberInfo];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"获取个人信息失败"];
        }
        [_table.mj_header endRefreshing];
        
        
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 || section == 3|| section == 4) { //设置、个人资料只有sectionHeader 没有cell
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section <= 1) {
        return 36;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MemberTableSectionView *sectionView = [MemberTableSectionView new];
    sectionView.delegate = self;
    switch (section) {
        case 0: //我的订单
            [sectionView setupWithTitle:MEMBER_MY_ORDER Image:@"icon_order" Subtitle:@"查看全部订单" TintColor:COLOR_0];
            break;
            
        case 1:
//            [sectionView setupWithTitle:@"消息盒子" Image:@"icon_message" Subtitle:@"" TintColor:COLOR_1];
//            break;
            
//        case 2:
            [sectionView setupWithTitle:@"必备工具" Image:@"icon_tools" Subtitle:@"" TintColor:COLOR_2];
            break;
            
        case 2: //设置
            [sectionView setupWithTitle:MEMBER_SETTINGS Image:@"icon_settings" Subtitle:@"收货地址管理" TintColor:nil];
            break;
            
        case 3: //个人资料
            [sectionView setupWithTitle:MEMBER_PERSONAL Image:@"icon_personal" Subtitle:@"个人账户管理" TintColor:nil];
            break;
            
        case 4: //修改密码
            [sectionView setupWithTitle:MEMBER_CHANGEPSW Image:@"icon_password" Subtitle:@"修改密码" TintColor:nil];
            break;
            
        case 5: //修改支付密码
            [sectionView setupWithTitle:MEMBER_CHANGEPAYPSW Image:@"icon_password" Subtitle:@"修改支付密码" TintColor:nil];
            break;
            
        default:
            break;
    }
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0: {
            MemberOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDER_CELLID forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
            break;
        }
        case 1: {
//            MemberMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MESSAGE_CELLID forIndexPath:indexPath];
//            return cell;
//            break;
//        }
//        case 2: {
            MemberToolsCell *cell = [tableView dequeueReusableCellWithIdentifier:TOOLS_CELLID forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
            break;
        }
        case 5: {
            MemberLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:LOGOUT_CELLID forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
            break;
        }
            
        default:{
            return nil;
        }
    }
}


#pragma mark - 自定义控件Delegate
//打开全部订单
- (void)showMoreOrders {
    OrderWebViewController *orderVC = [OrderWebViewController new];
//    OrderListViewController *orderVC = [OrderListViewController new];
    orderVC.orderType = OrderType_Init;
    orderVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)showMyCredits {
    MyCreditsLogViewController *creditsVC = [MyCreditsLogViewController new];
    creditsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creditsVC animated:YES];
}

- (void)chargeWeidongCoin {
//    ChargeCenterViewController *chargeVC = [ChargeCenterViewController new];
    ChargeWebViewController *chargeVC = [ChargeWebViewController new];
    chargeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chargeVC animated:YES];
}

- (void)showMyWeidongCoins {
    MyCreditsLogViewController *creditsVC = [MyCreditsLogViewController new];
    creditsVC.showCoinLog = YES;
    creditsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creditsVC animated:YES];
}

- (void)showMyCoupons {
    CouponListViewController *couponVC = [CouponListViewController new];
    couponVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:couponVC animated:YES];
}

//管理收货地址
- (void)manageDeliveryAddress {
    AddressListViewController *addressVC = [AddressListViewController new];
    addressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addressVC animated:YES];
}

//个人账户管理
- (void)managePersonalInfo {
    PersonalInfoViewController *personalVC = [PersonalInfoViewController new];
    [self.navigationController pushViewController:personalVC animated:YES];
}

//显示指定类型订单列表
- (void)showOrderListWithType:(OrderListType)type {
    OrderWebViewController *orderVC = [OrderWebViewController new];
    orderVC.orderType = type;
    orderVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)showFavoriteProducts {
//    ProductFavoriteViewController *favoriteVC = [ProductFavoriteViewController new];
    ProductFavoriteListViewController *favoriteVC = [ProductFavoriteListViewController new];
    favoriteVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:favoriteVC animated:YES];
}

- (void)showArrivalNotications {
    ArrivalNoticeListViewController *arrivalVC = [ArrivalNoticeListViewController new];
    arrivalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:arrivalVC animated:YES];
}

- (void)showProductComments {
    CommentListViewController *commentVC = [CommentListViewController new];
    commentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)showProductConsults {
    ConsulationListViewController *consultVC = [ConsulationListViewController new];
    consultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:consultVC animated:YES];
}

- (void)changePassword {
    ChangePswdViewController *changeVC = [ChangePswdViewController new];
    changeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (void)changePayPassword {
    ModifyPayPasswordViewController *changeVC = [ModifyPayPasswordViewController new];
    changeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (void)logoutAction {
    [SVProgressHUD showWithStatus:@"正在退出"];
    LogoutRequest *request = [LogoutRequest new];
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"退出成功"];
            
            [Util clearLoginInfo];
            [self openLoginController];
        }
        else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"退出失败：%@", errorMsg]];
        }
    }];
}

@end

