//
//  WBHomeStatusesResult.h
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBHomeStatusesResult : NSObject
/**
 *  statuses数组里面放的都是IWStatus模型
 */
@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;
@end
