//
//  Util.m
//  GZDefence
//
//  Created by zhccc on 2017/8/21.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import "Util.h"
#import "SAMKeychain.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import "Constants.h"
#import "LoginRequest.h"
#import "MainTabbarViewController.h"


#define SSKC_ACCOUNT   @"WeidongShop"
#define SSKC_UUID_FLAG @"WeidongShop.uuid"
#define SSKC_PSWD_FLAG @"WeidongShop.password"

#define DEFAULT_USERINFO   @"default_user_loginInfo"
#define DEFAULT_USER    @"default_user"
#define DEFAULT_TOKEN   @"default_token"
#define DEFAULT_EXPIRE  @"default_expire"
#define DEFAULT_PSWD    @"default_hamberg"

#define DEFAULT_LOGIN_STATUS @"default_isLogin"
#define DEFAULT_AUTO_LOGIN @"default_autoLogin"

@implementation Util

+ (void)updateLoginInfo:(NSString *)user Token:(NSString *)token ExpireTime: (NSString *)time Pswd: (NSString *)password{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    if (!STRING_NULL(user)) {
        [userInfo setValue:user forKey:DEFAULT_USER];
    }
    if (!STRING_NULL(token)) {
        [userInfo setValue:token forKey:DEFAULT_TOKEN];
    }
    if (!STRING_NULL(time)) {
        [userInfo setValue:time forKey:DEFAULT_EXPIRE];
    }
    if (!STRING_NULL(password)) {
        [userInfo setValue:password forKey:DEFAULT_PSWD];
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[userInfo copy] forKey:DEFAULT_USERINFO];
    [userDefault synchronize];
}

+ (void)updateUserPassword:(NSString *)password {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *loginInfo = [userDefault valueForKey:DEFAULT_USERINFO];
    if (loginInfo == nil) {
        return;
    }
    
    [loginInfo setValue:password forKey:DEFAULT_PSWD];
    [userDefault setValue:loginInfo forKey:DEFAULT_USERINFO];
    [userDefault synchronize];
}

+ (void)clearLoginInfo {
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[userInfo copy] forKey:DEFAULT_USERINFO];
    [userDefault synchronize];
    
    //同时将自动登录取消
    [Util setAutoLogin:NO];
    [Util setUserLogin:NO];
}

+ (NSString *)getUserName {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *loginInfo = [userDefault valueForKey:DEFAULT_USERINFO];
    if (loginInfo == nil) {
        return @"";
    }
    
    NSString *user = [loginInfo valueForKey:DEFAULT_USER];
    if (user == nil) {
        return @"";
    }
    
    return user;
}

+ (NSString *)getUserPassword {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *loginInfo = [userDefault valueForKey:DEFAULT_USERINFO];
    if (loginInfo == nil) {
        return @"";
    }
    
    NSString *password = [loginInfo valueForKey:DEFAULT_PSWD];
    if (password == nil) {
        return @"";
    }
    
    return password;
}

+ (NSString *)getUserToken {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *loginInfo = [userDefault valueForKey:DEFAULT_USERINFO];
    if (loginInfo == nil) {
        return @"";
    }
    
    NSString *token = [loginInfo valueForKey:DEFAULT_TOKEN];
    if (token == nil) {
        return @"";
    }
    
    return token;
}

+ (void)setUserLogin: (BOOL)staus {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:staus forKey:DEFAULT_LOGIN_STATUS];
    [userDefault synchronize];
}

+ (BOOL)userIsLogin {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    id data = [userDefault valueForKey:DEFAULT_LOGIN_STATUS];
    if (!data) {
        return NO;
    }
    if (![data boolValue]) {
        return NO;
    }
    return YES;
}

+ (void)setAutoLogin:(BOOL)enable {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:enable forKey:DEFAULT_AUTO_LOGIN];
    [userDefault synchronize];
}

+ (BOOL)getAutoLoginState {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    id data = [userDefault valueForKey:DEFAULT_AUTO_LOGIN];
    if (!data) {
        return NO;
    }
    if (![data boolValue]) {
        return NO;
    }
    return YES;
}

