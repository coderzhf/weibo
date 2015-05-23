//
//  UIImage+WB.m
//  Weibo
//
//  Created by 张锋 on 15/5/6.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "UIImage+WB.h"

@implementation UIImage (WB)
+(instancetype)resizedImageWithName:(NSString *)name{
    
    UIImage *nomal=[self imageNamed:name];
    
    return [nomal stretchableImageWithLeftCapWidth:nomal.size.width*0.5 topCapHeight:nomal.size.height*0.5];
}
@end
