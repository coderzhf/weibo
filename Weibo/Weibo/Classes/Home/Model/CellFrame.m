//
//  CellFrame.m
//  Weibo
//
//  Created by 张锋 on 15/4/30.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "CellFrame.h"
#import "WBStatues.h"
#import "WBPhotosView.h"

@implementation CellFrame
-(void)setStatue:(WBStatues *)statue{
    _statue=statue;
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width;
    

    //1.头像
    CGFloat PresonalViewWH=35;
    CGFloat PresonalViewX=CellBorder;
    CGFloat PresonalViewY=CellBorder;
    _PresonalViewF=CGRectMake(PresonalViewX, PresonalViewY,PresonalViewWH, PresonalViewWH);
    //2.名字
    CGFloat nameLabelX=CGRectGetMaxX(_PresonalViewF)+CellBorder;
    CGFloat nameLabelY=PresonalViewY;
    NSMutableDictionary *namelabelAtt=[NSMutableDictionary dictionary];
    namelabelAtt[NSFontAttributeName]=StatusNameFont;
    CGSize nameLabelSize=[statue.user.name boundingRectWithSize:_topViewF.size options:NSStringDrawingUsesLineFragmentOrigin attributes:namelabelAtt context:nil].size;
    _nameLabelF=CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width,nameLabelSize.height);
    //3.会员
    if (statue.user.mbtype>2) {
        CGFloat VipViewX=CGRectGetMaxX(_nameLabelF)+CellBorder;
        CGFloat VipViewY=nameLabelY;
        CGFloat VipViewW=14;
        CGFloat VipViewH=nameLabelSize.height;
        _VipViewF=CGRectMake(VipViewX, VipViewY, VipViewW, VipViewH);
    }
    //4.日期
    CGFloat dateLabelX=nameLabelX;
    CGFloat dateLabelY=CGRectGetMaxY(_nameLabelF);
    NSMutableDictionary *dateLabelAtt=[NSMutableDictionary dictionary];
    dateLabelAtt[NSFontAttributeName]=StatusDateFont;
    CGSize dateLabelSize=[statue.created_at boundingRectWithSize:_topViewF.size options:NSStringDrawingUsesLineFragmentOrigin attributes:dateLabelAtt context:nil].size;
    _dateLabelF=CGRectMake(dateLabelX, dateLabelY, dateLabelSize.width, dateLabelSize.height);
    //5.客户端
    CGFloat machineLabelX=CGRectGetMaxX(_dateLabelF)+CellBorder;
    CGFloat machineLabelY=dateLabelY;
    NSMutableDictionary *machineLabelAtt=[NSMutableDictionary dictionary];
    machineLabelAtt[NSFontAttributeName]=StatusSourceFont;
    CGSize machineLabelSize=[statue.source boundingRectWithSize:_topViewF.size options:NSStringDrawingUsesLineFragmentOrigin attributes:machineLabelAtt context:nil].size;
    _machineLabelF=CGRectMake(machineLabelX, machineLabelY, machineLabelSize.width, machineLabelSize.height);
    //6.文本
    CGFloat contentLabelX=CellBorder;
    CGFloat contentLabelY=CGRectGetMaxY(_dateLabelF)+CellBorder;
    NSMutableDictionary *contentLabelAtt=[NSMutableDictionary dictionary];
    contentLabelAtt[NSFontAttributeName]=statusContentFont;
    CGSize contentLabelSize=[statue.text boundingRectWithSize:CGSizeMake(cellW-2*CellBorder, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentLabelAtt context:nil].size;
    _contentLabelF=CGRectMake(contentLabelX, contentLabelY, contentLabelSize.width, contentLabelSize.height);
   
    //0.最顶层的图片
    CGFloat topViewW=cellW;
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewH;
    if (statue.pic_urls.count) {//有图
         //7.图片
        CGFloat contentImageX=PresonalViewX;
        CGFloat contentImageY=CGRectGetMaxY(_contentLabelF)+CellBorder;
        CGSize contentImageSize=[WBPhotosView WBPhotosViewWithPhotoCount:statue.pic_urls.count];
        _contentImageF=CGRectMake(contentImageX, contentImageY, contentImageSize.width, contentImageSize.height);
    }

    
    if (statue.retweeted_status.text) {//有转发内容
        //0.被转发的图层
        CGFloat sourceViewX=5;
        CGFloat sourceViewY=CGRectGetMaxY(_contentLabelF)+CellBorder;
        CGFloat sourceViewW=topViewW-10;
        CGFloat sourceViewH;
        //1.人名
        CGFloat sourceNameX=PresonalViewX;
        CGFloat sourceNameY=CellBorder;
        NSMutableDictionary *sourceNameAtt=[NSMutableDictionary dictionary];
        sourceNameAtt[NSFontAttributeName]=SourceContentFont;
        NSString *userName=[NSString stringWithFormat:@"@%@",statue.retweeted_status.user.name];
        CGSize sourceNameSize=[userName boundingRectWithSize:CGSizeMake(cellW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:sourceNameAtt context:nil].size;
        _sourceNameF=CGRectMake(sourceNameX, sourceNameY, sourceNameSize.width, sourceNameSize.height);
        
        //2.转发文本
        CGFloat sourceContentX=sourceNameX;
        CGFloat sourceContentY=CGRectGetMaxY(_sourceNameF);
        NSMutableDictionary *sourceContentAtt=[NSMutableDictionary dictionary];
        sourceContentAtt[NSFontAttributeName]=SourceContentFont;
        CGSize sourceContentSize=[statue.retweeted_status.text boundingRectWithSize:CGSizeMake(cellW-2*CellBorder, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:sourceContentAtt context:nil].size;
        _sourceContentF=CGRectMake(sourceContentX, sourceContentY, sourceContentSize.width, sourceContentSize.height);
        if (statue.retweeted_status.pic_urls.count) {//转发内容中有图片
            //3.转发图片
            CGFloat sourceImageX=sourceNameX;
            CGFloat sourceImageY=CGRectGetMaxY(_sourceContentF)+CellBorder;
            CGSize sourceImageSize=[WBPhotosView WBPhotosViewWithPhotoCount:statue.retweeted_status.pic_urls.count];
            _sourceImageF=CGRectMake(sourceImageX, sourceImageY, sourceImageSize.width, sourceImageSize.height);
            sourceViewH=CGRectGetMaxY(_sourceImageF)+CellBorder;
        }else{//转发内容中没有图片
            sourceViewH=CGRectGetMaxY(_sourceContentF)+CellBorder;
        }
        _sourceViewF=CGRectMake(sourceViewX, sourceViewY, sourceViewW, sourceViewH);
        topViewH=CGRectGetMaxY(_sourceViewF);

    }else{// 没有转发微博
        if (statue.pic_urls.count) { // 有图
            topViewH = CGRectGetMaxY(_contentImageF);
        } else { // 无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH+=CellBorder;
    _topViewF=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 0.工具条
    CGFloat toolViewX = topViewX;
    CGFloat toolViewY = CGRectGetMaxY(_topViewF);
    CGFloat toolViewW = topViewW;
    CGFloat toolViewH = 35;
    _toolViewF = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
    
        
    //计算cell的高度
    _cellHeight=CGRectGetMaxY(_toolViewF)+CellBorder;
   
}
@end
