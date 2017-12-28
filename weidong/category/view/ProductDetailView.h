//
//  ProductDetailView.h
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"
#import "ProductMainView.h"

@interface ProductDetailView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (nonatomic, weak) id<ProductDetailRefreshDelegate> delegate;

- (void)setupWithProductDetail:(ProductDetail *)detail;
@end
