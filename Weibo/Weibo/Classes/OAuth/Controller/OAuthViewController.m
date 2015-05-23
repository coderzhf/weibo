//
//  OAuthViewController.m
//  Weibo
//
//  Created by 张锋 on 15/4/28.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "WBAccount.h"
#import "WBNewHomeTool.h"
#import "WBAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "WBOAuthTool.h"
@interface OAuthViewController()<UIWebViewDelegate>
@end
@implementation OAuthViewController
-(void)viewDidLoad{
    [super viewDidLoad];

    UIWebView *web=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    NSURL *url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=521940566&response_type=code&redirect_uri=http://www.baidu.com"];
    NSURLRequest *requst=[NSURLRequest requestWithURL:url];
    web.delegate=self;
    [web loadRequest:requst];
    
}
#pragma mark UIWebViewDelegate
//当WebView发送一个请求都会调用，询问代理是否加载
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url=request.URL.absoluteString;
    //查找code=在url中的范围
    NSRange range=[url rangeOfString:@"code="];
    //如果包含code=字符串 range.location code=在字符串第几个位置
    if (range.location!=NSNotFound) {
        //获取请求中的code
        NSInteger loc=range.location+range.length;
        NSString *code = [url substringFromIndex:loc];
        //发送给新浪，返回code换取一个accessToken
        [self accessWithCode:code];
        //回调页面禁止加载
        return NO;
        
    }
    return YES;
}
//开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"开始加载"];
}
//结束加载
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];

}
//加载错误
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
/*client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 成功{
 "access_token" = "2.007g5mwB0OaA1Z1aa1b6f0feBU9MDB"; 一个用户对应的一个应用
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1784694950;//每一个用户分配唯一的id
 }

 */

-(void)accessWithCode:(NSString *)code{
    WBOAuthParam *param=[[WBOAuthParam alloc]init];
    param.client_id=@"521940566";
    param.client_secret=@"d76e489e73f3cff8b2ccecff67287092";
    param.grant_type=@"authorization_code";
    param.code=code;
    param.redirect_uri=@"http://www.baidu.com";
    //3.发送请求
    [WBOAuthTool WBOAuthToolWithParam:param success:^(WBOAuthResult *result) {
        //4.将数据存入模型中
        //5.存储模型数据
        [WBAccountTool SetAccount:result];
        //6.去新特性/首页
        [WBNewHomeTool ChooseTheBackController];
        //7.隐藏加载框
        [MBProgressHUD hideHUD];

    } failure:^(NSError *error) {
        //隐藏加载框
        [MBProgressHUD hideHUD];
    }];

}
@end
