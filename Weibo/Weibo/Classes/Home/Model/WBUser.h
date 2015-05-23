//
//  WBUser.h
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//user中的模型数据

#import <Foundation/Foundation.h>

@interface WBUser : NSObject
@property(nonatomic,assign)long long ID;//用户的id
@property(nonatomic,copy)NSString *name;//用户的昵称
@property(nonatomic,copy)NSString *profile_image_url;//用户的头像
@property(nonatomic,assign)int mbrank;//会员等级

@property (nonatomic, assign) int mbtype; //会员类型 > 2 会员

@end
/*
 "user": {
 "id": 1404376560,
 "screen_name": "zaku",
 "name": "zaku",
 "province": "11",
 "city": "5",
 "location": "北京 朝阳区",
 "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
 "url": "http://blog.sina.com.cn/zaku",
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 "domain": "zaku",
 "gender": "m",
 "followers_count": 1204,
 "friends_count": 447,
 "statuses_count": 2908,
 "favourites_count": 0,
 "created_at": "Fri Aug 28 00:00:00 +0800 2009",
 "following": false,
 "allow_all_act_msg": false,
 "remark": "",
 "geo_enabled": true,
 "verified": false,
 "allow_all_comment": true,
 "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
 "verified_reason": "",
 "follow_me": false,
 "online_status": 0,
 "bi_followers_count": 215
 }

 */