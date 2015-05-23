//
//  WBComposeToolView.m
//  Weibo
//
//  Created by 张锋 on 15/5/13.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBComposeToolView.h"
@interface WBComposeToolView()
@property(nonatomic,weak)UIButton *emotionButton;
@end
@implementation WBComposeToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        // 1.设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        // 2.添加按钮
        [self buttonWithImage:@"compose_camerabutton_background_os7" highImage:@"compose_camerabutton_background_highlighted_os7" tag:WBComposeToolbarButtonTypeCamera];
        [self buttonWithImage:@"compose_toolbar_picture_os7" highImage:@"compose_toolbar_picture_highlighted_os7" tag:WBComposeToolbarButtonTypePicture];
        [self buttonWithImage:@"compose_mentionbutton_background_os7" highImage:@"compose_mentionbutton_background_highlighted_os7" tag:WBComposeToolbarButtonTypeMention];
        [self buttonWithImage:@"compose_trendbutton_background_os7" highImage:@"compose_trendbutton_background_highlighted_os7" tag:WBComposeToolbarButtonTypeTrend];
        self.emotionButton=[self buttonWithImage:@"compose_emoticonbutton_background_os7" highImage:@"compose_emoticonbutton_background_highlighted_os7" tag:WBComposeToolbarButtonTypeEmotion];
    
    }
    return self;
}
#pragma mark 添加按钮
-(UIButton *)buttonWithImage:(NSString *)image highImage:(NSString *)highImage tag:(int)tag{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag=tag;
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}
#pragma mark 监听按钮
-(void)BtnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(WBComposeToolDidCLickButtonType:)]) {
        [self.delegate WBComposeToolDidCLickButtonType:btn.tag];
    }
}
#pragma mark 切换图像与键盘
-(void)setShowEmotionButton:(BOOL)showEmotionButton{
    _showEmotionButton=showEmotionButton;
    if (_showEmotionButton) {//切换系统自带
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_os7"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted_os7"] forState:UIControlStateHighlighted];
    
    }else{
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
#pragma mark 布局
-(void)layoutSubviews{
    [super layoutSubviews];
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *btn=self.subviews[i];
        CGFloat btnH=self.frame.size.height;
        CGFloat btnW=self.frame.size.width/self.subviews.count;
        CGFloat btnX=i*btnW;
        CGFloat btnY=0;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        
    }
}
@end
