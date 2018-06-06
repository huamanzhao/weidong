//
//  EgouCardViewController.h
//  weidong
//
//  Created by zhccc on 2017/12/17.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LVKeyboardView.h"

@protocol EgouCardChargeDelegate <NSObject>
- (void)chargeSucceedWithURL:(NSString *)urlStr;
@end

@interface EgouCardViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) LVKeyboardView *keyboard;
@property (nonatomic, strong) NSMutableString *passWord;
@property (nonatomic, copy)NSDictionary *paramDic;

@property (nonatomic, weak) id<EgouCardChargeDelegate> delegate;
@property (nonatomic, assign)NSInteger type; //0-微动币充值  1-微豆充值

@end
