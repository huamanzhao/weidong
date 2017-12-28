//
//  ArticalInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/15.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticalInfo : NSObject

@property(nonatomic, copy)NSString *articleId;  //文章ID
@property(nonatomic, copy)NSString *Title;      //文章标题
@property(nonatomic, copy)NSString *author;     //文章作者
@property(nonatomic, copy)NSString *content;    //文章内容（html串）
@property(nonatomic, assign)NSInteger hits;     //点击数

@end
