//
//  ShopCartListViewController.h
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTypeInfo.h"
#import "CartItemCell.h"

@interface ShopCartListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, weak) id<CartItemDelegate> delegate;

- (void)reloadWithCart:(CartTypeInfo *)cart inEditMode:(BOOL)inEdit;
@end
