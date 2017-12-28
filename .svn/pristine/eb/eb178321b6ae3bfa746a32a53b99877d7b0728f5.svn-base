//
//  BaseViewController.h
//  GZDefence
//
//  Created by zhccc on 2017/8/25.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Util.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define CHECK_NAVI_NOTNULL if (!self.navigationController) return;

@interface UIViewController (BaseExtension)

- (void)setTintColor: (UIColor *)color;
- (void)initStatusBarBGColor;

/* ---- 定制导航栏左侧 ---- */
//添加自定义视图
- (void)initNaviLeftItem: (UIView *)customView;
//左侧BarButtonItem：默认返回按钮（返回样式：popback）
- (void)initNaviBackButton;
//左侧BarButtonItem：默认返回按钮（返回样式：dismiss）
- (void)initNaviDismissButton;
//用户自定义左侧BarButtonItem
- (void)initNaviLeftItemWithImage: (NSString *)imageName Title: (NSString *)title;
//用户自定义BarButtonItem响应函数
- (void)customeNaviLeftItemPressed;
//右侧按钮点击回调
- (void)naviLeftBarItemPressed;

/* ---- 定制导航栏右侧 ---- */
//添加自定义按钮
- (void)initNaviRightItem: (UIView *)customView;
//文字按钮
- (void)initNaviRightTitle: (NSString *)title;
//图片按钮
- (void)initNaviRightImage: (NSString *)imageName;
//图片+文字按钮
- (void)initNaviRightImage: (NSString *)imageName Title: (NSString *)title;
//多个图片
- (void)initnaviRightWithImages: (NSArray *)nameList;

//右侧按钮点击回调
- (void)naviRightBarItemPressed;
//右侧多个按钮点击回调
- (void)naviRightItemPressed: (UIBarButtonItem *)button;


/* ---- 定制导航栏标题 ---- */

//设置为登录按钮的样式
- (void)setupPositiveButtonStyle: (UIButton *)button;
- (void)setupNegativeButtonStyle: (UIButton *)button;
- (void)setupStandarButtonStyle: (UIButton *)button WithColor:(UIColor *)color;

/* ---- 权限处理 ---- */
- (void)checkPhotoAuthorization;
- (void)checkCameraAuthorization;

@end
