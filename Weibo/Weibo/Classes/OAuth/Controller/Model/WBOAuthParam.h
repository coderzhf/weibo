//
//  WBOAuthParam.h
//  Weibo
//
//  Created by 张锋 on 15/5/13.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code

 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
@interface WBOAuthParam : NSObject
@property(nonatomic,copy)NSString *client_id;
@property(nonatomic,copy)NSString *client_secret;
@property(nonatomic,copy)NSString *grant_type;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *redirect_uri;
@end
