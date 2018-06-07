//
//  Constants.h
//  GZDefence
//
//  Created by zhccc on 2017/8/20.
//  Copyright © 2017年 wxy. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import "Util.h"

/* -------- 服务器设置 -------- */
#define SERVER_TEST_HTTP_BASE   @"http://pay.rhd361.com"
#define SERVER_SERVER_URL       @"http://www.weldone.shop"      //正式服务器

/*  易购卡  */
//服务器
#define SERVER_TEST_EGOU_HTTP    @"http://47.95.204.47:8090/"
#define SERVER_RELEASE_EGOU_HTTP @"https://www.egocard.cn/"
//基地址
#define SERVER_EGOU_BASE        @"card/rechargephone.do"
#define SERVER_WEIDOU_BASE      @"cardb/rechargephone.do"


//配置正式、测试环境
#define SERVER_HTTP_BASE    SERVER_SERVER_URL//     SERVER_TEST_HTTP_BASE//     //测试服务器、正式服务器切换改这里
#define SERVER_HTTP_EGOU    SERVER_RELEASE_EGOU_HTTP//  SERVER_TEST_EGOU_HTTP//     //易购卡

/*
 #define SERVER_TEST_EGOU_URL    @"http://47.95.204.47:8090/card/rechargephone.do"
 #define SERVER_RELEASE_EGOU_URL @"https://www.egocard.cn/card/rechargephone.do"
 #define SERVER_TEST_WEIDOU_URL    @"http://47.95.204.47:8090/cardb/rechargephone.do"
 #define SERVER_RELEASE_WEIDOU_URL @"https://www.egocard.cn/cardb/rechargephone.do"
 #define SERVER_EGOU_URL      SERVER_RELEASE_EGOU_URL//  SERVER_TEST_EGOU_URL//  //易购卡测试服务器 、正式服务器
 #define SERVER_WEIDOU_URL    SERVER_TEST_WEIDOU_URL//   SERVER_RELEASE_WEIDOU_URL//    //微豆测试、正式服务器
 */
#define SERVER_EGOU_URL     [SERVER_HTTP_EGOU stringByAppendingString: SERVER_EGOU_BASE]
#define SERVER_WEIDOU_URL   [SERVER_HTTP_EGOU stringByAppendingString: SERVER_WEIDOU_BASE];
#define SERVER_BASE_URL     [SERVER_HTTP_BASE stringByAppendingString:@":80/"]  //服务器基地址
#define SERVER_API_URL      [SERVER_BASE_URL stringByAppendingString:@"interfaces/app/"] //接口url基地址
#define SERVER_API_URL_MEMEBER  [SERVER_BASE_URL stringByAppendingString:@"interfaces/app/member/"] //需要登录访问的接口

#define SERVER_MEMBERCETER_URL  [SERVER_HTTP_BASE stringByAppendingString:@"/member/index"]         //个人中心URL
#define SERVER_CART_URL     [SERVER_HTTP_BASE stringByAppendingString:@"/cart/list"]            //购物车URL
#define SERVER_ORDER_URL    [SERVER_HTTP_BASE stringByAppendingString:@"/member/order/list"]    //订单URL
#define SERVER_CoinList_URL [SERVER_HTTP_BASE stringByAppendingString:@"/member/deposit/log"]   //微动币列表URL
#define SERVER_HOME_URL     [SERVER_HTTP_BASE stringByAppendingString:@"/"] //首页URL

#define EGOU_CARD_URL_BASE      @"rechargephonecheck.do" //易购卡支付界面
#define WEIDOU_URL_BASE         @"cardb/rechargephone.do" //微豆充值

/* -------- 常量 -------- */
//屏幕大小
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGH [[UIScreen mainScreen] bounds].size.height

//颜色
#define POSITIVE_COLOR [UIColor colorWithHex:0x008aff]  //蓝色
#define NEGATIVE_COLOR [UIColor colorWithHex:0xff894f]  //橙色
#define ZHAO_BLUE [UIColor colorWithHex:0x008aff]   //赵真设计蓝色
#define ZHAO_ORANGE [UIColor colorWithHex:0xff894f] //赵真设计橘色
#define COLOR_0 [UIColor colorWithHex:0x368bf6]
#define COLOR_1 [UIColor colorWithHex:0xed6c46]
#define COLOR_2 [UIColor colorWithHex:0x69c954]

#define CYAN_COLOR [UIColor colorWithHex:0x00ffff]      //青色
#define ORANGE_COLOR [UIColor colorWithHex:0xFF7F00]   //橘色
#define MAIN_COLOR [UIColor colorWithHex:0x1f548c]
#define SUB_COLOR  [UIColor colorWithHex:0x80bbec]
#define GRAY_COLOR [UIColor colorWithHex:0x9a9a9a]
#define LOGIN_RED  [UIColor colorWithHex:0xf03030]

/* -------- 个人信息 -------- */
#define USER_NAME    @"username"
#define PASS_WORD    @"password"
#define LOGION_STATE @"loginstate"
#define LOGGED_IN    @"1"
#define LOGGED_OUT   @"0"

/* -------- 字符串 ---------- */
#define MEMBER_MY_ORDER @"我的订单"
#define MEMBER_SETTINGS @"设置"
#define MEMBER_PERSONAL @"个人资料"
#define MEMBER_CHANGEPSW @"修改密码"
#define MEMBER_CHANGEPAYPSW @"支付密码设置"

#define CREDIT_PARK_CATEGORY_ID @"241"


#define WX_AppID @"wxcaacd462002e7404"
#define WX_PartnerID @"1496008132"

#define HTTP_ERRMSG_TIMEOUT @"网络请求超时"
#define HTTP_ERRMSG_NONETWORK @"网络连接错误"

#endif /* Constants_h */
