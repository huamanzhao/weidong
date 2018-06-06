//
//  EgouCardBDepositRequest.h
//  weidong
//
//  Created by zhccc on 2018/6/6.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "RequestBase.h"

@interface EgouCardBDepositRequest : RequestBase
@property(nonatomic, copy)NSString *cardNo;
@property(nonatomic, copy)NSString *cardPassword;
@property(nonatomic, copy)NSString *cardValue;
@property(nonatomic, copy)NSString *transactionId;


- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * _Nullable url, NSString * _Nullable errorMsg))complete;
@end
