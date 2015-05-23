//
//  WBComposeTool.h
//  Weibo
//
//  Created by 张锋 on 15/5/15.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBComposeParam.h"
@interface WBComposeTool : NSObject
+(void)WBComposeWithParam:(WBComposeParam *)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
@end
