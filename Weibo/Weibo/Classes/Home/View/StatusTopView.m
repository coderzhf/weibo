//
//  StatusTopView.m
//  Weibo
//
//  Created by 张锋 on 15/5/6.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "StatusTopView.h"
#import "StatusReweetView.h"
#import "UIImage+WB.h"
#import "CellFrame.h"
#import "WBStatues.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
#import "WBPhotosView.h"
@interface StatusTopView()

//1.头像
@property(nonatomic,weak)UIImageView *PresonalView;
//2.名字
@property(nonatomic,weak)UILabel *nameLabel;
//3.会员
@property(nonatomic,weak)UIImageView *VipView;
//4.日期
@property(nonatomic,weak)UILabel *dateLabel;
//5.客户端
@property(nonatomic,weak)UILabel *machineLabel;
//6.文本
@property(nonatomic,weak)UILabel *contentLabel;
//7.图片
@property(nonatomic,weak)WBPhotosView *contentPhotoView;
//0.被转发的图层
@property(nonatomic,weak)StatusReweetView *sourceView;
@end
@implementation StatusTopView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
         self.userInteractionEnabled=YES;
        //设置背景
        self.image=[UIImage resizedImageWithName:@"timeline_card_top_background_os7"];
        //1.头像
        UIImageView *PresonalView=[[UIImageView alloc]init];
        [self addSubview:PresonalView];
        self.PresonalView=PresonalView;
        //2.名字
        UILabel *nameLabel=[[UILabel alloc]init];
        nameLabel.font=StatusNameFont;
        [self addSubview:nameLabel];
        self.nameLabel=nameLabel;
        //3.会员
        UIImageView *VipView=[[UIImageView alloc]init];
        VipView.contentMode=UIViewContentModeCenter;
        [self addSubview:VipView];
        self.VipView=VipView;
        //4.日期
        UILabel *dateLabel=[[UILabel alloc]init];
        dateLabel.font=StatusDateFont;
        dateLabel.textColor=[UIColor colorWithRed:240/255.0 green:140/255.0 blue:19/255.0 alpha:1];
        [self addSubview:dateLabel];
        self.dateLabel=dateLabel;
        //5.客户端
        UILabel *machineLabel=[[UILabel alloc]init];
        machineLabel.font=StatusSourceFont;
        machineLabel.textColor=[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1];
        [self addSubview:machineLabel];
        self.machineLabel=machineLabel;
        //6.文本
        UILabel *contentLabel=[[UILabel alloc]init];
        contentLabel.font=statusContentFont;
        contentLabel.textColor=[UIColor colorWithRed:39/255.0 green:39/255.0 blue:39/255.0 alpha:1];
        contentLabel.numberOfLines=0;
        [self addSubview:contentLabel];
        self.contentLabel=contentLabel;
        //7.图片
        WBPhotosView *contentPhotoView=[[WBPhotosView alloc]init];
        [self addSubview:contentPhotoView];
        self.contentPhotoView=contentPhotoView;
        //0.被转发的图层
        StatusReweetView *sourceView=[[StatusReweetView alloc]init];
        [self addSubview:sourceView];
        self.sourceView=sourceView;
    }
    return self;
}
-(void)setCellFrame:(CellFrame *)cellFrame{
    _cellFrame=cellFrame;
    WBStatues *status=self.cellFrame.statue;
    WBUser *user=status.user;
    //1.头像
    [self.PresonalView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.PresonalView.frame=self.cellFrame.PresonalViewF;
    //2.名字
    self.nameLabel.text=user.name;
    self.nameLabel.frame=self.cellFrame.nameLabelF;
    //3.会员
    if (user.mbrank) {
        
        self.VipView.image=[UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.nameLabel.textColor=[UIColor colorWithRed:240/255.0 green:140/255.0 blue:19/255.0 alpha:1];
        self.VipView.frame=self.cellFrame.VipViewF;
    }
    //4.日期
    self.dateLabel.text=status.created_at;
    self.dateLabel.frame=self.cellFrame.dateLabelF;
    //5.客户端
    self.machineLabel.text=status.source;
    self.machineLabel.frame=self.cellFrame.machineLabelF;
    //6.文本
    self.contentLabel.text=status.text;
    self.contentLabel.frame=self.cellFrame.contentLabelF;
    //7.图片
    if (status.pic_urls.count) {
        self.contentPhotoView.photos=status.pic_urls;
        self.contentPhotoView.frame=self.cellFrame.contentImageF;
    }
    //0.被转发的图层
    if (status.user.name) {
        self.hidden=NO;
        self.sourceView.frame=self.cellFrame.sourceViewF;
        self.sourceView.cellFrame=self.cellFrame;

    }else{
        self.hidden=YES;
    }
   
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //4.日期
    CGFloat dateLabelX=CGRectGetMaxX(self.cellFrame.PresonalViewF)+CellBorder;
    CGFloat dateLabelY=CGRectGetMaxY(self.cellFrame.nameLabelF);
    NSMutableDictionary *dateLabelAtt=[NSMutableDictionary dictionary];
    dateLabelAtt[NSFontAttributeName]=StatusDateFont;
    CGSize dateLabelSize=[self.cellFrame.statue.created_at boundingRectWithSize:self.cellFrame.topViewF.size options:NSStringDrawingUsesLineFragmentOrigin attributes:dateLabelAtt context:nil].size;
    self.dateLabel.frame=CGRectMake(dateLabelX, dateLabelY, dateLabelSize.width, dateLabelSize.height);
    //5.客户端
    CGFloat machineLabelX=CGRectGetMaxX(self.dateLabel.frame)+CellBorder;
    CGFloat machineLabelY=dateLabelY;
    NSMutableDictionary *machineLabelAtt=[NSMutableDictionary dictionary];
    machineLabelAtt[NSFontAttributeName]=StatusSourceFont;
    CGSize machineLabelSize=[self.cellFrame.statue.source boundingRectWithSize:self.cellFrame.topViewF.size options:NSStringDrawingUsesLineFragmentOrigin attributes:machineLabelAtt context:nil].size;
    self.machineLabel.frame=CGRectMake(machineLabelX, machineLabelY, machineLabelSize.width, machineLabelSize.height);
}
@end
