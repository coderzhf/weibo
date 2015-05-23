//
//  HomeViewController.m
//  Weibo
//
//  Created by 张锋 on 15/4/23.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "HomeViewController.h"
#import "BadgeButton.h"
#import "UIBarButtonItem+WB.h"
#import "TitleButton.h"
#import "AFNetworking.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "UIImageView+WebCache.h"
#import "WBStatues.h"
#import "WBStatusCell.h"
#import "UIImage+WB.h"
#import "MJRefresh.h"
#import "WBHttpTool.h"
#import "WBStatusTool.h"
#import "WBUserTool.h"
@interface HomeViewController ()<MJRefreshBaseViewDelegate>
@property(nonatomic,weak)TitleButton *titleButton;
@property(nonatomic,strong)NSMutableArray *statuesFrame;
@property(nonatomic,strong)MJRefreshFooterView *foot;
@property(nonatomic,strong)MJRefreshHeaderView *header;
@end

@implementation HomeViewController
-(NSMutableArray *)statuesFrame{
    if(_statuesFrame==nil){
        _statuesFrame=[NSMutableArray array];
    }
    return _statuesFrame;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //0.刷新控件 加载数据
    [self setupRefreshView];
    //1.初始化导航栏
    [self setupNava];
    //2.获取用户信息
    [self setupUserInfo];
    
}

//0.刷新控件
-(void)setupRefreshView{
    //顶部 下拉控件
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.tableView;
    header.delegate=self;
    self.header=header;
    //初次登陆加载数据
    [self LoadNewData];
    //底部 上拉控件
    MJRefreshFooterView *foot=[MJRefreshFooterView footer];
    foot.scrollView=self.tableView;
    foot.delegate=self;
    self.foot=foot;

}
-(void)dealloc{
    //释放上拉刷新控件
    [self.foot free];
    [self.header free];
}
#pragma mark MJRefreshBaseViewDelegate
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {//加载更多数据 上拉
        [self LoadMoreData];
    }else{//加载更新数据 下拉
        [self LoadNewData];
    }
}
//上拉加载更多数据
-(void)LoadMoreData{
    WBHomeStatusesParam *param=[[WBHomeStatusesParam alloc]init];
    param.access_token=[WBAccountTool Account].access_token;
    param.count=@(5);
    CellFrame *cellFrame=self.statuesFrame.lastObject;
    //从哪一条开始读取
    param.max_id=@([cellFrame.statue.idstr longLongValue]-1);
    [WBStatusTool HomeStatusWithParam:param success:^(WBHomeStatusesResult *result) {
        //取出所有微博数据的模型
        NSMutableArray *statuesFrame=[NSMutableArray array];
        for (WBStatues *status in result.statuses) {
            CellFrame *statusFrame=[[CellFrame alloc]init];
            statusFrame.statue=status;
            [statuesFrame addObject:statusFrame];
        }
        [self.statuesFrame addObjectsFromArray:statuesFrame];
        [self.tableView reloadData];
        //停止刷新
        [self.foot endRefreshing];
        self.tabBarItem.badgeValue=@"5";
    } failure:^(NSError *error) {
        //停止刷新
        [self.foot endRefreshing];
    }];


    
}
//下拉加载更新数据
-(void)LoadNewData{
    WBHomeStatusesParam *param=[[WBHomeStatusesParam alloc]init];
    param.access_token=[WBAccountTool Account].access_token;
    if (self.statuesFrame.count) {
        CellFrame *cellFrame=self.statuesFrame[0];
        //从哪一条开始读取
        param.since_id=@([cellFrame.statue.idstr longLongValue]);
    }
    param.count=@(5);
    [WBStatusTool HomeStatusWithParam:param success:^(WBHomeStatusesResult *result)  {
        NSMutableArray *statuesFrame=[NSMutableArray array];
        for (WBStatues *status in result.statuses) {
            CellFrame *statusFrame=[[CellFrame alloc]init];
            statusFrame.statue=status;
            [statuesFrame addObject:statusFrame];
        }
        //添加更新的数量显示按钮
        [self NewStatusCount:statuesFrame.count];
        //添加一个临时数组
        NSMutableArray *temArray=[NSMutableArray array];
        [temArray addObjectsFromArray:statuesFrame];
        [temArray addObjectsFromArray:self.statuesFrame];
        self.statuesFrame=temArray;
        [self.tableView reloadData];
        //停止刷新
        [self.header endRefreshing];
        //清除标记数字
        self.tabBarItem.badgeValue=nil;
    } failure:^(NSError *error) {
        //停止刷新
        [self.header endRefreshing];
    }];

}

