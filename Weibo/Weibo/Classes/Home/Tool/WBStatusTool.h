//
//  WBStatusTool.h
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//业务工具类：处理某种业务

#import <Foundation/Foundation.h>
#import "WBHomeStatusesParam.h"
#import "WBHomeStatusesResult.h"
@interface WBStatusTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)HomeStatusWithParam:(WBHomeStatusesParam *)param success:(void(^)(WBHomeStatusesResult *result))success failure:(void(^)(NSError *error))failure;
@end
