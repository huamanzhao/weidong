//
//  SelfInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/31.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfInfo : NSObject
@property(nonatomic, copy)NSString *username; //用户登录名
@property(nonatomic, copy)NSString *password; //密码      
@property(nonatomic, copy)NSString *email;    //用户邮箱
@property(nonatomic, copy)NSString *mobile;   //手机
@property(nonatomic, copy)NSString *nickname; //昵称
@property(nonatomic, copy)NSString *name;     //用户姓名
@property(nonatomic, copy)NSString *idNumber; //用户身份证号
@property(nonatomic, copy)NSString *memberAttribute_1;  //真实姓名
@property(nonatomic, copy)NSString *memberAttribute_51; //身份证号
@property(nonatomic, assign)NSInteger gender;   //性别 0-男 1-女
@property(nonatomic, copy)NSString *phone;    //电话
@property(nonatomic, assign)BOOL isVerify;    //是否已验证

+ (NSDictionary *)localSelfInfoDic;
+ (SelfInfo *)localSelfInfo;
+ (void)clearLocalInfo;
- (void)recordToLocal;
@end
