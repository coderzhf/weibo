//
//  MyTabBar.h
//  Weibo
//
//  Created by 张锋 on 15/4/24.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBar;
@protocol MyTabBarDelegate<NSObject>
@optional
-(void)MyTabBarWithButton:(UIButton *)btn;
-(void)MytabBarClickOnAdd;
@end

@interface MyTabBar : UIView
@property(nonatomic,weak)id <MyTabBarDelegate>delegate;
-(void)MyTabBarWithTabBarItem:(UITabBarItem *)items;

@end
