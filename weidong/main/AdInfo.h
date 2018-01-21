//
//  AdInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/13.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdInfo : NSObject

@property(nonatomic, copy)NSString *id;         //广告ID
@property(nonatomic, copy)NSString *title;      //广告标题
@property(nonatomic, copy)NSString *path;       //广告图片URL
@property(nonatomic, copy)NSString *articleId;  //链接文章ID 、 商品ID
@property(nonatomic, assign)NSInteger type;     //广告链接目标类型：1-文章  2-商品
@end