//添加更新的数量显示按钮
-(void)NewStatusCount:(NSInteger)count{
    
    UIButton *btn=[UIButton buttonWithType: UIButtonTypeCustom];
    btn.userInteractionEnabled=NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background_os7"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    //添加在导航控制器上，在导航栏的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    if (count) {
        [btn setTitle:[NSString stringWithFormat:@"更新了%ld条微博",(long)count] forState:UIControlStateNormal];
    }else{
         [btn setTitle:@"没有更新的微博" forState:UIControlStateNormal];
    }
    CGFloat btnX=0;
    CGFloat btnW=self.view.frame.size.width;
    CGFloat btnH=30;
    CGFloat btnY=64-btnH;
    btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:1.0 animations:^{
        btn.transform=CGAffineTransformMakeTranslation(0, btnH);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
               [btn removeFromSuperview];
        }];
    }];
}
//初始化导航栏
-(void)setupNava{
    //1.设置左边的图标
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch_os7" highlightIcon:@"navigationbar_friendsearch_highlighted_os7"target:self action:@selector(friendsearch)];
    
    //2.设置右边的图标
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithIcon:@"navigationbar_pop_os7" highlightIcon:@"navigationbar_pop_highlighted_os7" target:self action:@selector(Pop)];
    
    //3.设置中间的按钮
    TitleButton *titleButton=[TitleButton buttonWithType:UIButtonTypeCustom];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
    if ([WBAccountTool Account].name) {
        [titleButton setTitle:[WBAccountTool Account].name forState:UIControlStateNormal];
    }else{
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.bounds=CGRectMake(0, 0, 100, 40);
    self.navigationItem.titleView=titleButton;
    self.titleButton=titleButton;
    
    //去掉分割线
    self.tableView.separatorStyle=UITableViewCellAccessoryNone;
}
-(void)titleClick:(TitleButton *)titleButton{
    
    if (titleButton.tag==1) {
         [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
        titleButton.tag=0;
    }else{
         [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
        titleButton.tag=1;
    }
}
-(void)friendsearch{
    NSLog(@"-friendsearch-");
}
-(void)Pop{
    NSLog(@"-Pop-");
}
 //2.获取用户信息
-(void)setupUserInfo{
    WBUserInfoParam *param=[[WBUserInfoParam alloc]init];
    
    param.access_token=[WBAccountTool Account].access_token;
    param.uid=@([WBAccountTool Account].uid);
    [WBUserTool UserWithPrama:param success:^(WBUserInforResult *result) {
        WBAccount *account=[WBAccountTool Account];
        account.name=result.name;
        if (account.name!=[WBAccountTool Account].name) {
            [self.titleButton setTitle:account.name forState:UIControlStateNormal];
            [WBAccountTool SetAccount:account];
        }

    } failure:^(NSError *error) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statuesFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    //设置微博模型
    cell.cellFrame=self.statuesFrame[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.statuesFrame[indexPath.row] cellHeight];
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UIViewController *vc=[[UIViewController alloc]init];
//    vc.view.backgroundColor=[UIColor redColor];
//    [self.navigationController pushViewController:vc animated:YES];
//}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
