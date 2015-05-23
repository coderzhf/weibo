//
//  WBStatusCell.h
//  Weibo
//
//  Created by 张锋 on 15/4/29.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellFrame.h"
@interface WBStatusCell : UITableViewCell
@property(nonatomic,strong)CellFrame *cellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
