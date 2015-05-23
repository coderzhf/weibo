//
//  WBAccountTool.m
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"
@implementation WBAccountTool
+(void)SetAccount:(WBAccount *)account{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[document stringByAppendingString:@"/account.data"];
    //设置过期时间
    NSDate *now=[NSDate date];
    account.expiresTime=[now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}
+(WBAccount *)Account{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[document stringByAppendingString:@"/account.data"];
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSDate *now=[NSDate date];
    //判断是否过期 NSOrderedAscending升序
    if ([now compare:account.expiresTime]==NSOrderedAscending) {
        return account;
    }else{
        
        return nil;
    }
    
}
@end
