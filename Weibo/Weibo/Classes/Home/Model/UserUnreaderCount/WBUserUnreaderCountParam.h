//
//  WBUserUnreaderCountParam.h
//  Weibo
//
//  Created by 张锋 on 15/5/15.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBBaseParam.h"

@interface WBUserUnreaderCountParam : WBBaseParam
/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;
@end
