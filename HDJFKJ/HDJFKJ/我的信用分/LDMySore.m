//
//  LDMySore.m
//  HDJFKJ
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDMySore.h"
#import "LDMyScoreDown.h"
#import "LDMySoreModel.h"
#import "LDBaseInformationTableViewController.h"
#import "LDPostIDCard.h"
#import "LDContactInformationViewController.h"
#import "AuthorizViewController.h"
#import "LDGoodsDetailModel.h"
#import "LDPaymentPasswordController.h"
#import "WHScoreTopView.h"
#import "WHRotainView.h"
#import "WHWorkViewController.h"
#import "WHCustomInfoInfoStepAll.h"
#import "WHXinYongFenAgreementController.h"
#import "WHSaveAndReadInfomation.h"
#import "HDScoreModel.h"

@interface LDMySore ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;

/** cell  */
@property (nonatomic,strong) LDMyScoreDown * cell;
@property (nonatomic,assign) BOOL  IDcard;
@property (nonatomic,assign) BOOL  job;
@property (nonatomic,assign) BOOL  contact;
@property (nonatomic,assign) BOOL  Auto;
@property (nonatomic,assign) BOOL  pay;

//顶部试图
@property (nonatomic, strong) WHScoreTopView * topView;
@property (nonatomic, strong) UIView * backgroundView;

@property (nonatomic, strong) WHRotainView * rotainView;

//信息完善度模型
@property (nonatomic, strong) WHCustomInfoInfoStepAll * customInfo;

@end

@implementation LDMySore
static NSString * const LDSoreTop = @"SoreTop";
static NSString * const LDSoreDown = @"SoreDown";

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([self.customInfo.payPwdInfo isEqualToString:@"1"]) {//已经设置支付密码
//        
//        
//        
//    }else{//未设置支付密码
//        
//        [HDLoading showFailViewWithString:@"支付密码未设置"];
//        
//        LDPaymentPasswordController * vc = [[LDPaymentPasswordController alloc] init];
//        
//        vc.fromeWhere = @"xinyongfen";
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }
    
    if (indexPath.section ==0) {
        
        if (indexPath.row == 0) {//基本信息
            
            
            //统计买点
            [WHTongJIRequest sendTongjiRequestWithBusinessId:nil oprType:SFZXXZL];
            
            LDPostIDCard * cardVC = [[LDPostIDCard alloc] init];
            
            cardVC.fromeWhere = @"xinyongfen";
            
            if ([self.customInfo.advancedInfo isEqualToString:@"1"]) {
                cardVC.requestImage = YES;
            }
            else{
                cardVC.requestImage = NO;
            }
            if ([self.customInfo.basicInfo isEqualToString:@"1"]) {
                cardVC.sendUserMessage = YES;
            }
            
            
            [self.navigationController pushViewController:cardVC animated:YES];
            
        }else if (indexPath.row == 1){//从业信息
            
            //统计买点
            [WHTongJIRequest sendTongjiRequestWithBusinessId:nil oprType:CYXXZL];
            
            if ([self.customInfo.basicInfo isEqualToString:@"1"]) {
                WHWorkViewController * type = [[WHWorkViewController alloc] init];
                
                
                type.fromeWhere = @"xinyongfen";
                type.workInfo = self.customInfo.workInfo;
                
                [self.navigationController pushViewController:type animated:YES];
            }
            else{
                [HDLoading showFailViewWithString:@"请先完善基本信息"];
            }
            
            
            
        }else if (indexPath.row == 2){//联系人信息
            
            //统计买点
            [WHTongJIRequest sendTongjiRequestWithBusinessId:nil oprType:LXRXXZL];
            
            if ([self.customInfo.basicInfo isEqualToString:@"1"]) {
                
                LDContactInformationViewController * contact = [[LDContactInformationViewController alloc] init];
                
                contact.isFinsh = self.customInfo.contactInfo;
                
                contact.fromeWhere = @"xinyongfen";
                
                [self.navigationController pushViewController:contact animated:YES];
            }
            else{
                
                [HDLoading showFailViewWithString:@"请先完善基本信息"];
            }
            
            
        }else{//授权信息
            
            //统计买点
            [WHTongJIRequest sendTongjiRequestWithBusinessId:nil oprType:SQXXZL];
            
            if ([self.customInfo.basicInfo isEqualToString:@"1"]) {
                AuthorizViewController * vc = [[AuthorizViewController alloc] init];
                
                vc.fromWhere = @"xinyongfen";
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                [HDLoading showFailViewWithString:@"请先完善基本信息"];
            }
            
        }
        
    }
    
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
    
    //刷新信息完整度
    [self sendRequest];
   
}
- (void)viewDidLoad{
    
    self.view.backgroundColor = WHColorFromRGB(0xf0f0f0);
    
    [super viewDidLoad];
    
    self.title = @"我的资料";
    
    //1.创建顶部的信用分试图
    self.topView = [WHScoreTopView view];
    self.topView.frame = CGRectMake(0, 0, LDScreenWidth, 100*LDScreenWidth/375);
    [self.view addSubview:self.topView];
    
    //2.创建tableView
    [self setupTableview];
    
    
    [self createLeftNavButton];
}


