//
//  WBPhotosView.h
//  Weibo
//
//  Created by 张锋 on 15/5/7.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPhotosView : UIView
@property(nonatomic,strong)NSArray *photos;
+(CGSize )WBPhotosViewWithPhotoCount:(NSInteger)count;
@end
