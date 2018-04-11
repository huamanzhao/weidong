//
//  NetworkFailureViewController.m
//  weidong
//
//  Created by zhccc on 2018/4/6.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "NetworkFailureViewController.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface NetworkFailureViewController ()

@end

@implementation NetworkFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)recheckBtnPressed:(id)sender {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                [SVProgressHUD showInfoWithStatus:@"网络连接失败"];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [SVProgressHUD showInfoWithStatus:@"网络连接成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
                [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                break;
            }
                
            default:
                break;
        }
    }];
}

@end
