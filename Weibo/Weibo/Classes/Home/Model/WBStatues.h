//
//  WBStatues.h
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//一条微博包含信息的模型

#import <Foundation/Foundation.h>
#import "WBUser.h"
@interface WBStatues : NSObject
@property(nonatomic,copy)NSString *text;//微博的内容
@property(nonatomic,copy)NSString *created_at;//微博的时间
@property(nonatomic,copy)NSString *source;//微博的来源
@property(nonatomic,copy)NSString *idstr;//微博的ID

@property(nonatomic,strong)NSArray *pic_urls;//图片组
@property(nonatomic,assign)int reposts_count;//微博的转发数
@property(nonatomic,assign)int comments_count;//微博的评论数
@property(nonatomic,assign)int attitudes_count;//微博的点赞数
@property(nonatomic,strong)WBUser *user;
@property(nonatomic,strong)WBStatues *retweeted_status;//转发的微博

@end
/*
 {
    "statuses": [
        {
        "created_at": "Tue May 31 17:46:55 +0800 2011",
        "id": 11488058246,
        "text": "求关注。"，
        "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
        "favorited": false,
        "truncated": false,
        "in_reply_to_status_id": "",
        "in_reply_to_user_id": "",
        "in_reply_to_screen_name": "",
        "geo": null,
        "mid": "5612814510546515491",
        "reposts_count": 8,
        "comments_count": 9,
        "annotations": [],
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
        },
        ...
        ],
    "ad": [
    {
    "id": 3366614911586452,
    "mark": "AB21321XDFJJK"
    },
    ...
],
    "previous_cursor": 0,                   // 暂未支持
    "next_cursor": 11488013766,    // 暂未支持
    "total_number": 81655
 }
 
 
 
 
 "retweeted_status" =         {
 "attitudes_count" = 31;
 "comments_count" = 10;
 "created_at" = "Tue May 05 12:14:25 +0800 2015";
 "darwin_tags" =             (
 );
 favorited = 0;
 geo = "<null>";
 id = 3839112732087793;
 idstr = 3839112732087793;
 "in_reply_to_screen_name" = "";
 "in_reply_to_status_id" = "";
 "in_reply_to_user_id" = "";
 mid = 3839112732087793;
 mlevel = 0;
 "pic_urls" =             (
 );
 "reposts_count" = 58;
 source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>";
 "source_allowclick" = 0;
 "source_type" = 1;
 text = "\U59d1\U5a18\Uff0c\U4eba\U4e0e\U4eba\U4e4b\U95f4\U6700\U57fa\U672c\U7684\U4fe1\U4efb\U5462\Uff1f[\U62dc\U62dc] http://t.cn/RA1lG2q";
 truncated = 0;
 user =             {
 "allow_all_act_msg" = 0;
 "allow_all_comment" = 1;
 "avatar_hd" = "http://ww4.sinaimg.cn/crop.0.0.360.360.1024/7f427769jw8eo4jmhiz8ij20a00a0gm3.jpg";
 "avatar_large" = "http://tp2.sinaimg.cn/2135062377/180/5715848764/0";
 "bi_followers_count" = 2034;
 "block_app" = 1;
 "block_word" = 0;
 city = 1;
 class = 1;
 "cover_image_phone" = "http://ww2.sinaimg.cn/crop.0.0.640.640.640/6ce2240djw1e8ys5qk2adj20hs0hs41s.jpg";
 "created_at" = "Sun May 15 02:24:17 +0800 2011";
 "credit_score" = 80;
 description = "2014\U5e74\U5341\U5927\U641e\U7b11\U5fae\U535a\Uff0c\U5408\U4f5cQ403245080";
 domain = shzxj;
 "favourites_count" = 6;
 "follow_me" = 0;
 "followers_count" = 1515144;
 following = 0;
 "friends_count" = 2123;
 gender = f;
 "geo_enabled" = 0;
 id = 2135062377;
 idstr = 2135062377;
 lang = "zh-cn";
 location = "\U6d77\U5916 \U7f8e\U56fd";
 mbrank = 6;
 mbtype = 12;
 name = "\U795e\U4e00\U822c\U7684\U56de\U590d";
 "online_status" = 0;
 "pagefriends_count" = 0;
 "profile_image_url" = "http://tp2.sinaimg.cn/2135062377/50/5715848764/0";
 "profile_url" = 271267357;
 province = 400;
 ptype = 0;
 remark = "";
 "screen_name" = "\U795e\U4e00\U822c\U7684\U56de\U590d";
 star = 0;
 "statuses_count" = 13501;
 urank = 27;
 url = "";
 verified = 1;
 "verified_contact_email" = "";
 "verified_contact_mobile" = "";
 "verified_contact_name" = "";
 "verified_level" = 3;
 "verified_reason" = "\U77e5\U540d\U5e7d\U9ed8\U535a\U4e3b";
 "verified_reason_modified" = "";
 "verified_reason_url" = "";
 "verified_source" = "";
 "verified_source_url" = "";
 "verified_state" = 0;
 "verified_trade" = 1150;
 "verified_type" = 0;
 weihao = 271267357;
 };

 */