//
//  UIBarButtonItem+WB.h
//  Weibo
//
//  Created by 张锋 on 15/4/26.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WB)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highIcon target:(id)target  action:(SEL)action;
@end
