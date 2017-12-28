//
//  VerifyCodeView.h
//  weidong
//
//  Created by zhccc on 2017/10/7.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerifiCodeDelegate <NSObject>

- (void)needChangeVerifyCode;

@end

@interface VerifyCodeView : UIView

@property(nonatomic, weak) id<VerifiCodeDelegate> delegate;

- (void)setupWithCode: (NSString *)verifyCode;

@end
