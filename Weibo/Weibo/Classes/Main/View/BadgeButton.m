//
//  BadgeButton.m
//  Weibo
//
//  Created by 张锋 on 15/4/25.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "BadgeButton.h"

@implementation BadgeButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //禁止与用户交互
        self.userInteractionEnabled=NO;
        
        //设置文字和图片
        self.titleLabel.font=[UIFont systemFontOfSize:11];
        UIImage *normal=[UIImage imageNamed:@"main_badge_os7"];
        //拉伸操作
        UIImage *changeImage=[normal stretchableImageWithLeftCapWidth:normal.size.width*0.5 topCapHeight:normal.size.height*0.5 ];
        [self setBackgroundImage:changeImage forState:UIControlStateNormal];
    }
    return self;
}
-(void)setBadgeValue:(NSString *)badgeValue{
    
    _badgeValue=[badgeValue copy];
    
    if (badgeValue==nil) {
        self.hidden=YES;
    }else{
        self.hidden=NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
    }
    
    //计算文字大小
    NSDictionary *arrt=@{NSFontAttributeName:[UIFont systemFontOfSize:11]};
    CGSize titleSize = [badgeValue boundingRectWithSize: self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:arrt context:nil].size;
    CGFloat buttonW=titleSize.width+10;
    CGFloat buttonH=titleSize.height+5;
    //按钮内部定义展现大小
    self.bounds=CGRectMake(0, 0, buttonW, buttonH);
}
@end
