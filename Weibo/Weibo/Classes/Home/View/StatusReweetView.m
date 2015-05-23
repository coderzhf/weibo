//
//  StatusReweetView.m
//  Weibo
//
//  Created by 张锋 on 15/5/6.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "StatusReweetView.h"
#import "UIImage+WB.h"
#import "CellFrame.h"
#import "WBStatues.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
#import "WBPhotosView.h"
@interface StatusReweetView()
//1.人名
@property(nonatomic,weak)UILabel *sourceName;
//2.转发文本
@property(nonatomic,weak)UILabel *sourceContent;
//3.转发图片
@property(nonatomic,weak)WBPhotosView *sourcePhotoView;
@end
@implementation StatusReweetView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //背景
        self.userInteractionEnabled=YES;
        UIImage *normal=[UIImage imageNamed:@"timeline_retweet_background_os7"];
        UIImage *changeImage=[normal stretchableImageWithLeftCapWidth:normal.size.width*0.9  topCapHeight:normal.size.height*0.5];
        self.image=changeImage;
        //1.人名
        UILabel *sourceName=[[UILabel alloc]init];
        sourceName.font=SourceContentFont;
        sourceName.textColor=[UIColor colorWithRed:67/255.0 green:107/255.0 blue:163/255.0 alpha:1];
        [self addSubview:sourceName];
        self.sourceName=sourceName;
        //2.转发文本
        UILabel *sourceContent=[[UILabel alloc]init];
        sourceContent.font=SourceContentFont;
        sourceContent.textColor=[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        sourceContent.numberOfLines=0;
        [self addSubview:sourceContent];
        self.sourceContent=sourceContent;
        //3.转发图片
        WBPhotosView *sourcePhotoView=[[WBPhotosView alloc]init];
        [self addSubview:sourcePhotoView];
        self.sourcePhotoView=sourcePhotoView;
    }
    
    return self;
}
-(void)setCellFrame:(CellFrame *)cellFrame{
    _cellFrame=cellFrame;
    WBStatues *status=self.cellFrame.statue;
    WBStatues *restatus=status.retweeted_status;
        //1.人名
        NSString *userName=[NSString stringWithFormat:@"@%@",restatus.user.name];
        self.sourceName.text=userName;
        self.sourceName.frame=self.cellFrame.sourceNameF;
        //2.转发文本
        self.sourceContent.text=restatus.text;
        self.sourceContent.frame=self.cellFrame.sourceContentF;
        //3.转发图片
        if (restatus.pic_urls.count) {
            self.sourcePhotoView.hidden=NO;
            self.sourcePhotoView.photos=restatus.pic_urls;
            
            self.sourcePhotoView.frame=self.cellFrame.sourceImageF;
        }else{
            self.sourcePhotoView.hidden=YES;
        }
}
@end