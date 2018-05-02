//
//  RequestBase.m
//  GZDefence
//
//  Created by zhccc on 2017/8/19.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import "RequestBase.h"
#import <AFNetworking/AFNetworking.h>
#import "Util.h"

@implementation RequestBase {
    AFHTTPSessionManager *manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reqType = @"POST";
        self.timeoutInterval = 15;
        
        [self generateManager];
    }
    return self;
}

- (void)generateManager {
    manager = [AFHTTPSessionManager manager];
    
    //请求参数的格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];   //普通格式
    [manager.requestSerializer setTimeoutInterval:_timeoutInterval];
    
    //响应数据的格式
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
//    [NSSet setWithObject:@"application/json"];
    [manager setResponseSerializer:responseSerializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];//[AFHTTPResponseSerializer serializer]; //普通格式，返回data
}

- (void)generateParameterDic {
    self.paramDic = self.mj_keyValues;
}

//添加extend origin参数
//extend = AES(access_token,Date[yyyyMMddHHmmss],random)
//origin = I01/I02
- (void)addBasicParam {
    NSMutableArray *tempDic = [_paramDic mutableCopy];
    NSString *extend = [self getExtendParam];
    NSString *origin = [self getOriginParam];
    
    [tempDic setValue:extend forKey:@"extend"];
    [tempDic setValue:origin forKey:@"origin"];
    [tempDic setValue:nil forKey:@"reqType"];
    [tempDic setValue:nil forKey:@"timeoutInterval"];
    [tempDic setValue:nil forKey:@"urlString"];
    
    _paramDic = [tempDic copy];
}

- (void)doRequest:(void (^_Nonnull)(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg))complete {
    [self generateParameterDic];
    [self addBasicParam];
    
    if ([self.reqType isEqualToString: @"POST"]) {
        [manager POST:_urlString parameters:_paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            //获取进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSInteger result = [[responseObject valueForKey:@"result"] integerValue];
            NSString *desc = [responseObject valueForKey:@"desc"];
            if (result != 1) {
                complete(NO, responseObject, desc);
                return;
            }
            
            complete(YES, responseObject, desc);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败
            NSString *errorMsg = error.localizedDescription;
            if (error.code == -1 || error.code == 3840) {
                errorMsg = HTTP_ERRMSG_TIMEOUT;
            }
            if (error.code == -1009) {
                errorMsg = HTTP_ERRMSG_NONETWORK;
            }
            complete(NO, nil, errorMsg);
        }];        
    }
//    if ([self.reqType isEqualToString: @"GET"]) {
//        [manager GET:_urlString parameters:_paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
//            //获取进度 NSProgress
//        } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//            //成功
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//            complete(YES, dict, nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            //失败
//            complete(NO, nil, error);
//        }];
//    }
}

- (void)parseResponse: (id _Nullable) responseObject {
    
}

//构造extend参数
- (NSString *)getExtendParam {
    NSString *access_token = [Util getUserToken];
    NSString *date = [[NSDate date] toString:@"yyyyMMddHHmmss"];
    if (STRING_NULL(date)) {
        date = [[NSDate date] toString:@"yyyyMMddHHmmss"];
    }
//    NSLog(@"----zhccc----%@",date);
    NSString *random = [NSString stringWithFormat:@"%d", arc4random() % 10000];
    
    //参数拼接
    NSString *source = [NSString stringWithFormat:@"%@,%@,%@", access_token, date, random];
    NSString *encryptStr = [SecurityUtil encryptAESString:source];
    
    return encryptStr;
}

//构造orgin参数
- (NSString *)getOriginParam {
    NSString *platfrom = [Util getDeviceVersion];
    NSString *device_type = @"";
    if ([platfrom containsString:@"iPhone"]) {
        device_type = @"I01";
    }
    else {
        device_type = @"I02";
    }
    
    float version = [[Util getAppVersion] floatValue];
    NSString *bundle_version = [NSString stringWithFormat:@"%.0f", version * 1000];
    
    NSString *origin = [device_type stringByAppendingString:bundle_version];
    
    return origin;
}

@end
