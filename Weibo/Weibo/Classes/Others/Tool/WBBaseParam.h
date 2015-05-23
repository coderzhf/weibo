//
//  WBBaseParam.h
//  Weibo
//
//  Created by 张锋 on 15/5/15.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *access_token;
@end
