//
//  WBComposeToolView.h
//  Weibo
//
//  Created by 张锋 on 15/5/13.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    WBComposeToolbarButtonTypeCamera,
    WBComposeToolbarButtonTypePicture,
    WBComposeToolbarButtonTypeMention,
    WBComposeToolbarButtonTypeTrend,
    WBComposeToolbarButtonTypeEmotion
}WBComposeToolbarButtonType;
@protocol WBComposeToolViewDelegate<NSObject>
@optional
-(void)WBComposeToolDidCLickButtonType:(WBComposeToolbarButtonType )type;
@end

@interface WBComposeToolView : UIView
@property(nonatomic,weak)id<WBComposeToolViewDelegate>delegate;
@property(nonatomic,assign)BOOL showEmotionButton;

@end
