//
//  ProductMainView.h
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"
#import <MJRefresh/MJRefresh.h>

@protocol ProductDetailRefreshDelegate <NSObject>
- (void)showProductSpecifications;
- (void)refreshProductInfo;
- (void)showProductDetail;
- (void)showProductHome;
- (void)showProductComments;
- (void)showProductConsults;
@end


@interface ProductMainView : UIView <UIScrollViewDelegate>

@property(nonatomic, weak) id<ProductDetailRefreshDelegate> delegate;

- (void)setupWithProduct:(ProductDetail *)detail;
@end
