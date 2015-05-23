//
//  WBPhotosView.m
//  Weibo
//
//  Created by 张锋 on 15/5/7.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#define PhotoH 70
#define PhothW 70
#define margin 10
#import "WBPhotosView.h"
#import "WBStatues.h"
#import "WBPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface WBPhotosView()

@end
@implementation WBPhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        for (int i=0; i<9; i++) {
            UIImageView *image=[[UIImageView alloc]init];
            image.userInteractionEnabled=YES;
            image.tag=i;
            [image addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapPhoto:)]];
            [self addSubview: image];
        }
        
    }
    
    return self;
}
-(void)TapPhoto:(UITapGestureRecognizer *)recognizer{
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:self.photos.count];
    for (int i = 0; i<self.photos.count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        WBPhoto *wbphoto = self.photos[i];
        NSString *photoUrl = [wbphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

-(void)setPhotos:(NSArray *)photos{
    _photos=photos;
    for (int i=0; i<self.subviews.count; i++) {
    UIImageView *image=self.subviews[i];

        if (i<photos.count) {
            image.hidden=NO;
            WBPhoto *photo=photos[i];
            [image setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
            //图片的显示位置
            int RowMaxCount=(photos.count==4)?2:3;
            int col=i%RowMaxCount;
            int row=i/RowMaxCount;
            image.frame=CGRectMake(col*(PhothW+margin), row*(PhotoH+margin), PhothW, PhotoH);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            if (photos.count==1) {
                image.contentMode=UIViewContentModeScaleAspectFit;
                image.clipsToBounds=NO;
            }else{
                image.contentMode=UIViewContentModeScaleAspectFill;
                image.clipsToBounds=YES;
            }
        }else{
            image.hidden=YES;
        }
       
    }
}
+(CGSize )WBPhotosViewWithPhotoCount:(NSInteger)count{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * PhotoH + (rows - 1) * margin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * PhothW + (cols - 1) * margin;
    
    return CGSizeMake(photosW, photosH);
}

@end
