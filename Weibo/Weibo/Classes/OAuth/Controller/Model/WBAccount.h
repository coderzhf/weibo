//
//  WBAccount.h
//  Weibo
//
//  Created by 张锋 on 15/4/28.
//  Copyright (c) 2015年 张锋. All rights reserved.
//
/*
 成功{
 "access_token" = "2.007g5mwB0OaA1Z1aa1b6f0feBU9MDB"; 一个用户对应的一个应用
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1784694950;//每一个用户分配唯一的id
 */
#import <Foundation/Foundation.h>

@interface WBAccount : NSObject<NSCoding>

@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,assign)long long expires_in;
@property(nonatomic,assign)long long remind_in;
@property(nonatomic,assign)long long uid;
@property(nonatomic,copy)NSString *name;//用户名
@property(nonatomic,strong)NSDate *expiresTime;//过期时间

@end
