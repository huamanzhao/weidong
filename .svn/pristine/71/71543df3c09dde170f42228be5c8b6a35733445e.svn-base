//
//  CategoryTableViewCell.h
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryInfo.h"

#define CATEGORY_CELL_ID @"CategoryCellIdentifier"


@protocol CategoryCellDelegate <NSObject>
- (void)selectProductWithID:(NSString *)productId;
@end

@interface CategoryTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, weak) id<CategoryCellDelegate> delegate;

- (void)setupByCategory: (CategoryInfo *)category;

@end
