//
//  ConsultationInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultationInfo : NSObject
@property(nonatomic, copy)NSString *id;
@property(nonatomic, copy)NSString *content; //评论内容
@property(nonatomic, assign)NSInteger isShow;//是否显示
@property(nonatomic, copy)NSString *ip;      //IP
@property(nonatomic, copy)NSString *memberId;   //评论会员ID
@property(nonatomic, copy)NSString *memberName; //评论会员姓名
@property(nonatomic, copy)NSString *productId;
@property(nonatomic, copy)NSString *productName;
@property(nonatomic, copy)NSString *productSn;
@property(nonatomic, copy)NSString *productImage;
@property(nonatomic, copy)NSString *createdDate;//创建时间
@property(nonatomic, copy)NSArray *replyAppConsultations;
@end