//3.创建导航栏左侧按钮
- (void)createLeftNavButton{
    
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30 , 40)];
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(clickNavLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 缩小控件与屏幕的间距 */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    //作为Item的子视图添加上去
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
     self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: negativeSpacer,leftItem, nil];
    
}
- (void)clickNavLeftButton:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{

    NSLog(@"dealloc-----mysore");
}

/**
 *  获取用户信息完成程度
 */
- (void)sendRequest{
    
    [HDLoading showWithImageWithString:@"正在加载"];
    NSString * url = [NSString stringWithFormat:@"%@customInfo/infoStepAll",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    
    [params setObject:NULLSTR([LDUserInformation sharedInstance].token) forKey:@"token"];
    
    [params setObject:NULLOBJ([LDUserInformation sharedInstance].UserId) forKey:@"id"];
    
    
    [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
        if(error != nil){
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
        
            LDLog(@"%@",response);
            
            /** 1.解析返回信息*/
            LDBackInformation * model = [LDBackInformation mj_objectWithKeyValues:response];
            
            
            if ([model.code isEqualToString:@"0"]) {
                
                /** 2.解析完善程度数据 */
                if (model.result != nil)
                {
                    self.customInfo = [WHCustomInfoInfoStepAll mj_objectWithKeyValues:model.result];
                    
                    /** 3.获取信用分*/
                    [self getCreditScore];
                }
                
            }
            else{
                [HDLoading showFailViewWithString:model.message];
            }
        }
        
    }];
}
- (void)rightButtonClick{

    WHXinYongFenAgreementController * vc = [[WHXinYongFenAgreementController alloc]initWithURL:@"http://123.56.233.192/appagree/creditScore.html" title:@"信用分帮助"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setupTableview{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"帮助" target:self action:@selector(rightButtonClick)];
    
    UITableView * tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.frame.size.height, LDScreenWidth, LDScreenHeight - self.topView.frame.size.height - 64) style:UITableViewStyleGrouped];
    
    tabbleView.backgroundColor = [UIColor clearColor];
    tabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabbleView];
    
    tabbleView.delegate = self;
    tabbleView.dataSource = self;
    
    self.tableView = tabbleView;
    
    //注册
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDMyScoreDown class]) bundle:nil] forCellReuseIdentifier:LDSoreDown];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
/**
 *  返回多少行cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:LDSoreDown];
    
    NSArray * imageNameArr = @[@"xinyongfen_shenfen",@"xinyongfen_congye",@"xinyongfen_lianxiren",@"shouquan_shouquan"];
    
    self.cell.leftImage.image = [UIImage imageNamed:imageNameArr[indexPath.row]];
    
    NSArray * lableTextArr = @[@"身份证信息",@"从业信息",@"联系人信息",@"授权信息"];
    
    self.cell.whichInfor.text = lableTextArr[indexPath.row];
    
    if (indexPath.row == 0) {
        
        if ([self.customInfo.basicInfo isEqualToString:@"1"]) {
            
            self.cell.isCompleted.textColor = [UIColor grayColor];
            
            self.cell.isCompleted.text = @"已完善";

        }else{
            
            self.cell.isCompleted.textColor = WHColorFromRGB(0x4279d6);
            self.cell.isCompleted.text = @"未完善";
        }
        
    }else if(indexPath.row == 1){
        
        if ([self.customInfo.workInfo isEqualToString:@"1"]) {
            self.cell.isCompleted.textColor = [UIColor grayColor];
            self.cell.isCompleted.text = @"已完善";
            
        }else{
            
        self.cell.isCompleted.textColor = WHColorFromRGB(0x4279d6);
            
            self.cell.isCompleted.text = @"未完善";
            
        }
        
        
    }else if (indexPath.row == 2){
        
        
        if ([self.customInfo.contactInfo isEqualToString:@"1"]) {
            
            self.cell.isCompleted.textColor = [UIColor grayColor];
            
            self.cell.isCompleted.text = @"已完善";
            
        }else{
            self.cell.isCompleted.textColor = WHColorFromRGB(0x4279d6);
            self.cell.isCompleted.text = @"未完善";
            
        }
        
        
    }else {
        
        self.cell.line.hidden = YES;
        if ([self.customInfo.authInfo isEqualToString:@"1"]) {
            
            self.cell.isCompleted.textColor = [UIColor grayColor];
            
            self.cell.isCompleted.text = @"已完善";
            
        }else{
            
            self.cell.isCompleted.textColor = WHColorFromRGB(0x4279d6);
            self.cell.isCompleted.text = @"未完善";
            
        }
    }
    return self.cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 28;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

- (void)createAddCreditViewWith:(float)chazhi newScore:(NSString *)newScore{
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];;
    
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self.backgroundView];
    
    WHRotainView * rotainView = [WHRotainView view];
    rotainView.frame = CGRectMake((LDScreenWidth - 261)/2, LDScreenHeight, 261, 300);
    
    [self.backgroundView addSubview:rotainView];
    
    [UIView animateWithDuration:0.5 animations:^{
        rotainView.frame = CGRectMake((LDScreenWidth - 261)/2, (LDScreenHeight -300)/2, 261, 300);
    } completion:^(BOOL finished) {
        
        [NSThread sleepForTimeInterval:0.25];
        
        [rotainView imageRotain];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(131, 245, 130, 55)];
        [rotainView addSubview:button];
        
        [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [rotainView.buzaitishiButton addTarget:self action:@selector(buzaitishi:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(190  , 170, 50, 18)];
        if (chazhi > 0) {
            label.text = [NSString stringWithFormat:@"+%.0f",chazhi];
        }
        else{
            label.text = [NSString stringWithFormat:@"%.0f",chazhi];
        }
        
        label.textColor = WHColorFromRGB(0xfb9b40);
        label.font = [UIFont systemFontOfSize:18];
        [rotainView addSubview:label];
        label.alpha = 0.0;
        
        
        [UIView animateWithDuration:0.7 animations:^{
            label.frame = CGRectMake(190, 70, 50, 18);
            label.alpha = 1.0;
        } completion:^(BOOL finished) {
            [NSThread sleepForTimeInterval:0.25];
            self.topView.scoreLabel.text = label.text;
            [UIView animateWithDuration:0.5 animations:^{
                self.topView.scoreLabel.transform = CGAffineTransformMakeScale(1.3, 1.3);
            } completion:^(BOOL finished) {
                [NSThread sleepForTimeInterval:0.25];
                self.topView.scoreLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.topView.scoreLabel.text = newScore;
                
            }];
        }];
    }];
}

- (void)cancel:(UIButton *)sender{
    [self.backgroundView removeFromSuperview];
}
- (void)buzaitishi:(UIButton *)sender{
    [self.backgroundView removeFromSuperview];
    //存储用户不在提示信用分动画
    [WHSaveAndReadInfomation saveXYFAnimation:@"1"];
}
/**
 * 获取信用分请求
 **/
