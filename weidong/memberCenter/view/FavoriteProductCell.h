//
//  FavoriteProductCell.h
//  weidong
//
//  Created by zhccc on 2017/11/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteProductInfo.h"

#define FAVORITE_CELLID @"favoriteIdenfier"

@protocol FavoriteProductCellDelegate <NSObject>
- (void)removeProductWithId:(NSString *)favoriteId;
@end

@interface FavoriteProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@property (nonatomic, weak) id<FavoriteProductCellDelegate> delegate;

- (void)setupWithFavoriteProduct:(FavoriteProductInfo *)favorite;
@end
