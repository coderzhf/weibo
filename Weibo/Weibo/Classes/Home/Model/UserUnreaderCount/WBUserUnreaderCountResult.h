//
//  WBUserUnreaderCountResult.h
//  Weibo
//
//  Created by 张锋 on 15/5/15.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUserUnreaderCountResult : NSObject
/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;

/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_status;

- (int)messageCount;
@end
