//
//  ProductCommentsView.h
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductMainView.h"

@interface ProductCommentsView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, weak) id<ProductDetailRefreshDelegate> delegate;

- (void)reloadTableDataWith:(NSArray *)comments;
@end
