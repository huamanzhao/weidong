//
//  BannerView.h
//  GZDefence
//
//  Created by zhccc on 2017/8/23.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdInfo.h"

@protocol BannerViewDelegate <NSObject>
//点按选择新闻
- (void)selectAdWithId: (AdInfo *)adInfo;

@end

@interface BannerView : UIView <UIScrollViewDelegate>

@property(nonatomic, weak) id<BannerViewDelegate> delegate;

- (void)showViewWithBanners: (NSArray *)bannerList;

@end
