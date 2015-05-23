//
//  WBUserUnreaderCountResult.m
//  Weibo
//
//  Created by 张锋 on 15/5/15.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBUserUnreaderCountResult.h"

@implementation WBUserUnreaderCountResult
- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}
@end
