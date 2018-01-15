//
//  PayManager.h
//  weidong
//
//  Created by zhccc on 2018/1/4.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

@protocol PayManagerDelegate <NSObject>
- (void)paySucceed;
- (void)payFailed:(NSString *)reason;
- (void)payCanceled;
@end


@interface PayManager : NSObject <WXApiDelegate>
@property(nonatomic, retain) id<PayManagerDelegate> delegate;

- (void)payRequest;
@end
