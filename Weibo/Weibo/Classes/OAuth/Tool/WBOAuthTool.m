//
//  WBOAuthTool.m
//  Weibo
//
//  Created by 张锋 on 15/5/13.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBOAuthTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"
@implementation WBOAuthTool
+(void)WBOAuthToolWithParam:(WBOAuthParam *)param success:(void (^)(WBOAuthResult *))success failure:(void (^)(NSError *))failure{
    
    [WBHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:param.keyValues success:^(id json) {
        if (success) {
            WBOAuthResult *result=[WBOAuthResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
