//
//  AppDelegate.m
//  Weibo
//
//  Created by 张锋 on 15/4/23.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "AppDelegate.h"
#import "WBNewHomeTool.h"
#import "OAuthViewController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarStyle=UIStatusBarStyleDefault;
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    //获取存储在沙盒中的账号信息
    WBAccount *account=[WBAccountTool Account];

    //1.判断是否有账号
    if(account){
        //2.判断是否为新版本 新版本/首页
        [WBNewHomeTool ChooseTheBackController];
    }else{
         self.window.rootViewController=[[OAuthViewController alloc]init];
    }
    
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 在后台开启任务，让程序保持开启状态
    [application beginBackgroundTaskWithExpirationHandler:^{//过期调此函数
        NSLog(@"expiration");
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
