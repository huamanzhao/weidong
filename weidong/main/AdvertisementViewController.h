//
//  AdvertisementViewController.h
//  weidong
//
//  Created by zhccc on 2017/10/15.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdInfo.h"
#import "BaseViewController.h"
#import "ArticalInfo.h"

@interface AdvertisementViewController : UIViewController

@property(nonatomic, copy)NSString *articleId;
@property(nonatomic, strong)ArticalInfo *artical;

@end
