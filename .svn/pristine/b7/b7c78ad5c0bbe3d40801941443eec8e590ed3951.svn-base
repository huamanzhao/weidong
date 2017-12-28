//
//  AddressItemCell.h
//  weidong
//
//  Created by zhccc on 2017/11/20.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliverAddressInfo.h"
#define ADDRESS_CELLID @"AddressCellIdentifier"

@protocol AddressItemDelegate <NSObject>
- (void)editAddressInfo:(DeliverAddressInfo *)address;
- (void)deleteAddressInfo:(NSString *)addressId;
@end

@interface AddressItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, weak) id<AddressItemDelegate> delegate;

- (void)setupWithAddressInfo:(DeliverAddressInfo *)addrInfo;
@end
