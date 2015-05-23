//
//  MyTabBar.m
//  Weibo
//
//  Created by 张锋 on 15/4/24.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "MyTabBar.h"
#import "MyButtton.h"
@interface MyTabBar()

@property(nonatomic,weak)MyButtton *selectedBtn;
@property(nonatomic,weak)UIButton *addButton;
@property(nonatomic,strong)NSMutableArray *Buttons;
@end
@implementation MyTabBar
-(NSMutableArray *)Buttons{
    if (_Buttons==nil) {
        _Buttons=[NSMutableArray array];
    }
    return _Buttons;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //平铺图片 ios6
       // self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        //添加加号按钮
        UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        //添加按钮背景和图片
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7" ]forState:UIControlStateHighlighted];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7" ]forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7" ]forState:UIControlStateHighlighted];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7" ]forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(AddClick) forControlEvents:UIControlEventTouchUpInside];
        self.addButton=addButton;
        [self addSubview:addButton];
        
    }
    return self;
}
#pragma mark 加号按钮的监听
-(void)AddClick{
    if ([self.delegate respondsToSelector:@selector(MytabBarClickOnAdd)]) {
        [self.delegate MytabBarClickOnAdd];
    }
}
-(void)MyTabBarWithTabBarItem:(UITabBarItem *)items{
    //1.创建按钮
    MyButtton *btn=[MyButtton buttonWithType:UIButtonTypeCustom];
    //2.设置模型
    btn.items=items;
    [self addSubview:btn];
    //3.添加监听
    [ btn addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchDown];
    //4.添加到Button数组
    [self.Buttons addObject:btn];
    //默认第一个被选中
    if (self.Buttons.count==1) {
        [self ClickButton:btn];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //添加加号按钮位置
    CGFloat W=self.frame.size.width;
    CGFloat H=self.frame.size.height;
    self.addButton.center=CGPointMake(W*0.5, H*0.5);
    self.addButton.bounds=CGRectMake(0, 0, self.addButton.currentBackgroundImage.size.width, self.addButton.currentBackgroundImage.size.height);
    
    for (int i=0; i<self.Buttons.count; i++) {
        MyButtton *btn=self.Buttons[i];
        btn.tag=i;
        CGFloat btnH=H;
        CGFloat btnW=W/self.subviews.count;
        CGFloat btnY=0;
        CGFloat btnX=0;
        if (i<2) {
            btnX=btnW*i;
        }else{
            btnX=btnW*(i+1);
        }
        
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    
    }
}

-(void)ClickButton:(MyButtton*)btn{
    
    
    self.selectedBtn.selected=NO;
    
    btn.selected=YES;
    if ([self.delegate respondsToSelector:@selector(MyTabBarWithButton:)]) {
        [self.delegate MyTabBarWithButton:btn];
    }
    self.selectedBtn=btn;
}

@end