+ (void)autoLogin:(void (^_Nonnull)(BOOL))complete {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *loginInfo = [userDefault valueForKey:DEFAULT_USERINFO];
    if (loginInfo == nil) {
        return;
    }
    
    NSString *userName = [loginInfo valueForKey:DEFAULT_USER];
    NSString *password = [loginInfo valueForKey:DEFAULT_PSWD];
    if (STRING_NULL(userName) || STRING_NULL(password)) {
        return;
    }
    
    LoginRequest *request = [LoginRequest new];
    request.login_name = userName;
    request.password = password;
    [request excuteRequst:^(Boolean isOK, NSString *token, NSString *expireTime, NSString * _Nullable errorMsg) {
        if (isOK) {
            [Util updateLoginInfo:userName Token:token ExpireTime:expireTime Pswd:password];
        }
        complete(isOK);
    }];
}

+ (BOOL)userIsVerified {
    NSDictionary *selfDic = [SelfInfo localSelfInfoDic];
    
    if (!selfDic) {
        return NO;
    }
    
    NSNumber *isVerifyNum  = [selfDic valueForKey:@"isVerify"];
    if (!isVerifyNum) {
        return NO;
    }

    BOOL isVerify = [isVerifyNum boolValue];
    
    return isVerify;
}

+ (NSString *)getUserEmail {
    NSDictionary *selfDic = [SelfInfo localSelfInfoDic];
    if (!selfDic) {
        return nil;
    }
    
    NSString *email = [selfDic valueForKey:@"email"];
    
    return email;
}

//----- 设备系统 ---------

+ (NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppBuildVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}


+ (NSString *)getDeviceUUID
{
    NSString *uuid = [SAMKeychain passwordForService:SSKC_UUID_FLAG account:SSKC_ACCOUNT];
    if (STRING_NULL(uuid)) {
        uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [SAMKeychain setPassword:uuid forService:SSKC_UUID_FLAG account:SSKC_ACCOUNT];
    }
    
    return uuid;
}

+ (NSString *)getSystemVerison
{
    NSMutableString *systemVersion = [NSMutableString stringWithString:[UIDevice currentDevice].systemName];
    [systemVersion appendString:[UIDevice currentDevice].systemVersion];
    return systemVersion;
}

+ (NSString *)getDeviceVersionInfo
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    
    return platform;
}

+ (NSString *)getDeviceVersion
{
    NSString *platform = [self getDeviceVersionInfo];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPadAir2";
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}


+ (CGSize)getTextBoundSize: (NSString *)text Font: (UIFont *)font Size: (CGSize)size {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect textRect = [text boundingRectWithSize:size options:options attributes:attribute context:nil];
    
    return textRect.size;
}


+ (NSString *)getDistanceStringOfPoint: (CLLocationCoordinate2D)originCd ToPoint: (CLLocationCoordinate2D)targetCd {
    CLLocationDistance distance = [Util getDistanceOfPoint:originCd ToPoint:targetCd];
    NSString *distanceStr;
    if (distance >= 1000.0) {
        distanceStr = [NSString stringWithFormat:@"%.1lf公里", distance / 1000];
    }
    else {
        distanceStr = [NSString stringWithFormat:@"%.0lf米", distance];
    }
    
    return distanceStr;
}

+ (double)getDistanceOfPoint: (CLLocationCoordinate2D)originCd ToPoint: (CLLocationCoordinate2D)targetCd {
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:originCd.latitude longitude:originCd.longitude];
    CLLocation *target = [[CLLocation alloc] initWithLatitude:targetCd.latitude longitude:targetCd.longitude];
    
    CLLocationDistance distance = [origin distanceFromLocation:target];
    
    return distance;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (UIViewController *)getTopViewController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    if ([topController isKindOfClass:[MainTabbarViewController class]]) {   //先找tabbarController；
        UITabBarController *tabController = (UITabBarController *)topController;
        topController = tabController.selectedViewController;               //tabbar当前选中的controller
    }
    
    if ([topController isKindOfClass:[UINavigationController class]]) {     //当前选中的事navigationController
        topController = [topController childViewControllers].lastObject;    //navigation的最前面controller
    }
    
    return topController;
}

