//
//  WBNewHomeTool.m
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBNewHomeTool.h"
#import "NewFeatureViewController.h"
#import "WeiboTabBarViewController.h"
@implementation WBNewHomeTool
+(void)ChooseTheBackController{
    
    //6.判断是否为新特性
    //取出原来沙盒中的版本
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion=[user stringForKey:@"lastVersion"];
    //取出当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController=[[WeiboTabBarViewController alloc]init];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController=[[NewFeatureViewController alloc]init];
        //存储新版本号
        [user setObject:currentVersion forKey:@"lastVersion"];
        [user synchronize];
 
    }
    
}
@end
