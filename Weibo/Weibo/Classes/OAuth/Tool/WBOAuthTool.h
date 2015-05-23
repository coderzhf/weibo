//
//  WBOAuthTool.h
//  Weibo
//
//  Created by 张锋 on 15/5/13.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBOAuthParam.h"
#import "WBOAuthResult.h"
@interface WBOAuthTool : NSObject
+(void)WBOAuthToolWithParam:(WBOAuthParam *)param success:(void(^)(WBOAuthResult *result))success failure:(void(^)(NSError *error))failure;
@end