+ (UITabBarController *)getMainTabbarController {
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootController isKindOfClass:[MainTabbarViewController class]]) {
        return (UITabBarController *)rootController;
    }
    else {
        return nil;
    }
}

+ (NSString *)getURLScheme {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSArray *typeArr = [dict objectForKey:@"CFBundleURLTypes"];
    if (!typeArr || [typeArr count] == 0) {
        return nil;
    }
    
    NSDictionary *typeDic = typeArr.firstObject;
    if (!typeDic) {
        return nil;
    }
    
    NSArray *schemeArr = [typeDic objectForKey:@"CFBundleURLSchemes"];
    if (!schemeArr || [schemeArr count] == 0) {
        return nil;
    }
    
    return schemeArr.firstObject;
}


@end


@implementation NSDate (Extension)

+ (NSDate *)getDate: (int64_t) milliseconds {
    NSTimeInterval seconds = milliseconds / 1000; //从毫秒数取秒数
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    return date;
}

+ (NSDate *)localDate {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: [NSDate date]];
    
    NSDate *localeDate = [[NSDate date]  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

//转化为本地时间
- (NSDate *)toLocalDate {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    NSDate *localeDate = [self dateByAddingTimeInterval: interval];
    
    return localeDate;
}

//将NSDate转化为NSString
/*例如
 * 2017/08/23 10:22:37 <---> yyyy/MM/dd HH:mm:ss
 * 2017年8月7日9点22分 <---> yyyy年M月d日H点m分
 */
- (NSString *)toString: (NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    
    NSString *dateStr = [formatter stringFromDate:self];
    
    return dateStr;
}

@end

@implementation NSString (StrExtentsion)

- (NSDate *)toDate: (NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    
    NSDate *date = [formatter dateFromString:self];
    
    return date;
}

-(BOOL)checkPhoneNumInput{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regex evaluateWithObject:self];
    //    BOOL res2 = [regextestcm evaluateWithObject:self];
    //    BOOL res3 = [regextestcu evaluateWithObject:self];
    //    BOOL res4 = [regextestct evaluateWithObject:self];
    
    return res1;
}

-(BOOL)checkIDNumber{
    NSString *isIDCard=@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[xX0-9]$";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isIDCard];
    BOOL res = [regex evaluateWithObject:self];
    
    return res;
}

- (BOOL)checkEmailAccount {
    NSString *isEmail = @"^[A-Za-z0-9]+([-_.])*[A-Za-z0-9]+@[A-Za-z0-9]+[-.][A-Za-z]{2,5}$";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isEmail];
    BOOL res = [regex evaluateWithObject:self];
    
    return res;
}

- (NSString *) md5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr),result );
    NSMutableString *hash =[NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

@end

@implementation UIColor (ColorExtension)

+ (UIColor *)colorWithHex: (uint) hex {
    CGFloat red   = ((hex & 0xFF0000) >> 16) / 255.0;
    CGFloat green = ((hex & 0x00FF00) >> 8) / 255.0;
    CGFloat blue  = (hex & 0x0000FF) / 255.0;
    UIColor *color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:1.0];
    
    return color;
}

@end

@implementation UIView (ViewExtension)

- (void)setRoundBorder {
    self.layer.cornerRadius = 4.0;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.masksToBounds = YES;
}

- (void)setRoundBorderWithRadius:(CGFloat) radius {
    self.layer.cornerRadius = radius;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.masksToBounds = YES;
}

- (void)setRoundCorner {
    self.layer.cornerRadius = 4.0;
}

- (void)setRoundCornerWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}

- (void)addShadowLayer {
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 8.0;
    self.layer.shadowOffset = CGSizeMake(3.0, 3.0);
}

@end

@implementation UIButton (TitleImageAdjust)

- (void)adjustItemsUpDown {
    CGFloat margin = 8.0;
    CGFloat halfMargin = margin / 2; //图片跟文字间距4
    
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    CGFloat titleHeight = self.titleLabel.frame.size.height;
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, titleHeight + halfMargin, -titleWidth)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageHeight + halfMargin, -imageWidth, 0, 0)];
    
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
}

- (void)setBadgeNumber:(NSInteger)num {
    
}

@end


