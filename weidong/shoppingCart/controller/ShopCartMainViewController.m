//
//  ShopCartMainViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/11.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ShopCartMainViewController.h"
#import <VTMagic/VTMagic.h>
#import "CartTypeInfo.h"
#import "CartItemInfo.h"
#import "GetCartListRequest.h"
#import "UpdateCardInfoRequest.h"
#import "DeleteCartInfoRequest.h"
#import "ClearCartsRequest.h"
#import "ShopCartListViewController.h"
#import "CartItemCell.h"
#import "LoginViewController.h"
#import "ShopCartPayViewController.h"
#import "RealNameVerifyViewController.h"

@interface ShopCartMainViewController () <VTMagicViewDataSource, VTMagicViewDelegate, CartItemDelegate>
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (strong, nonatomic) VTMagicController *magicController;
@end

@implementation ShopCartMainViewController {
    NSMutableArray *cartTypeList;
    NSMutableArray *titleList;
    
    NSInteger selectPage;
    BOOL inEdit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    [self initNaviRightImage:@"btn_edit"];
    
    [self addChildViewController:self.magicController];
    [self.displayView addSubview:_magicController.view];
    [_magicController didMoveToParentViewController:self];
    
    selectPage = 0;
    inEdit = NO;
    
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    cartTypeList = [NSMutableArray new];
    titleList = [NSMutableArray new];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    
    [self getCartList];
}

- (void)naviRightBarItemPressed {
    inEdit = !inEdit;
    if (inEdit) {
        [self initNaviRightTitle:@"完成"];
    }
    else {
        [self initNaviRightImage:@"btn_edit"];
    }
    
    [_magicController.magicView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubviews {
    _clearBtn.backgroundColor = NEGATIVE_COLOR;
    _payBtn.backgroundColor = ZHAO_BLUE;
}

- (void)getCartList {
    if ([Util userIsLogin]) {
        [self getServerCartList];
    }
    else {
        [self getLocalCartList];
    }
}

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = ZHAO_BLUE;
        _magicController.magicView.sliderWidth = 100;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    
    return _magicController;
}

- (void)getLocalCartList {
    cartTypeList = [NSMutableArray new];
    titleList = [NSMutableArray new];
    
    //获取所有的
    NSArray *cartList = [CartItemInfo getLocalCartList];
    
    NSMutableArray *dmList = [NSMutableArray new];  //大贸
    float dmTotal = 0.0;    //总价
    NSMutableArray *zyList = [NSMutableArray new];  //直邮
    float zyTotal = 0.0;
    NSMutableArray *bsList = [NSMutableArray new];  //保税
    float bsTotal = 0.0;
    
    for (CartItemInfo *cart in cartList) {
        if (cart.productType == ProductType_Trade) {
            [dmList addObject:cart];
            dmTotal += [cart.price floatValue] * cart.quantity;
        }
        else if (cart.productType == ProductType_Bonded) {
            [bsList addObject:cart];
            bsTotal += [cart.price floatValue] * cart.quantity;
        }
        else if (cart.productType == ProductType_Deliver) {
            [zyList addObject:cart];
            zyTotal += [cart.price floatValue] * cart.quantity;
        }
    }
    
    if ([dmList count]) {
        CartTypeInfo *info = [CartTypeInfo new];
        info.effectivePrice = [NSString stringWithFormat:@"%.2f", dmTotal];
        info.list = [dmList copy];
        
        [cartTypeList addObject:info];
        [titleList addObject:@"优选"];
    }
    if ([zyList count]) {
        CartTypeInfo *info = [CartTypeInfo new];
        info.effectivePrice = [NSString stringWithFormat:@"%.2f", zyTotal];
        info.list = [zyList copy];
        
        [cartTypeList addObject:info];
        [titleList addObject:@"直邮"];
    }
    if ([bsList count]) {
        CartTypeInfo *info = [CartTypeInfo new];
        info.effectivePrice = [NSString stringWithFormat:@"%.2f", bsTotal];
        info.list = [bsList copy];
        
        [cartTypeList addObject:info];
        [titleList addObject:@"保税"];
    }
    
    [self handleCartList];
}

- (void)getServerCartList {
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    GetCartListRequest *request = [GetCartListRequest new];
    [request excuteRequest:^(BOOL isOK, GetCartListResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        cartTypeList = [NSMutableArray new];
        titleList = [NSMutableArray new];
        
        if (isOK) {
            if ([response.dmDetail.list count]) {
                [cartTypeList addObject:response.dmDetail];
                [titleList addObject:@"优选"];
            }
            if ([response.zyDetail.list count]) {
                [cartTypeList addObject:response.zyDetail];
                [titleList addObject:@"直邮"];
            }
            if ([response.bsDetail.list count]) {
                [cartTypeList addObject:response.bsDetail];
                [titleList addObject:@"保税"];
            }
        }
        
        [self handleCartList];
    }];
}



- (void)handleCartList {
    if ([cartTypeList count]) { //有数据
        [_displayView setHidden:NO];
        [_bottomView setHidden:NO];
        [self.view bringSubviewToFront:_bottomView];
        
        [_magicController.magicView reloadData];
        [self updateTotalPrice];
    }
    else {  //没有数据
        [_displayView setHidden:YES];
        [_bottomView setHidden:YES];
    }
}

- (void)updateTotalPrice {
    if (cartTypeList && [cartTypeList count] > selectPage) {
        CartTypeInfo *info = [cartTypeList objectAtIndex:selectPage];
        _totalLabel.text = [NSString stringWithFormat:@"￥%.2f", [info.effectivePrice floatValue]];
    }
}

- (IBAction)clearBtnPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要清空当前购物车吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self clearCurrentCart];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)payBtnPressed:(id)sender {
    if (![Util userIsLogin]) {  //1. 如果未登录，提示用户登录
        [SVProgressHUD showInfoWithStatus:@"请登录后再进行支付"];
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(openLoginVC) userInfo:nil repeats:NO];
        return;
    }
    
    //2. 已登录，未实名认证，且所选类型为直邮、保税的时候，不能进入支付界面
    if ([self getCurrentProductType] != ProductType_Trade && ![Util userIsVerified]) {
        [self showVerifyAlert];
        return;
    }
    
    //已登录，打开支付界面；
    [self openPaymentVC];
}

