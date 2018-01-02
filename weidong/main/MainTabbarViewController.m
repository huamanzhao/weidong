//
//  MainTabbarViewController.m
//  weidong
//
//  Created by zhccc on 2017/9/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "HomePageViewController.h"
#import "CategoryMainViewController.h"
#import "ShopCartMainViewController.h"
#import "MemberMainViewController.h"
#import "ShopCartWebViewController.h"
#import "CartItemInfo.h"
#import "SelfInfo.h"
#import "GetSelfInfoRequest.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabbarControllers];
    
    [self handleAutoLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleAutoLogin {
    //如果设置了自动登录，则打开程序后执行自动登录
    if ([Util getAutoLoginState]) {
        [Util autoLogin:^(BOOL isOK) {
            if (!isOK) {
                return;
            }
            
            //更新个人信息
            [self updateSelfInfo];
            
            //是否有本地购物车
            NSArray *localCartList = [CartItemInfo getLocalCartList];
            if (!localCartList || [localCartList count] == 0) { //没有则返回
                return;
            }
            
            //有：上传本地购物车信息
            [self uploadLocalCart:localCartList];
        }];
    }
}

- (void)updateSelfInfo {
    GetSelfInfoRequest *request = [GetSelfInfoRequest new];
    [request excuteRequest:^(BOOL isOK, SelfInfo * _Nullable info, NSString * _Nullable errorMsg) {
        if (isOK) {
            [info recordToLocal];
        }
    }];
}

- (void)uploadLocalCart:(NSArray *)cartList{
    NSInteger count = [cartList count];
    for(NSInteger index = 0; index < count; index++) {
        CartItemInfo *info = [cartList objectAtIndex:index];
        [info uploadToServer:^(BOOL isOK) {
            if (isOK) { //上传成功，清空本地购物车信息；
                [info removeLocalRecord];
            }
        }];
    }
}

- (void)initTabbarControllers {
    HomePageViewController *homepageVC = [HomePageViewController new];
    homepageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:UIImageWithName(@"tabbar_home") selectedImage:UIImageWithName(@"tabbar_home_select")];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homepageVC];
    homeNavi.navigationBar.backgroundColor = [UIColor whiteColor];
    homeNavi.title = @"首页";
    
    CategoryMainViewController *categoryVC = [CategoryMainViewController new];
    categoryVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:UIImageWithName(@"tabbar_categery") selectedImage:UIImageWithName(@"tabbar_categery_select")];
    UINavigationController *categoryNavi = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    categoryNavi.navigationBar.backgroundColor = [UIColor whiteColor];
    categoryNavi.title = @"分类";
    
    ShopCartMainViewController *cartVC = [ShopCartMainViewController new];
//    ShopCartWebViewController *cartVC = [ShopCartWebViewController new];
    cartVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:UIImageWithName(@"tabbar_cart") selectedImage:UIImageWithName(@"tabbar_cart_select")];
    UINavigationController *cartNavi = [[UINavigationController alloc] initWithRootViewController:cartVC];
    cartNavi.navigationBar.backgroundColor = [UIColor whiteColor];
    cartNavi.title = @"购物车";
    
    MemberMainViewController *memberVC = [MemberMainViewController new];
    memberVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会员中心" image:UIImageWithName(@"tabbar_member") selectedImage:UIImageWithName(@"tarbar_member_select")];
    UINavigationController *memberNavi = [[UINavigationController alloc] initWithRootViewController:memberVC];
    memberNavi.navigationBar.backgroundColor = [UIColor whiteColor];
    memberNavi.title = @"会员中心";
    
    NSArray *controllers = @[homeNavi, categoryNavi, cartNavi, memberNavi];
    [self setViewControllers: controllers];
    
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

@end
