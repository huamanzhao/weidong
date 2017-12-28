//
//  ProductSpecificationView.h
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"

@protocol ProductSpecificationDelegate <NSObject>
- (void)closeSpecView;
@end

@interface ProductSpecificationView : UIView <UITextFieldDelegate>
@property(nonatomic, weak) id<ProductSpecificationDelegate> delegate;

- (void)setupWithProduct:(ProductDetail *)productDetail;
@end
