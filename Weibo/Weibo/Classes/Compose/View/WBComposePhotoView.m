//
//  WBComposePhotoView.m
//  Weibo
//
//  Created by 张锋 on 15/5/14.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBComposePhotoView.h"

@implementation WBComposePhotoView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark 添加图片
-(void)ShowImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}
#pragma mark layout
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    int maxColumns = 4; // 一行最多显示4张图片
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewW) / (maxColumns + 1);
    for (int i = 0; i<count; i++) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewW + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}
-(NSArray *)TotalImages{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}
@end
