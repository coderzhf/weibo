//
//  UIBarButtonItem+WB.m
//  Weibo
//
//  Created by 张锋 on 15/4/26.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "UIBarButtonItem+WB.h"

@implementation UIBarButtonItem (WB)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    
    UIButton *Button=[UIButton buttonWithType:UIButtonTypeCustom];
    [Button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [Button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    Button.bounds=CGRectMake(0, 0, Button.currentImage.size.width, Button.currentImage.size.height);
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:Button];
}
@end
