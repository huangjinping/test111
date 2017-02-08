//
//  LDThirdViewController.m
//  北京互动金服科技
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDThirdViewController.h"
#import "WHPayBackTopView.h"
#import "WHPayBackChooseView.h"
#import "WHPayBackCell.h"
#import "WHPayBackModel.h"
#import "WHChekListController.h"

#import "LDSignInViewController.h"
#import "LDBusnessController.h"
#import "HDPayBackCommodity.h"
#import "LDNavgationVController.h"

/** 请求账单模型*/
#import "HDOrderRepays.h"

@interface LDThirdViewController ()<UITableViewDataSource,UITableViewDelegate>
//顶部还款提示试图
@property (nonatomic, strong) WHPayBackTopView * topView;
//还款状态选择视图
@property (nonatomic, strong) WHPayBackChooseView * chooseView;
//还款信息列表
@property (nonatomic, strong) UITableView * payBackTableView;

//还款状态
@property (nonatomic, strong) NSString * payBackStatus;

//订单模型数组
@property (nonatomic, strong) NSMutableArray * orderListArray;

//没有数据的试图
@property (nonatomic, strong) UIView * nullDataView;

//无账单提示内容
@property (nonatomic, strong) UILabel * nullDataLabel;
//无账单提示label
@property (nonatomic, strong) UILabel * bottomLabel;
//登录按钮
@property (nonatomic, strong) UIButton * loginButton;

@property (nonatomic, assign) BOOL isHaveRequest;

@end

@implementation LDThirdViewController

- (NSMutableArray *)orderListArray{
    if (!_orderListArray) {
        _orderListArray = [[NSMutableArray alloc]init];
    }
    return _orderListArray;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //设置导航栏字体为白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_3.0"] forBarMetrics:UIBarMetricsDefault];
    //设置状态栏的前景色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_white_3.0"] forBarMetrics:UIBarMetricsDefault];
    //设置状态栏的前景色为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //设置导航栏字体颜色为黑色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    if ([LDUserInformation sharedInstance].UserId != nil && [LDUserInformation sharedInstance].token != nil && self.isHaveRequest == NO) {
        
        self.isHaveRequest = YES;
        [self sendRequest];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单";
    self.payBackStatus = @"10";
    
    self.isHaveRequest = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.顶部的还款提示视图
    [self createTopView];
    
    //2.还款状态选择视图
    [self createChooseView];
    
    //3.还款列表
    [self createPayBackTableView];
    
    //4.创建无数据试图
    [self createNullDataView];

    
    if ([LDUserInformation sharedInstance].token == nil || [LDUserInformation sharedInstance].UserId == nil) {
        self.nullDataView.hidden = NO;
        self.nullDataLabel.text = @"您还未登录";
        self.loginButton.userInteractionEnabled = YES;
        self.bottomLabel.text = @"点击登录获取数据";
        
    }else{
        
        self.isHaveRequest = YES;
        
        [self sendRequest];
    }
    
}



