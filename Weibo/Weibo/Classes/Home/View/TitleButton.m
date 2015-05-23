//
//  TitleButton.m
//  Weibo
//
//  Created by 张锋 on 15/4/27.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "TitleButton.h"
@interface TitleButton()
@end
@implementation TitleButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
       UIImage *normal=[UIImage imageNamed:@"navigationbar_filter_background_highlighted"];
       UIImage *stretch =[normal stretchableImageWithLeftCapWidth:normal.size.width*0.5 topCapHeight:normal.size.height*0.5];
        //设置背景
       [self setBackgroundImage: stretch forState:UIControlStateHighlighted];
        //设置字体大小以及颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont boldSystemFontOfSize:19];
        //设置字体图片位置
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.imageView.contentMode=UIViewContentModeCenter;
        //当高亮时不会自动调整currentImage的状态
        self.adjustsImageWhenHighlighted=NO;
       
    
    }
    
    return self;
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
   
    CGFloat titleH=contentRect.size.height;
//    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName]=[UIColor whiteColor];
//    dict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
//    CGSize titleSize=[self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return CGRectMake(0, 0, contentRect.size.width-self.currentImage.size.width, titleH);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
   
    CGFloat imageY=0;
    CGFloat imageW=self.currentImage.size.width;
    CGFloat imageX=contentRect.size.width-imageW;
    CGFloat imageH=contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW,imageH);
}
@end
