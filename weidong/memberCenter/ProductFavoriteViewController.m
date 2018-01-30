//
//  ProductFavoriteViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductFavoriteViewController.h"
#import "ProductFavoriteListViewController.h"

@interface ProductFavoriteViewController () <VTMagicViewDataSource, VTMagicViewDelegate>

@end

@implementation ProductFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品收藏";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.sliderColor = POSITIVE_COLOR;
    self.magicView.layoutStyle = VTLayoutStyleDivide;
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

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return @[@"默认", @"降价", @"促销", @"分类", @"库存"];
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
    ProductFavoriteListViewController *listVC = [magicView dequeueReusablePageWithIdentifier:listId];
    if (!listVC) {
        listVC = [ProductFavoriteListViewController new];
    }
    
    return listVC;
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}

@end
