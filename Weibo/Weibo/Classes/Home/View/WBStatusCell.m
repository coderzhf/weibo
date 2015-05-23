//
//  WBStatusCell.m
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatues.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WB.h"
#import "StatusTopView.h"
#import "StatusToolView.h"
#import "StatusReweetView.h"
@interface WBStatusCell()
//0.最顶层的图片
@property(nonatomic,weak)StatusTopView *topView;


//0.工具栏的图层
@property(nonatomic,weak)StatusToolView *toolView;

@end
@implementation WBStatusCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark 初始化cell的方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        //1.添加微博子控件
        [self SetupOriginalSubviews];
        //2.添加微博的工具条
        [self SetupStatusToolBar];
    }
    return self;
}
//1.添加原创内部子控件
-(void)SetupOriginalSubviews{
    
    //0.微博的图层 原创和转发
    StatusTopView *topView=[[StatusTopView alloc]init];
    [self.contentView addSubview:topView];
    self.topView=topView;

}

//2.添加微博的工具条
-(void)SetupStatusToolBar{
    //0.被转发的图层
    StatusToolView *toolView=[[StatusToolView alloc]init];
    [self.contentView addSubview:toolView];
    self.toolView=toolView;
}
#pragma mark cellFrame的set的方法  对接数据和子控件的大小
-(void)setCellFrame:(CellFrame *)cellFrame{
    _cellFrame=cellFrame;
    //1.原创微博
    [self SetupOriginalData];
    //3.工具栏
    [self SetupToolData];
}
- (void)SetupOriginalData {
    //topView的位置和大小
    self.topView.frame=self.cellFrame.topViewF;
    //模型传递 调用topView中的set cellFrame方法
    self.topView.cellFrame=self.cellFrame;
}

-(void)SetupToolData{
    //0.工具栏
    self.toolView.frame=self.cellFrame.toolViewF;
    
    self.toolView.status=self.cellFrame.statue;

}

@end