#pragma mark -- 获取信用分
- (void)getCreditScore{
    
    NSString * str = [NSString stringWithFormat:@"%@customInfo/getCreditScore",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    
    
    [[LDNetworkTools sharedTools] request:POST url:str params:params callback:^(id response, NSError *error) {
        if (error != nil) {
            
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
        
        }
        else
        {
             NSLog(@"%@",response);
            
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                [HDLoading dismissHDLoading];
               
                /** 4.解析信用分  */
                if (backInfo.result != nil) {
                    HDScoreModel * scoreModel = [HDScoreModel mj_objectWithKeyValues:backInfo.result];
                    
                    if (scoreModel.creditScore == nil) {
                        scoreModel.creditScore = @"100";
                    }
                    
                    /** 5.获取旧的信用分 */
                    NSString * score = [WHSaveAndReadInfomation readXinYongFen];
                    NSArray * array = [score componentsSeparatedByString:@"-"];
                    score = array[0];
                    
                    /** 6.获取是否不在提示 */
                    NSString * prompt = [WHSaveAndReadInfomation readXYFAnimation];
                    /** 7.信用分差值 */
                    float difference = [scoreModel.creditScore floatValue] - [score floatValue];
                    
                    
                    
                    /** 8.差值不等于0并且提示，弹出信用分的窗 */
                    if (difference > 0 && ![prompt isEqualToString:@"1"]) {
                        
                        /** 9.创建弹窗  */
                        [self createAddCreditViewWith:difference newScore:scoreModel.creditScore];
                    }
                    else
                    {
                        self.topView.scoreLabel.text = scoreModel.creditScore;
                    }
                    
                    /** 9.存储新的信用分*/
                    NSString * nesScore = [NSString stringWithFormat:@"%@-%@",scoreModel.creditScore,scoreModel.level];
                    [WHSaveAndReadInfomation saveXinYongFen:nesScore];
                }else{
                    self.topView.scoreLabel.text = @"100";
                }
                
                
                [self.tableView reloadData];
            }else{
                
                /** 10.请求异常提示 */
                [HDLoading showFailViewWithString:backInfo.message];
            }
        }
    }];
    
}

@end
