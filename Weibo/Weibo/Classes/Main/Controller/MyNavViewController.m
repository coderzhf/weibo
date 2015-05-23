//
//  MyNavViewController.m
//  Weibo
//
//  Created by 张锋 on 15/4/26.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "MyNavViewController.h"

@interface MyNavViewController ()

@end

@implementation MyNavViewController
#pragma mark 第一次使用这个类调用方法
+(void)initialize{
    //1.设置导航栏主题
    //appearance得到导航栏外观属性，可同时修改属性
    UINavigationBar *bar=[UINavigationBar appearance];
    NSMutableDictionary *title=[NSMutableDictionary dictionary];
    title[NSFontAttributeName]=[UIFont boldSystemFontOfSize:16];
    [bar setTitleTextAttributes:title];
    //2.设置导航栏按钮主题
    UIBarButtonItem *button=[UIBarButtonItem appearance];
    NSMutableDictionary *Btntitle=[NSMutableDictionary dictionary];
    Btntitle[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    Btntitle[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [button setTitleTextAttributes:Btntitle forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //排除根控制器以外的push控制器对象
    if (self.viewControllers.count>0) {
        //隐藏push新控制器的底部导航栏
        viewController.hidesBottomBarWhenPushed=YES;
    }
   
    [super pushViewController:viewController animated:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
