//
//  EgouCardDepositRequest.h
//  weidong
//
//  Created by zhccc on 2017/12/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface EgouCardDepositRequest : RequestBase

@property(nonatomic, copy)NSString *cardNo;
@property(nonatomic, copy)NSString *cardPassword;
@property(nonatomic, copy)NSString *cardValue;
@property(nonatomic, copy)NSString *transactionId;


- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * _Nullable errorMsg))complete;

@end
