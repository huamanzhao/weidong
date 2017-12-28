//
//  BaseViewController.m
//  GZDefence
//
//  Created by zhccc on 2017/8/25.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@implementation  UIViewController (BaseExtension)
    UIColor *tintColor;

- (void)vl_setIOS7Special {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    if (@available(iOS 11.0, *)) {
//        _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setTintColor: (UIColor *)color {
    CHECK_NAVI_NOTNULL;
    tintColor = color;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     color, NSForegroundColorAttributeName,
                                                                     [UIFont systemFontOfSize:18 weight:UIFontWeightMedium], NSFontAttributeName,
                                                                     nil]];
}

- (void)initStatusBarBGColor {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = POSITIVE_COLOR;
    }
}

/* ---- 定制导航栏左侧 ---- */
//添加自定义视图
- (void)initNaviLeftItem: (UIView *)customView {
    CHECK_NAVI_NOTNULL;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initNaviBackButton {
    CHECK_NAVI_NOTNULL;
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    backBtn.tintColor = POSITIVE_COLOR;
    
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (void)initNaviDismissButton {
    CHECK_NAVI_NOTNULL;
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissBack)];
    backBtn.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (void)initNaviLeftItemWithImage: (NSString *)imageName Title: (NSString *)title {
    UIButton *backBtn = [self generateButtonWithTitle: title Image: imageName];
    [backBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self initNaviLeftItem:backBtn];
}

- (void)customeNaviLeftItemPressed {
}


/* ---- 定制导航栏右侧 ---- */
- (void)initNaviRightItem: (UIView *)customView{
    CHECK_NAVI_NOTNULL;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)initNaviRightTitle: (NSString *)title{
    CHECK_NAVI_NOTNULL;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(naviRightBarItemPressed)];
    [backButton setTintColor:MAIN_COLOR];
    [self setBarButtonItemTitle:backButton];
    self.navigationItem.rightBarButtonItem = backButton;
}

- (void)initNaviRightImage: (NSString *)imageName{
    CHECK_NAVI_NOTNULL;
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(naviRightBarItemPressed)];
    self.navigationItem.rightBarButtonItem = backButton;
}

- (void)initNaviRightImage: (NSString *)imageName Title: (NSString *)title{
    CHECK_NAVI_NOTNULL;
    
    UIButton *button = [self generateButtonWithTitle:title Image:imageName];
    [button addTarget:self action:@selector(naviRightBarItemPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self setBarButtonItemTitle:rightItem];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initnaviRightWithImages: (NSArray *)nameList{
    CHECK_NAVI_NOTNULL;
    NSMutableArray *buttonList = [NSMutableArray new];
    
    NSInteger count = [nameList count];
    for (int index = 0; index < count; index ++) {
        NSString * name = nameList[index];
        UIImage *image = [UIImage imageNamed:name];
        if (!image) {
            continue;
        }
        
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(naviRightItemPressed:)];
        button.tintColor = GRAY_COLOR;
        button.tag = index;
        
        [buttonList addObject:button];
    }
    
    self.navigationItem.rightBarButtonItems = buttonList;
}

- (void)naviRightBarItemPressed{
    
}

- (void)naviRightItemPressed: (UIBarButtonItem *)button{
    
}

- (void)setBarButtonItemTitle: (UIBarButtonItem *)item {
    NSDictionary *attribute = @{NSForegroundColorAttributeName : MAIN_COLOR,
                                NSFontAttributeName : [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]
                                };
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
}

- (UIButton *)generateButtonWithTitle: (NSString *)title Image: (NSString *)imageName {
    UIFont *font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat btnHeight = 24;
    CGFloat textWidth = [Util getTextBoundSize:title Font:font Size:CGSizeMake(400, btnHeight)].width;
    CGFloat imagewidth = image.size.width;
    CGFloat btnWidht = textWidth + imagewidth + 8;
    CGFloat btnOriginY = (44 - btnHeight) / 2;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, btnOriginY, btnWidht, btnHeight)];
    [button setImage:image forState:UIControlStateNormal];
    if (!STRING_NULL(title)) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    button.titleLabel.font = font;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    return button;
}

- (void)naviLeftBarItemPressed {
    
}

/* ---- 私有调用 ----- */
- (void)popBack {
    CHECK_NAVI_NOTNULL;
    [self naviLeftBarItemPressed];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissBack {
    [self naviLeftBarItemPressed];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupPositiveButtonStyle: (UIButton *)button {
    [self setupStandarButtonStyle:button WithColor:POSITIVE_COLOR];
}

- (void)setupNegativeButtonStyle: (UIButton *)button {
    [self setupStandarButtonStyle:button WithColor:ZHAO_ORANGE];
}

- (void)setupStandarButtonStyle: (UIButton *)button WithColor:(UIColor *)color {
    button.backgroundColor = color;
    button.layer.cornerRadius = 6.0;
    button.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    button.layer.shadowRadius = 4.0;
    button.layer.shadowOpacity = 0.7;
    button.layer.shadowOffset = CGSizeMake(2, 4);
}

- (void)checkPhotoAuthorization {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {    //已授权
        return;
    }
    
    if (status == PHAuthorizationStatusNotDetermined) { //未决定
        //申请相册授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //暂不处理用户操作
        }];
    }
    else {  //拒绝、或者没有处理
        [self showAlertControllerWithAccessType:@"照片"];
    }
}

- (void)checkCameraAuthorization {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {    //已授权
        return;
    }
    
    if (status == AVAuthorizationStatusNotDetermined) { //未决定
        //申请照相机权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:nil];
    }
    else { //拒绝、或者没有处理
        [self showAlertControllerWithAccessType:@"相机"];
    }
}

- (void)showAlertControllerWithAccessType:(NSString *)type {
    NSString *message = [NSString stringWithFormat:@"为正常使用，请前往设置打开%@权限", type];
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertControl addAction: [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url];
        }
    }]];
    [alertControl addAction: [UIAlertAction actionWithTitle:@"不处理" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //不处理
    }]];
    
    [self presentViewController:alertControl animated:YES completion:nil];
}


@end
