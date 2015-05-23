//
//  NSDate+WB.m
//  Weibo
//
//  Created by 张锋 on 15/5/6.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "NSDate+WB.h"

@implementation NSDate (WB)
//是否为今天
-(BOOL)isToday{
    NSCalendar *calender=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    //1.获取当前时间
    NSDateComponents *nowcmps=[calender components:unit fromDate:[NSDate date]];
    //2.获取发微博时间
    NSDateComponents *selfcomps=[calender components:unit fromDate:self];
    return (selfcomps.year==nowcmps.year)&&(selfcomps.month==nowcmps.month)&&(selfcomps.day==nowcmps.day);
}
//是否为昨天
-(BOOL)isYesterday{

    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd";
    NSDate *Now=[NSDate date];
    NSString *NowStr=[fmt stringFromDate:Now];
    NSDate *NowDate=[fmt dateFromString:NowStr];
    
    NSString *selfStr=[fmt stringFromDate:self];
    NSDate *selfDate=[fmt dateFromString:selfStr];
    NSCalendar *calender=[NSCalendar currentCalendar];
    
    NSDateComponents *cmp =[calender components:NSCalendarUnitDay fromDate:selfDate toDate:NowDate options:0];
    
    return cmp.day==1;
}
//是否为今年
-(BOOL)isYear{
    NSCalendar *calender=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitYear;
    //1.获取当前时间
    NSDateComponents *nowcmps=[calender components:unit fromDate:[NSDate date]];
    //2.获取发微博时间
    NSDateComponents *selfcomps=[calender components:unit fromDate:self];
    return selfcomps.year==nowcmps.year;
}
-(NSDateComponents *)deltaWithNow{
    NSCalendar *calender=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    return [calender components:unit fromDate:self toDate:[NSDate date] options: 0];
}
@end
