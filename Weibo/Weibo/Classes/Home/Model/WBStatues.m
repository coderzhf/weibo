//
//  WBStatues.m
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "WBStatues.h"
#import "WBUser.h"
#import "NSDate+WB.h"
#import "WBPhoto.h"
#import "MJExtension.h"

@implementation WBStatues
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [WBPhoto class]};
}

//get方法调用多次 可以不断刷新时间
-(NSString *)created_at{
    //1.获取发微博时的时间
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    format.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    format.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *CreatedDate = [format dateFromString:_created_at];
    //3.判断发微博时间与当前时间的差距
    if (CreatedDate.isToday){//今天
       
        if (CreatedDate.deltaWithNow.hour>=1) {//几个小时前
            return [NSString stringWithFormat:@"%ld小时前",(long)CreatedDate.deltaWithNow.hour];
        }else if(CreatedDate.deltaWithNow.minute>=1){//几分钟前
            return [NSString stringWithFormat:@"%ld分钟前",(long)CreatedDate.deltaWithNow.minute];
        }else{//几秒前 1min内
            return @"刚刚";
        }
    }else if (CreatedDate.isYesterday){//昨天
        format.dateFormat=@"HH:mm";
        NSString *str=[NSString stringWithFormat:@"昨天 %@",[format stringFromDate:CreatedDate]];
        return str;
    }else if (CreatedDate.isYear){//今年
        format.dateFormat=@"MM-dd HH:mm";
        return [format stringFromDate:CreatedDate];
    }else{//去年前年
        format.dateFormat=@"yyyy-MM-dd HH:mm";
        return [format stringFromDate:CreatedDate];
        
    }
    
}
//set方法只调用一次
-(void)setSource:(NSString *)source{
    // <a href="http://app.weibo.com/t/feed/5yiHuw" rel="nofollow">iPhone 6 Plus</a>
    int start=[source rangeOfString:@">"].location+1;
    int length=[source rangeOfString:@"</"].location-start;
    if (start>0) {
        NSString *Newsource=[source substringWithRange:NSMakeRange(start, length)];
        _source=[NSString stringWithFormat:@"来自 %@",Newsource];

    }else{
         _source=[NSString stringWithFormat:@"来自 星星的设备"];
    }
    
    
}
@end
