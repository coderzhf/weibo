//
//  StatusToolView.m
//  Weibo
//
//  Created by 张锋 on 15/5/6.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "StatusToolView.h"
#import "UIImage+WB.h"
#import "CellFrame.h"
#import "WBStatues.h"
@interface StatusToolView()
//1.转发数
@property(nonatomic,weak)UIButton *repost;
//2.评论数
@property(nonatomic,weak)UIButton *comment;
//3.赞
@property(nonatomic,weak)UIButton *attitude;

@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,strong)NSMutableArray *dividers;
@end
@implementation StatusToolView
-(NSMutableArray *)btns{
    if (_btns==nil) {
        _btns=[NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers{
    if (_dividers==nil) {
        _dividers=[NSMutableArray array];
    }
    return _dividers;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        // 1.设置图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background_os7"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted_os7"];
        
        //1.转发数
        self.repost=[self setButtonWithTitle:@"转发" Image:@"timeline_icon_retweet_os7" BackgroundImage:@"timeline_card_leftbottom_os7"];
        //2.评论数
        self.comment=[self setButtonWithTitle:@"评论" Image:@"timeline_icon_comment_os7" BackgroundImage:@"timeline_card_middlebottom_os7"];
        //3.赞
        self.attitude=[self setButtonWithTitle:@"赞" Image:@"timeline_icon_unlike_os7" BackgroundImage:@"timeline_card_rightbottom_os7"];
        //4.分割线 2根
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}
-(void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line_os7"];
    divider.highlightedImage= [UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}
-(UIButton *)setButtonWithTitle:(NSString *)title Image:(NSString *)iamge BackgroundImage:(NSString *)bgImage{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:iamge] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setTitle:@"评论" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.设置按钮的frame
    int dividerCount = self.dividers.count; // 分割线的个数
    CGFloat dividerW = 2; // 分割线的宽度
    int btnCount = self.btns.count;
    CGFloat btnW = (self.frame.size.width - dividerCount * dividerW) / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        
        // 设置frame
        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 2.设置分割线的frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0; j<dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        
        // 设置frame
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}
-(void)setStatus:(WBStatues *)status{
    _status=status;
  
    
    [self setupBtn:self.repost originalTitle:@"转发" count:status.reposts_count];
    [self setupBtn:self.comment originalTitle:@"评论" count:status.comments_count];
    [self setupBtn:self.attitude originalTitle:@"赞" count:status.attitudes_count];
    
}
/**
 *  设置按钮的显示标题
 *
 *  @param btn           哪个按钮需要设置标题
 *  @param originalTitle 按钮的原始标题(显示的数字为0的时候, 显示这个原始标题)
 *  @param count         显示的个数
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count
{
    /**
     0 -> @"转发"
     <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
     >= 10000
     * 整万(10100, 20326, 30000 ....) : 1万, 2万
     * 其他(14364) : 1.4万
     */
    
    if (count) { // 个数不为0
        NSString *title = nil;
        if (count < 10000) { // 小于1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // >= 1W
            // 42342 / 1000 * 0.1 = 42 * 0.1 = 4.2
            // 10742 / 1000 * 0.1 = 10 * 0.1 = 1.0
            // double countDouble = count / 1000 * 0.1;
            
            // 42342 / 10000.0 = 4.2342
            // 10742 / 10000.0 = 1.0742
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            // title == 4.2万 4.0万 1.0万 1.1万
            //将.0换成无符号
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}
@end
