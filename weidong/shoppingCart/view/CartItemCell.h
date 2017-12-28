//
//  CartItemCell.h
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartItemInfo.h"

#define CART_CELLID @"CartItemCellIdentifier"

@protocol CartItemDelegate <NSObject>
- (void)cartModified:(CartItemInfo *)cartInfo;
- (void)cartRemoved:(CartItemInfo *)cartInfo;
@end

@interface CartItemCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *quantityTF;
@property (nonatomic, weak) id<CartItemDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteBtnWidthCS;

- (void)setupWithCartInfo:(CartItemInfo *)cartInfo InEdit:(BOOL)inEdit;

@end
