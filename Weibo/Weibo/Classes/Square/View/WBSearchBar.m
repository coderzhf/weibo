//
//  WBSearchBar.m
//  Weibo
//
//  Created by 张锋 on 15/4/26.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar
+(instancetype)SearchBar{
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //设置背景
        UIImage *normal=[UIImage imageNamed:@"searchbar_textfield_background_os7"];
        UIImage *stretch = [normal stretchableImageWithLeftCapWidth: normal.size.width*0.5 topCapHeight:normal.size.height*0.5];
        [self setBackground:stretch];
        //设置左边的放大镜图标
        UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        //设置放大镜图片尺寸以及样式
        image.bounds=CGRectMake(0, 0, 30, 30);
        image.contentMode=UIViewContentModeCenter;
        self.leftView=image;
        self.leftViewMode=UITextFieldViewModeAlways;
        //设置搜索框的大小及字体
        self.bounds=CGRectMake(0, 0, 300, 30);
        self.font=[UIFont systemFontOfSize:14];
        //搜索框默认字
        self.placeholder=@"搜索";
        //总显示删除按钮
        self.clearButtonMode=UITextFieldViewModeAlways;
        //设置键盘右下角按钮的样式 
        self.returnKeyType=UIReturnKeySearch;
        self.enablesReturnKeyAutomatically=YES;
    }
    
    return self;
}
@end
