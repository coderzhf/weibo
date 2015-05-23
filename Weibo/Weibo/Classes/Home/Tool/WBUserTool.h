//
//  WBUserTool.h
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//  用户处理类

#import <Foundation/Foundation.h>
#import "WBUserInfoParam.h"
#import "WBUserInforResult.h"
#import "WBUserUnreaderCountParam.h"
#import "WBUserUnreaderCountResult.h"
@interface WBUserTool : NSObject
+(void)UserWithPrama:(WBUserInfoParam *)parma success:(void(^)(WBUserInforResult *result))success failure:(void(^)(NSError *error))faliure;
/**
 *  加载用户的消息未读数
 */
+ (void)userUnreadCountWithParam:(WBUserUnreaderCountParam *)param success:(void (^)(WBUserUnreaderCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
