//
//  ProductListViewController.h
//  weidong
//
//  Created by zhccc on 2017/10/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CategoryInfo.h"

@interface ProductListViewController : UIViewController

@property(nonatomic, copy)NSString *searchKey;
@property(nonatomic, weak)CategoryInfo *category;
@property(nonatomic, copy)NSString *categoryId;
@property(nonatomic, copy)NSString *promotionId;
@property(nonatomic, assign)BOOL inZhiyouMode;
@property(nonatomic, assign)BOOL inHotSelling;
@property(nonatomic, assign)NSInteger productType;

@end