- (void)openLoginVC {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)openPaymentVC {
    ShopCartPayViewController *payVC = [ShopCartPayViewController new];
    payVC.productType = [self getCurrentProductType];
    payVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:payVC animated:YES];
}

//MARK: VTMagic Delegate
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *itemBtn = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!itemBtn) {
        itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [itemBtn setTitleColor:ZHAO_BLUE forState:UIControlStateSelected];
        itemBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    return itemBtn;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *listId = @"cartListIdentifier";
    
    ShopCartListViewController *listController = [magicView dequeueReusablePageWithIdentifier:listId];
    if (!listController) {
        listController = [ShopCartListViewController new];
        listController.delegate = self;
    }
    CartTypeInfo *cart = [cartTypeList objectAtIndex:pageIndex];
    [listController reloadWithCart:cart inEditMode:inEdit];
    
    return listController;
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    selectPage = pageIndex;
    [self updateTotalPrice];
}

//MARK: CartItemCellDelegate
- (void)cartModified:(CartItemInfo *)cartInfo {
    if ([Util userIsLogin]) { //更新服务端
        [SVProgressHUD showWithStatus:@"正在同步"];
        UpdateCardInfoRequest *request = [UpdateCardInfoRequest new];
        request.skuId = cartInfo.skuId;
        request.quantity = cartInfo.quantity;
        [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
            if (isOK) {
                [self getCartList];
            }
            [SVProgressHUD dismiss];
        }];
    }
    else {  //更新本地
        [cartInfo updateLocalRecord];
        [self getCartList];
    }
}

- (void)cartRemoved:(CartItemInfo *)cartInfo {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要移除此商品吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self confirmToRemoveCart:cartInfo];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)confirmToRemoveCart:(CartItemInfo *)cartInfo {
    if ([Util userIsLogin]) { //更新服务端
        [SVProgressHUD showWithStatus:@"正在移除"];
        DeleteCartInfoRequest *request = [DeleteCartInfoRequest new];
        request.skuId = cartInfo.skuId;
        [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
            if (isOK) {
                [self getCartList];
            }
            [SVProgressHUD dismiss];
        }];
    }
    else {  //更新本地
        [cartInfo removeLocalRecord];
        [self getCartList];
    }
}

//TODO: 是清空所有购物车，还是只清空当前类型的购物车？
- (void)clearCurrentCart {
    if ([Util userIsLogin]) {   //清空服务端购物车
        [SVProgressHUD showWithStatus:@"正在清空"];
        ClearCartsRequest *request = [ClearCartsRequest new];
        request.productType = [self getCurrentProductType];
        [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
            [self getCartList];
        }];
    }
    else {  //清空本地购物车
        CartTypeInfo *cartTypeInfo = [cartTypeList objectAtIndex:selectPage];
        for (CartItemInfo *itemInfo in cartTypeInfo.list) {
            [itemInfo removeLocalRecord];
        }
        [self getCartList];
    }
}

- (ProductCategory)getCurrentProductType {
    if (!titleList || [titleList count] == 0) {
        return ProductType_Init;
    }
    
    NSString *title = [titleList objectAtIndex:selectPage];
    if ([title isEqualToString:@"优选"]) {
        return ProductType_Trade;
    }
    if ([title isEqualToString:@"直邮"]) {
        return ProductType_Deliver;
    }
    if ([title isEqualToString:@"保税"]) {
        return ProductType_Trade;
    }
    
    return ProductType_Init;
}

- (void)showVerifyAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未实名验证" message:@"根据相关法律政策，您通过实名认证后才能购买直邮、保税商品。现在是否进行实名认证？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"现在认证" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self openVerifyVC];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"以后再说" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)openVerifyVC {
    RealNameVerifyViewController *verifyVC = [RealNameVerifyViewController new];
    verifyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:verifyVC animated:YES];
}

@end
