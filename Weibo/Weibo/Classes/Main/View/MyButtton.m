//
//  MyButtton.m
//  Weibo
//
//  Created by 张锋 on 15/4/25.
//  Copyright (c) 2015年 张锋. All rights reserved.
//
#define MyButttonRadio 0.6
#import "MyButtton.h"
#import "BadgeButton.h"
@interface MyButtton()
@property(nonatomic,weak)BadgeButton *badgeButton;
@end
@implementation MyButtton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
       
        //设置图片居中
        self.imageView.contentMode=UIViewContentModeCenter;
        //设置文字居中和字体大小
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:11];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //添加消息按钮
        BadgeButton *badge=[BadgeButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:badge];
        self.badgeButton=badge;

    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{
    //取消高亮的状态
    [super setHighlighted:NO];
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
   
    CGFloat imagH=contentRect.size.height*MyButttonRadio;
    CGFloat imagW=contentRect.size.width;
    
    return CGRectMake(0, 0, imagW, imagH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleW=contentRect.size.width;
    CGFloat titleY=contentRect.size.height*MyButttonRadio;
    CGFloat titleH=contentRect.size.height-titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setItems:(UITabBarItem *)items{
    _items=items;
    //kvo 当属性改变是回调用
    [ items addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [ items addObserver:self forKeyPath:@"title" options:0 context:nil];
    [ items addObserver:self forKeyPath:@"image" options:0 context:nil];
    [ items addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    //只要调用setItems都会传入到监听方法  减少代码量
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
-(void)dealloc{

    //用完kvc需要释放
    [self.items removeObserver:self forKeyPath:@"badgeValue"];
    [self.items removeObserver:self forKeyPath:@"title"];
    [self.items removeObserver:self forKeyPath:@"image"];
    [self.items removeObserver:self forKeyPath:@"selectedImage"];

}
//监听forKeyPath属性被改了就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self setImage:self.items.image forState:UIControlStateNormal];
    [self setImage:self.items.selectedImage forState:UIControlStateSelected];
    [self setTitle:self.items.title forState:UIControlStateNormal];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.items.badgeValue;
    
    [self layoutSubviews];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //计算文字大小
    NSDictionary *arrt=@{NSFontAttributeName:[UIFont systemFontOfSize:11]};
    CGSize titleSize = [self.items.badgeValue boundingRectWithSize: self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:arrt context:nil].size;
    CGFloat buttonW=titleSize.width+10;
    CGFloat buttonH=titleSize.height+5;
    CGFloat buttonX=self.frame.size.width*0.5;
    self.badgeButton.frame=CGRectMake(buttonX, 3,buttonW , buttonH);
}
@end
