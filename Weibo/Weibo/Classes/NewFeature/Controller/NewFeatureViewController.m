//
//  NewFeatureViewController.m
//  Weibo
//
//  Created by 张锋 on 15/4/27.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "WeiboTabBarViewController.h"
@interface NewFeatureViewController()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *page;
@end
@implementation NewFeatureViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //1.添加scrollview
    [self setupScrollView];
    
    [self setupPageControl];
 
}
-(void)setupPageControl{
    UIPageControl *page=[[UIPageControl alloc]init];
    page.numberOfPages=3;
    page.userInteractionEnabled=NO;
    page.currentPageIndicatorTintColor=[UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1];
    page.pageIndicatorTintColor=[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
    page.center=CGPointMake(self.view.frame.size.width*0.5, 420);
    page.bounds=CGRectMake(0, 0, self.view.frame.size.width, 20);
    [self.view addSubview:page];
    self.page=page;
}
-(void)setupScrollView{
     //1.添加scrollview
    UIScrollView *scrollview=[[UIScrollView alloc]init];
    scrollview.frame=self.view.bounds;
    [self.view addSubview:scrollview];
    //2.在scollview添加图片
    for (int i=0; i<3; i++) {
        UIImageView *imageview=[[UIImageView alloc]init];
        NSString *name=[NSString stringWithFormat:@"new_feature_%d",i+1];
        imageview.image=[UIImage imageNamed:name];
        imageview.frame=CGRectMake(i*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height);
        if (i==2) {
            [self setupLastImageView:imageview];
        }
        [scrollview addSubview:imageview];
    }
    //3.设置滚动的内容尺寸
    scrollview.contentSize=CGSizeMake(3*scrollview.frame.size.width, 0);
    //取消水平方向的索引
    scrollview.showsHorizontalScrollIndicator=NO;
    //页面形式的属性
    scrollview.pagingEnabled=YES;
    //禁止弹框
    scrollview.bounces=NO;
    //设置代理
    scrollview.delegate=self;
}
#pragma mark 在最后的图片上添加按钮
-(void)setupLastImageView:(UIImageView *)ImageView{
    //1.让imageView实现交互
    ImageView.userInteractionEnabled=YES;
    //2.添加“开始微博”按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [btn setTitle:@"开始微博" forState:UIControlStateNormal];
    btn.bounds=CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    btn.center=CGPointMake(ImageView.frame.size.width*0.5, 300);
    [btn addTarget:self action:@selector(startWB) forControlEvents:UIControlEventTouchUpInside];
    [ImageView addSubview:btn];
    //3.添加分享微博按钮
    UIButton *checkbox=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.selected=YES;//默认为选中状态
    [checkbox setTitle:@"微博分享" forState:UIControlStateNormal];
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.bounds=btn.bounds;
    checkbox.center=CGPointMake(ImageView.frame.size.width*0.5, 250);
    [checkbox addTarget:self action:@selector(ClickCheckBox:) forControlEvents:UIControlEventTouchUpInside];
    [ImageView addSubview:checkbox];
}
//点击开始微博
-(void)startWB{
    self.view.window.rootViewController=[[WeiboTabBarViewController alloc]init];
}
//点击分享微博
-(void)ClickCheckBox:(UIButton *)checkBox{
    if (checkBox.selected) {
        checkBox.selected=NO;
    }else{
        checkBox.selected=YES;
    }
    
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //实现简单的四舍五入
     self.page.currentPage=(int)scrollView.contentOffset.x/self.view.frame.size.width+0.5;
}
@end
