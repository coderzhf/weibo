//
//  WBAccount.m
//  Weibo
//
//  Created by 张锋 on 15/4/28.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount

//读取数据是调用
-(id)initWithCoder:(NSCoder *)Decoder{
    if (self=[super init]) {
        self.access_token=[Decoder decodeObjectForKey:@"access_token"];
        self.expires_in=[Decoder decodeInt64ForKey:@"expires_in"];
        self.remind_in=[Decoder decodeInt64ForKey:@"remind_in"];
        self.uid=[Decoder decodeInt64ForKey:@"uid"];
        self.expiresTime=[Decoder decodeObjectForKey:@"expiresTime"];
        self.name=[Decoder decodeObjectForKey:@"name"];
    }
    
    return self;
    
}
//将对象写入文件时调用
-(void)encodeWithCoder:(NSCoder *)enCoder{
    
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [enCoder encodeObject:self.name forKey:@"name"];
    [enCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [enCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [enCoder encodeInt64:self.uid forKey:@"uid"];
}
@end
