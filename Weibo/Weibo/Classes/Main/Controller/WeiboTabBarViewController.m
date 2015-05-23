//
//  WeiboTabBarViewController.m
//  Weibo
//
//  Created by 张锋 on 15/4/23.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WeiboTabBarViewController.h"
#import "MyNavViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "SquareViewController.h"
#import "MineViewController.h"
#import "MyTabBar.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "AFHTTPRequestOperationManager.h"
#import "WBComposeViewController.h"
#import "WBUserTool.h"
@interface WeiboTabBarViewController ()<MyTabBarDelegate>
@property(nonatomic,strong)MyTabBar *tabar;
@property(nonatomic,strong)HomeViewController *home;
@property(nonatomic,strong)MessageViewController *message;
@property(nonatomic,strong)MineViewController *me;
@end

@implementation WeiboTabBarViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //将原来的tabBarButton删除
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.初始化TabBar
    [self setupTabBar];
    //2.初始化自控制器
    [self setupAllChilderControllers];
    //3.添加定时器
    NSTimer *timer=[NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(UnreadCount) userInfo:nil repeats:YES];
    // 子线程 NSRunLoopCommonModes 在子线程中可以拖拽UI并执行Timer   主线程  NSDefaultRunLoopMode
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];

    
}

#pragma mark 初始化所有子控制器
-(void)setupAllChilderControllers{
    
    HomeViewController *home=[[HomeViewController alloc]init];
    [self setupChildrenController:home title:@"首页" image:@"tabbar_home_os7" selectImage:@"tabbar_home_selected_os7"];
    self.home=home;
    MessageViewController *message=[[MessageViewController alloc]init];
    self.message=message;
    [self setupChildrenController:message title:@"消息" image:@"tabbar_message_center_os7" selectImage:@"tabbar_message_center_selected_os7"];
    
    SquareViewController *square=[[SquareViewController alloc]init];
    [self setupChildrenController:square title:@"广场" image:@"tabbar_discover_os7" selectImage:@"tabbar_discover_selected_os7"];
    
    MineViewController *mine=[[MineViewController alloc]init];
    self.me=mine;
    [self setupChildrenController:mine title:@"我" image:@"tabbar_profile_os7" selectImage:@"tabbar_profile_selected_os7"];
    
}
#pragma mark 初始化一个子控制器
-(void)setupChildrenController:(UITableViewController *)vc title:(NSString *)title  image:(NSString *)image selectImage:(NSString *)selected{
    
    //1.设置控制器的属性
    vc.title=title;
    //UIImageRenderingModeAlwaysOriginal 保持原来的渲染
    vc.tabBarItem.image=[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tabBarItem是一个模型类
    [self.tabar MyTabBarWithTabBarItem:vc.tabBarItem];
    //2.包装导航控制器
    MyNavViewController *Nav=[[MyNavViewController alloc]initWithRootViewController:vc];
    [self addChildViewController:Nav];
}
#pragma mark 获取未读信息个数
-(void)UnreadCount{
    WBUserUnreaderCountParam *param=[[WBUserUnreaderCountParam alloc]init];
    param.access_token=[WBAccountTool Account].access_token;
    param.uid=[NSNumber numberWithLongLong:[WBAccountTool Account].uid];
    [WBUserTool userUnreadCountWithParam:param success:^(WBUserUnreaderCountResult *result) {
        // 3.设置badgeValue
        // 3.1.首页
        if (result.status) {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        // 3.2.消息
        if (result.messageCount) {
             self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        // 3.3.我
        if (result.follower) {
            self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        //[UIApplication sharedApplication].applicationIconBadgeNumber=10;
       
        
    } failure:^(NSError *error) {
    }];

}
#pragma mark 初始化TabBar
-(void)setupTabBar{
    MyTabBar *tabBar=[[MyTabBar alloc]init];
    self.tabar=tabBar;
    tabBar.delegate=self;
    tabBar.frame=self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
}
#pragma mark MyTabBarDelegate 点击按钮跳转控制器
-(void)MyTabBarWithButton:(UIButton *)btn{
    self.selectedIndex=btn.tag;
}
#pragma mark MyTabBarDelegate 监听加号按钮的点击事件
-(void)MytabBarClickOnAdd{
    WBComposeViewController *compose=[[WBComposeViewController alloc]init];
    MyNavViewController *Nav=[[MyNavViewController alloc]initWithRootViewController:compose];
    [self presentViewController:Nav animated:YES completion:nil];
}
@end