//1.创建顶部还款提示试图
- (void)createTopView{
    
    self.topView = [WHPayBackTopView view];
    self.topView.frame = CGRectMake(0, 0, LDScreenWidth, 110*LDScreenWidth/375);
    [self.view addSubview:self.topView];
    
}
//2.创建选择还款状态视图
- (void)createChooseView{

    self.chooseView  = [WHPayBackChooseView view];
    self.chooseView.frame = CGRectMake(0,  self.topView.frame.size.height, LDScreenWidth, 40);
    [self.view addSubview:self.chooseView];

    
    [self.chooseView.leftButton addTarget:self action:@selector(clickChooseViewLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseView.rightButton addTarget:self action:@selector(clickChooseViewRightButton:) forControlEvents:UIControlEventTouchUpInside];
    self.chooseView.leftButton.selected = YES;
    self.chooseView.rightLabel.hidden = YES;
    
}

//2.1.选择未还款按钮
- (void)clickChooseViewLeftButton:(UIButton *)sender{
    
    if ([LDUserInformation sharedInstance].token != nil && [LDUserInformation sharedInstance].UserId != nil) {
        sender.selected = YES;
        self.chooseView.rightButton.selected = NO;
        self.chooseView.leftLabel.hidden = NO;
        self.chooseView.rightLabel.hidden = YES;
        
        self.payBackStatus = @"10";
        [self sendRequest];
    }
    
}

//2.2.选择已完成按钮
- (void)clickChooseViewRightButton:(UIButton *)sender{
    
    if ([LDUserInformation sharedInstance].token != nil && [LDUserInformation sharedInstance].UserId != nil) {
        sender.selected = YES;
        self.chooseView.leftButton.selected = NO;
        
        self.chooseView.rightLabel.hidden = NO;
        self.chooseView.leftLabel.hidden = YES;
        self.payBackStatus = @"20";
        [self sendRequest];
    }
    
}

//3.创建还款列表
- (void)createPayBackTableView{
    self.payBackTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.chooseView.frame.origin.y + self.chooseView.frame.size.height , self.view.frame.size.width, self.view.frame.size.height - (self.chooseView.frame.origin.y + self.chooseView.frame.size.height + 50))];
    self.payBackTableView.delegate = self;
    self.payBackTableView.dataSource = self;
    self.payBackTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.payBackTableView];

}

//创建无账单的试图
- (void)createNullDataView{
    self.nullDataView = [[UIView alloc]initWithFrame:CGRectMake(0, self.chooseView.frame.origin.y + self.chooseView.frame.size.height , self.view.frame.size.width, self.view.frame.size.height - (self.chooseView.frame.origin.y + self.chooseView.frame.size.height + 50))];
    
    self.nullDataView.backgroundColor = WHColorFromRGB(0xf5f5f9);
    
    UIImageView * nullImageView = [[UIImageView alloc]initWithFrame:CGRectMake((LDScreenWidth-80)/2, (self.nullDataView.frame.size.height - 80)/2-57, 80, 80)];
    NSLog(@"%f",nullImageView.frame.origin.y);
    nullImageView.image = [UIImage imageNamed:@"firstpage_noLogin"];
    [self.nullDataView addSubview:nullImageView];
    self.nullDataView.hidden = YES;
    
    self.nullDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, nullImageView.frame.origin.y + 80 + 16, LDScreenWidth, 17)];
    self.nullDataLabel.text = @"暂无账单";
    self.nullDataLabel.font = [UIFont systemFontOfSize:13];
    self.nullDataLabel.textAlignment = NSTextAlignmentCenter;
    self.nullDataLabel.textColor = WHColorFromRGB(0x051b28);
    [self.nullDataView addSubview:self.nullDataLabel];
    
    self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, nullImageView.frame.origin.y + 80 + 16 + 17 +15, LDScreenWidth, 13)];
    self.bottomLabel.text = @"";\
    self.bottomLabel.font = [UIFont systemFontOfSize:13];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.textColor = WHColorFromRGB(0xc8c7cc);
    [self.nullDataView addSubview:self.bottomLabel];
    
    [self.view addSubview:self.nullDataView];
    
    self.loginButton = [[UIButton alloc]initWithFrame:CGRectMake((LDScreenWidth-80)/2, (self.nullDataView.frame.size.height - 80- 57)/2, 80,137)];
    [self.loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.nullDataView addSubview:self.loginButton];
    self.loginButton.userInteractionEnabled = NO;
}
- (void)clickLoginButton{
    LDSignInViewController * loginVC = [[LDSignInViewController alloc]init];
    
    LDNavgationVController * nav = [[LDNavgationVController alloc]initWithRootViewController:loginVC];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    

}

