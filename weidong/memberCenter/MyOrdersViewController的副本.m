//
//  MyOrdersViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "OrderListViewController.h"

@interface MyOrdersViewController () <VTMagicViewDataSource, VTMagicViewDelegate>

@end

@implementation MyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"我的订单";
    [self initNaviBackButton];
    
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.sliderColor = POSITIVE_COLOR;
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.navigationHeight = 40.f;
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    
    [self.magicView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.magicView switchToPage:_orderType animated:YES];
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return @[@"全部", @"待付款", @"待发货", @"待收货", @"已完成"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:POSITIVE_COLOR forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    NSString *listId = @"listIdentifier";
    OrderListViewController *listVC = [magicView dequeueReusablePageWithIdentifier:listId];
    if (!listVC) {
        listVC = [OrderListViewController new];
    }
    
    return listVC;
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}

@end
