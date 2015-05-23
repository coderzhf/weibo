//
//  WBHomeStatusesParam.h
//  Weibo
//
//  Created by 张锋 on 15/5/12.
//  Copyright (c) 2015年 张锋. All rights reserved.
//  封装加载首页微博数据的参数

#import <Foundation/Foundation.h>
#import "WBBaseParam.h"
@interface WBHomeStatusesParam : WBBaseParam


/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, strong) NSNumber *since_id;

/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, strong)NSNumber *max_id;

/**
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property (nonatomic, strong) NSNumber *count;
//用NSNumber的好处是，当模型转换成字典后，NSNumber没有传值则为nil 不会传入字典中，而int类型默认存入为0
@end
