//
//  WBComposeTool.m
//  Weibo
//
//  Created by 张锋 on 15/5/15.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBComposeTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"
@implementation WBComposeTool
+(void)WBComposeWithParam:(WBComposeParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WBHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
