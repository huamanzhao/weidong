//
//  ShopCartListViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ShopCartListViewController.h"

@interface ShopCartListViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ShopCartListViewController {
    CartTypeInfo *cartInfo;
    BOOL inEditMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    inEditMode = NO;
    _table.sectionHeaderHeight = 8;
    _table.sectionFooterHeight = 0;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100;
    [_table registerNib:[UINib nibWithNibName:@"CartItemCell" bundle:nil] forCellReuseIdentifier:CART_CELLID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadWithCart:(CartTypeInfo *)cart inEditMode:(BOOL)inEdit {
    cartInfo = cart;
    inEditMode = inEdit;
    
    [_table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!cartInfo) {
        return 0;
    }
    return [cartInfo.list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CART_CELLID forIndexPath:indexPath];
    cell.delegate = self.delegate;
    CartItemInfo *cart = [cartInfo.list objectAtIndex:indexPath.section];
    [cell setupWithCartInfo:cart InEdit:inEditMode];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
