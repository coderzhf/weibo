//
//  WBHttpTool.m
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBHttpTool.h"
#import "AFNetworking.h"
@implementation WBHttpTool
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];
}
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params dataArray:(NSArray *)dataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSData *data in dataArray) {
            [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
