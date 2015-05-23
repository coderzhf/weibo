//
//  NSDate+WB.h
//  Weibo
//
//  Created by 张锋 on 15/5/6.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WB)
//是否为今天
-(BOOL)isToday;
//是否为昨天
-(BOOL)isYesterday;
//是否为今年
-(BOOL)isYear;
-(NSDateComponents *)deltaWithNow;
@end
