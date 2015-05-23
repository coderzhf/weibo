//
//  WBStatusTool.m
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"
#import "FMDB.h"
#import "WBStatues.h"
@implementation WBStatusTool
//数据库实例
static FMDatabase *_db;
+(void)initialize{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filename=[doc stringByAppendingPathComponent:@"status.sqlite"];
    _db=[FMDatabase databaseWithPath:filename];
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"create table if not exists t_home_status(id integer primary key autoincrement,access_token text not null,status_idstr text not null,status_dict blob not null);"];
        if (result) {
            NSLog(@"success");
        }else{
            NSLog(@"failure");
        }
    }
}
+(void)HomeStatusWithParam:(WBHomeStatusesParam *)param success:(void (^)(WBHomeStatusesResult *))success failure:(void (^)(NSError *))failure{
    NSArray *cacheHomeStatus=[self CachedHomeStatusWithParam:param];
    if (cacheHomeStatus.count) {//有缓存数据
        if (success) {
            WBHomeStatusesResult *result=[[WBHomeStatusesResult alloc]init];
            result.statuses=cacheHomeStatus;
            success(result); 
        }
        
    }else{//无缓存数据
        //模型转字典
        [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
            if (success) {
                NSArray *statusDicArray=json[@"statuses"];
                [self saveHomeStatusesArray:statusDicArray param:param];
                WBHomeStatusesResult *result=[WBHomeStatusesResult objectWithKeyValues:json];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    
}
#pragma mark 通过请求参数加载数据
+(NSArray *)CachedHomeStatusWithParam:(WBHomeStatusesParam *)param{
    FMResultSet *result =nil;
    if (param.since_id) {//更新
        result= [_db executeQuery:@"select * from t_home_status where access_token = ? and status_idstr > ? order by status_idstr desc limit ?;",param.access_token,param.since_id,param.count];
    }else if (param.max_id){//加载
        result= [_db executeQuery:@"select * from t_home_status  where access_token = ? and status_idstr <= ? order by status_idstr desc limit ?;",param.access_token,param.max_id,param.count];
    }else{//不做任何操作的时候
        result= [_db executeQuery:@"select * from t_home_status  where access_token = ? order by status_idstr desc limit ?;",param.access_token,param.count];
    }
    NSMutableArray *statuses=[NSMutableArray array];
    while ([result next]) {
        NSData *statusData = [result objectForColumnName:@"status_dict"];
        NSDictionary *statusDic=[NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        WBStatues *status=[WBStatues objectWithKeyValues:statusDic];
        [statuses addObject:status];
    }
    return statuses;
}
#pragma mark 存入缓存数据
+(void)saveHomeStatusesArray:(NSArray *)array param:(WBHomeStatusesParam *)param{
    for (NSDictionary *statusDic in array) {
        //将字典对象序列化成二进制nsdata
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:statusDic];
        [_db executeUpdate:@"insert into t_home_status (access_token,status_idstr,status_dict) values(?,?,?);",param.access_token,statusDic[@"idstr"],data];
    }
    
}
@end
