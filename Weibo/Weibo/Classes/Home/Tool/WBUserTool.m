//
//  WBUserTool.m
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBUserTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"
@implementation WBUserTool
+(void)UserWithPrama:(WBUserInfoParam *)parma success:(void (^)(WBUserInforResult *))success failure:(void (^)(NSError *))faliure{
    
    [WBHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:parma.keyValues success:^(id json) {
        if (success) {
            WBUserInforResult *result=[WBUserInforResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (faliure) {
            faliure(error);
        }
    }];
    
}
+(void)userUnreadCountWithParam:(WBUserUnreaderCountParam *)param success:(void (^)(WBUserUnreaderCountResult *))success failure:(void (^)(NSError *))failure{
    [WBHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if (success) {
             WBUserUnreaderCountResult *result=[WBUserUnreaderCountResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
