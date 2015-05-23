//
//  CellFrame.h
//  Weibo
//
//  Created by 张锋 on 15/4/30.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 昵称的字体 */
#define StatusNameFont [UIFont systemFontOfSize:15]
/** 时间的字体 */
#define StatusDateFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define StatusSourceFont StatusDateFont
/** 正文的字体 */
#define statusContentFont [UIFont systemFontOfSize:17]
/** 转发正文的字体 */
#define SourceContentFont [UIFont systemFontOfSize:16]
//cell的间距
#define CellBorder 10

@class WBStatues;
@interface CellFrame : NSObject
@property(nonatomic,strong)WBStatues *statue;
//0.最顶层的图片
@property(nonatomic,assign,readonly)CGRect topViewF;
//1.头像
@property(nonatomic,assign,readonly)CGRect PresonalViewF;
//2.名字
@property(nonatomic,assign,readonly)CGRect nameLabelF;
//3.会员
@property(nonatomic,assign,readonly)CGRect VipViewF;
//4.日期
@property(nonatomic,assign,readonly)CGRect dateLabelF;
//5.客户端
@property(nonatomic,assign,readonly)CGRect machineLabelF;
//6.文本
@property(nonatomic,assign,readonly)CGRect contentLabelF;
//7.图片
@property(nonatomic,assign,readonly)CGRect contentImageF;

//0.被转发的图层
@property(nonatomic,assign,readonly)CGRect sourceViewF;
//1.人名
@property(nonatomic,assign,readonly)CGRect sourceNameF;
//2.转发文本
@property(nonatomic,assign,readonly)CGRect sourceContentF;
//3.转发图片
@property(nonatomic,assign,readonly)CGRect sourceImageF;

//0.工具栏的图层
@property(nonatomic,assign,readonly)CGRect toolViewF;

//每个cell的高度
@property(nonatomic,assign) CGFloat cellHeight;
@end
