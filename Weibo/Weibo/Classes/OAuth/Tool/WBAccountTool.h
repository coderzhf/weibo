//
//  WBAccountTool.h
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBAccount;
@interface WBAccountTool : NSObject
+(void)SetAccount:(WBAccount *)account;
+(WBAccount *)Account;
@end
