//
//  AppDelegate.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "AppDelegate.h"

#import "SPSZ_LoginViewController.h"

#import "BaseNavigationController.h"
#import "SPSZ_ChuIndexViewController.h"


#import "NetworkReachabilityTool.h"

@interface AppDelegate ()



@end

@implementation AppDelegate

+ (AppDelegate*)shareInstance
{
    return (id)[[UIApplication sharedApplication] delegate];
}

#pragma mark - ======== lifeCycle ========
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    SPSZ_LoginViewController *login = [[SPSZ_LoginViewController alloc]init];
    
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = navi;
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [[UIView appearance] setExclusiveTouch:YES];
    
    // 监听网络状态
    [[NetworkReachabilityTool defaultTool] start];
    
    
    return YES;
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ---- 将进入前台 ----
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (UIView *tmp in self.window.subviews) {
        if ([tmp isKindOfClass:[MBProgressHUD class]]) {
            [tmp removeFromSuperview];
        }
    }
    
}

#pragma mark ---- 已经进入前台 ----
- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

#pragma mark ---- 程序即将退出 ----
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

#pragma mark ---- 请求用户允许通知后执行 ----
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
}

#pragma mark ---- 程序将要挂起,设置角标 ----
- (void)applicationWillResignActive:(UIApplication *)application
{

}

#pragma mark ---- 已经进入后台 ----
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}



@end