#pragma mark ---  tableVIew的协议方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderListArray.count;

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 180.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WHPayBackCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WHPayBackCell" owner:nil options:nil]lastObject];
    
    }
    WHPayBackModel * payBackModel = self.orderListArray[indexPath.section];
    
    cell.remaindayLabel.text = [NSString stringWithFormat:@"剩余%@天",payBackModel.remainday];
    
    if (payBackModel.commoditys.count > 0) {
        HDPayBackCommodity * commodity = payBackModel.commoditys[0];
        
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:commodity.pic] placeholderImage:[UIImage imageNamed:@"商品 1:1"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            LDLog(@"下载进度：%f", 1.0 * receivedSize / expectedSize);
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            LDLog(@"下载完成");
        }];
        
    }
    
    cell.picImageView.layer.cornerRadius = 0.0;
    cell.picImageView.layer.borderColor = [WHColorFromRGB(0xf0f0f0) CGColor];
    cell.picImageView.layer.borderWidth = 0.5f;
    
    
    NSMutableString * commodityName = [[NSMutableString alloc]init];
    for (HDPayBackCommodity * commodity in payBackModel.commoditys) {
        if (commodityName.length == 0) {
            [commodityName appendString:commodity.commodityName];
        }
        else{
            [commodityName appendString:@","];
            [commodityName appendString:commodity.commodityName];
        }
    }
    
    cell.commoditynameLabel.text = commodityName;
    cell.ordernoLabel.text = payBackModel.orderno;
    cell.timeLabel.text = payBackModel.time;
    cell.perioddebtLabel.text = [NSString stringWithFormat:@"¥%@",payBackModel.perioddebt];
    
    //已完成的账单
    if ([self.payBackStatus isEqualToString:@"20"]) {
        cell.periodDescibeLabel.text = [NSString stringWithFormat:@"%@期",payBackModel.duration];
        cell.remaindayLabel.hidden = YES;
        cell.huankuantishiLabel.text = @"已还清";
        cell.perioddebtLabel.hidden = YES;
    }else{
        cell.periodDescibeLabel.text = [NSString stringWithFormat:@"%@/%@期",payBackModel.currentperiod,payBackModel.duration];
        cell.remaindayLabel.hidden = NO;
        cell.huankuantishiLabel.text = @"本月代还款金额";
        cell.perioddebtLabel.hidden = NO;
    }
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    WHChekListController * checkController = [[WHChekListController alloc]init];
    //checkController.payBackModel = self.orderListArray[indexPath.section];
    WHPayBackModel * payBackModel = self.orderListArray[indexPath.section];
    checkController.payBackID = payBackModel.id;
    [self.navigationController pushViewController:checkController animated:YES];

}


//网络请求
- (void)sendRequest{
    
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * str = [NSString stringWithFormat:@"%@order/repays",KBaseUrl ];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    [params setObject:self.payBackStatus forKey:@"status"];
    
    [[LDNetworkTools sharedTools] request:POST url:str params:params callback:^(id response, NSError *error) {
        
        if (error != nil) {
            
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
        
        }else{
            
            [HDLoading dismissHDLoading];
            
            LDLog(@"%@",response);
            
            /** 3.解析返回信息*/
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                /** 4.解析账单 */
                HDOrderRepays * orderRepays = [HDOrderRepays mj_objectWithKeyValues:backInfo.result];
                
                if (orderRepays.perioddebt != nil ) {
                    self.topView.payBackMoneyLabel.text = [NSString stringWithFormat:@"%@",orderRepays.perioddebt] ;
                }
                
                self.orderListArray = [WHPayBackModel mj_objectArrayWithKeyValuesArray:orderRepays.list];
                
                
                //如果账单数量大于0，隐藏无账单试图
                if (self.orderListArray.count > 0) {
                    
                    self.nullDataView.hidden = YES;
                    [self.payBackTableView reloadData];
                    
                }
                //如果
                else{
                    
                    [self.nullDataView removeFromSuperview];
                    
                    [self createNullDataView];
                    
                    self.nullDataView.hidden = NO;
                }
      
            }else{
                [self.nullDataView removeFromSuperview];
                
                [self createNullDataView];
                
                self.nullDataView.hidden = NO;
            
            }
     
        }
    }];
}









@end
