//
//  WBHomeStatusesResult.m
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBHomeStatusesResult.h"
#import "MJExtension.h"
#import "WBStatues.h"
@implementation WBHomeStatusesResult
//将数组转换成模型
-(NSDictionary *)objectClassInArray{
     return @{@"statuses" : [WBStatues class]};
}
@end
