//
//  LDSecondViewController.m
//  北京互动金服科技
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//
#import "LDDiscoverViewCell.h"
#import "LDDiscoverViewController.h"
#import "LDDiscoverModel.h"
#import "LDDiscoverViewCell.h"
#import "MJRefresh.h"
#import "LDBusnessController.h"

@interface LDDiscoverViewController ()
/**
 *  数据源方法
 */
@property (nonatomic,strong) NSArray * dataArray;




@end

@implementation LDDiscoverViewController
static NSString * const LDDiscoverCell = @"LDDiscoverCell";

- (NSArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

#pragma mark - tabbleView初始化方法,返回Group模式
-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    return self;
}

/**
 *  头部间距
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;//section头部高度
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, 1)];
    
    view.backgroundColor = [UIColor clearColor];
    return view ;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    //初始化设置
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    


}

- (void)setupRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    //BackFooter
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreGoods)];
    
    self.tableView.mj_footer.hidden = YES;
}
- (void)loadMoreGoods{
    
    LDLogFunc;
}

/**
 *  初始化tabbleView
 */
- (void)setupTableView{
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDDiscoverViewCell class]) bundle:nil] forCellReuseIdentifier:LDDiscoverCell];
    //高度
    self.tableView.rowHeight = 190;
    
    //分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = LDBackroundColor;
}




/**
 *  网络请求
 */
- (void)sendRequest{
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * url = [NSString stringWithFormat:@"%@explore/businessList",KBaseUrl];
    
    [[LDNetworkTools sharedTools] request:POST url:url params:nil callback:^(id response, NSError *error) {
   
        if (error != nil) {
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
           
        }else{
            
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
            }
            [HDLoading dismissHDLoading];
            self.dataArray = [LDDiscoverResultModel mj_objectArrayWithKeyValuesArray:backInfo.result];
      
            LDLog(@"%@",response);

            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];

            
        }

    }];
    
}

/**
 *  每组多少行cell
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
/**
 *  返回cell
 */
- (LDDiscoverViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LDDiscoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LDDiscoverCell];

    LDDiscoverResultModel * resultModel = self.dataArray[indexPath.row];
    
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:resultModel.pic] placeholderImage:[UIImage imageNamed:@"750x360占位"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
 
//        LDLog(@"下载进度：%f", 1.0 * receivedSize / expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        LDLog(@"下载完成");
    }];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDDiscoverResultModel * resultModel = self.dataArray[indexPath.row];
    
    LDBusnessController * discoverVC = [[LDBusnessController alloc] init];
    
    NSString * a = resultModel.id;
    
    long b = [a longLongValue];
    
    [LDGoodsIDAndZhuanAnId sharedInstance].busnessID = [NSString stringWithFormat:@"%ld",b];
    
    [self.navigationController pushViewController:discoverVC animated:YES];
}


@end
