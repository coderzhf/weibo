//
//  WBHttpTool.h
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//封装整个项目的GET/POST请求

#import <Foundation/Foundation.h>

@interface WBHttpTool : NSObject
/**
 *  发送一个POST请求  异步的类方法没有返回值
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个GET请求
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个post请求 附带data
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params dataArray:(NSArray *)dataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
