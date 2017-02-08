
//
//  LDtest2222ViewController.m
//  HDJFKJ
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDtest2222ViewController.h"
#import "LDHaveCardListModel.h"
#import "LDBankCardViewCell.h"
#import "LDBankCardViewController.h"
#import "LDSubmitVCController.h"
#import "LDGoodsIDAndZhuanAnId.h"
#import "WHAddBankCardView.h"
#import "HDLoading.h"

/** 订单提交后返回的模型 */
#import "HDSumitOrderBack.h"

/** 请求银行卡结果模型 */
#import "HDBankResult.h"

@interface LDtest2222ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
//显示出来的银行卡的数组
@property (nonatomic,strong) NSMutableArray * cellDataArray;
@property (nonatomic,strong) LDBankCardViewCell * bankCell;
//底部的试图
@property (nonatomic,strong) UIView * footer;
@property (nonatomic,assign) int  cellCount;
@property (nonatomic, strong) UIButton * surButton;

@property (nonatomic,strong) NSString * bankID;

//获取的全部银行号数据数组
@property (nonatomic, strong) NSArray * dataArray;

//添加银行卡界面
@property (nonatomic, strong) WHAddBankCardView * addbankCardView;

@property (nonatomic, assign) float cellHeight;
@end

@implementation LDtest2222ViewController{
    NSIndexPath *CellIndexPath;
}

- (NSMutableArray *)cellDataArray
{
    if (!_cellDataArray) {
        
        _cellDataArray = [NSMutableArray array];
        
    }
    
    return _cellDataArray;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
    if(self.cellDataArray.count>0 && self.indexFlag != 41)
        
    {
        
        [self.tableview selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
        
        [self tableView:self.tableview didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];//实现点击第一行所调用的方法
        
    }
    
    
    

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor  = WHColorFromRGB(0xf0f0f0);
    
    
    self.navigationItem.title = @"我的银行卡";
    
    //1.获取银行卡请求
    [self sendRequestHaveCard];
    
    //2.创建底部的按钮试图
    [self creatFooterView];
    
    //3.创建添加银行卡试图
    self.addbankCardView = [WHAddBankCardView view];
    
    [self.view addSubview:self.addbankCardView];
    
    [self.addbankCardView.addBankCardButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.addbankCardView.frame = CGRectMake(0, 5, LDScreenWidth, 45);
  
    //4.显示银行卡tableView
    
    self.cellHeight = 110.0 * LDScreenWidth/375;
    
    self.tableview = [[UITableView alloc] init];
    
    [self.view addSubview:self.tableview];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview.frame = CGRectMake(0, 5, LDScreenWidth, 0);
    
    self.tableview.backgroundColor = WHColorFromRGB(0xf0f0f0);

    self.tableview.delegate = self;
    self.tableview.dataSource = self;

    
    //打回修改提价订类型，0表示受托支付，1表示现金贷
    NSString * loantype = [NSKeyedUnarchiver unarchiveObjectWithFile:LoanType];
    
    if ([self.fromWhewe isEqualToString:@"xianjindai"] || [loantype isEqualToString:@"1"]){
    
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"现金贷暂时只支持北京银行和建设银行银行卡" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    
    }
    
}

- (void)dealloc{

    LDLog(@"销毁银行卡列表控制器");
}


/**
 *  提交订单入口
 */
- (void)creatFooterView{
    
    UIView * footerVeiw = [[UIView alloc] init];
    
    footerVeiw.backgroundColor = WHColorFromRGB(0xf0f0f0);
    self.footer = footerVeiw;
    
    [self.view addSubview:footerVeiw];
    
    footerVeiw.frame = CGRectMake(0, LDScreenHeight - 130, LDScreenWidth, 130);
    
    if (self.indexFlag == 41) {
        
        self.footer.hidden = YES;
    }
  
    UILabel * note1 = [UILabel new];
    note1.numberOfLines = 0;
    [footerVeiw addSubview:note1];
    note1.textAlignment = NSTextAlignmentCenter;
    note1.text = @"选择银行卡用于还款,提交订单后不可修改银行卡,如需修改请联系客服";
    note1.textColor = WHColorFromRGB(0xa5a5a5);
    note1.font = [UIFont systemFontOfSize:13];
    [note1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerVeiw).offset(2*LDPadding);
        make.right.equalTo(footerVeiw).offset(-2*LDPadding);
        make.top.equalTo(footerVeiw).offset(2*LDPadding);
    }];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [footerVeiw addSubview:button];
    self.surButton = button;
    [button setBackgroundColor:WHColorFromRGB(0xd33a31)];
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerVeiw).offset(LDPadding);
        make.right.equalTo(footerVeiw).offset(-LDPadding);
        make.height.equalTo(45);
        make.top.equalTo(note1.bottom).offset(LDPadding);
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cellHeight;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return self.cellCount;
    
}
/**
 *  提交订单网络请求
 */
- (void)submitOrderRequest{
    
    
    NSString * url = [NSString stringWithFormat:@"%@order/submit",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    /**
     * token
     **/
    [params setObject:NULLSTR([LDUserInformation sharedInstance].token) forKey:@"token"];
    /**
     * id
     **/
    [params setObject:NULLOBJ([LDUserInformation sharedInstance].UserId) forKey:@"id"];

    /**
     * 申请价格
     **/
    if ([HDSubmitOrder shardSubmitOrder].applyAmount != nil) {
        [params setObject:[HDSubmitOrder shardSubmitOrder].applyAmount forKey:@"applyAmount"];
    }
    
    
    /**
     * 首付金额
     **/
    if ([HDSubmitOrder shardSubmitOrder].downpayment != nil) {
        [params setObject:[HDSubmitOrder shardSubmitOrder].downpayment forKey:@"downpayment"];
    }
    
    
    /**
     * 总价
     **/
    if ([HDSubmitOrder shardSubmitOrder].totalAmount != nil) {
        [params setObject:[HDSubmitOrder shardSubmitOrder].totalAmount forKey:@"totalAmount"];
    }
    
    
    /**
     * 商品包id
     **/
    if ([HDSubmitOrder shardSubmitOrder].packageId != nil) {
        [params setObject:[HDSubmitOrder shardSubmitOrder].packageId forKey:@"packageId"];
    }
    
    /**
     * 专案id
     **/
    if ([HDSubmitOrder shardSubmitOrder].caseId != nil) {
        [params setObject:[HDSubmitOrder shardSubmitOrder].caseId forKey:@"caseId"];
    }
    
    
    /**
     * 商户id
     **/
    if ([HDSubmitOrder shardSubmitOrder].businessId != nil) {
        [params setObject:[HDSubmitOrder shardSubmitOrder].businessId forKey:@"businessId"];
    }
    
    /**
     * 商品列表
     **/
    if ([HDSubmitOrder shardSubmitOrder].commoditys != nil) {
        [params setObject:[HDSubmitOrder shardSubmitOrder].commoditys forKey:@"commoditys"];
    }
    
    /**
     * 银行卡id
     **/
    [params setObject:self.bankID forKey:@"bankcardId"];
    
    
    /**
     * 线下渠道
     **/
    if ([HDSubmitOrder shardSubmitOrder].termial != nil) {
        [params setObject:@"termail" forKey:@"termial"];
    }
    
    /**
     * 打回修改订单id
     **/
    NSString * backOrderID = [NSKeyedUnarchiver unarchiveObjectWithFile:BackOrderID];
    if (![backOrderID isEqualToString:@""] ) {
        [params setObject:backOrderID forKey:@"orderNo"];
        //归档存储打回修改的订单ID,制空
        [NSKeyedArchiver archiveRootObject:@"" toFile:BackOrderID];
        [NSKeyedArchiver archiveRootObject:@"" toFile:LoanType];
    }
    
    
    [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
        if(error != nil){
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
       
            LDLog(@"%@",response);
            
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                
                [HDLoading dismissHDLoading];
                /** 4.解析订单id */
                if (backInfo.result != nil) {
                    HDSumitOrderBack * orderBack = [HDSumitOrderBack mj_objectWithKeyValues:backInfo.result];
                    
                    LDSubmitVCController * vc = [[LDSubmitVCController alloc] init];
                    vc.applyId = orderBack.applyId;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else{
                    [HDLoading showFailViewWithString:@"提交失败"];
                }
                
            }else{
                [HDLoading showFailViewWithString:backInfo.message];
            }
        }
    }];
}

/**
 *  提交订单Button点击事件
 */
- (void)buttonClick{
    
    
    if (self.bankID == nil) {

        [HDLoading showFailViewWithString:@"请选择银行卡"];
        
    }else{
        
        //打回修改提价订类型，0表示受托支付，1表示现金贷
        NSString * loantype = [NSKeyedUnarchiver unarchiveObjectWithFile:LoanType];
        
        if ([self.fromWhewe isEqualToString:@"xianjindai"] || [loantype isEqualToString:@"1"]) {//从薪金贷传过来，
            
            [HDLoading showWithImageWithString:@"正在提交"];

            [self sendCashLoanRequest];
            
        }
        else{//从我的过来
            [HDLoading showWithImageWithString:@"正在提交"];
            [self submitOrderRequest];
        }
    
    }
    
    
}
//发送现金待请求
- (void)sendCashLoanRequest{
    
    NSString * str = [NSString stringWithFormat:@"%@cashLoan/save",KBaseUrl];
   
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
        //打回修改提价订单号
        NSString * backOrderID = [NSKeyedUnarchiver unarchiveObjectWithFile:BackOrderID];
        
        //backOrderID != nil || backOrderID.length > 0 ||
        if (![backOrderID isEqualToString:@""]) {
            [_params setObject:backOrderID forKey:@"orderno"];
            //归档存储打回修改的订单ID,制空
            [NSKeyedArchiver archiveRootObject:@"" toFile:BackOrderID];
            [NSKeyedArchiver archiveRootObject:@"" toFile:LoanType];
        }
        
        [_params setObject:NULLSTR([LDUserInformation sharedInstance].token) forKey:@"token"];
        
        [_params setObject:NULLOBJ([LDUserInformation sharedInstance].UserId) forKey:@"id"];
        
    }
    
    [_params setObject:self.bankID forKey:@"bankcardId"];
    
    
    
    [[LDNetworkTools sharedTools] request:POST url:str params:_params callback:^(id response, NSError *error) {
        if (error != nil) {
            
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
            
        }else{
            
            LDLog(@"%@",response);
            
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            /** 4.code == 200请求成功 */
            if ([backInfo.errcode isEqualToString:@"200"]) {
                [HDLoading dismissHDLoading];
                
                if (backInfo.object != nil) {
                    HDSumitOrderBack * orderBack = [HDSumitOrderBack mj_objectWithKeyValues:backInfo.object];
                    LDSubmitVCController * vc = [[LDSubmitVCController alloc] init];
                    vc.applyId = orderBack.id;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            
            }else{
                // 显示失败信息

                [HDLoading showFailViewWithString:backInfo.msg];
            }
        }
        
    }];
    
}
/**
 *  添加银行卡
 */
- (void)addButtonClick{
    
    LDBankCardViewController * bankCard = [[LDBankCardViewController alloc] init];
    
    [bankCard setGobackBlock:^{
       //发送网络请求
        [self sendRequestHaveCard];
    }];
    
    [self.navigationController pushViewController:bankCard animated:YES];
   
}
/**
 *  返回cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LDHaveCardListModel * model = self.cellDataArray[indexPath.row];
    
    LDBankCardViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@""];
    
    if (!cell) {
        cell = [[LDBankCardViewCell alloc] init];
    }
    
    cell.selectImage.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bankName.text = model.bank;
    cell.bankNumber.text = model.cardtailno;
    cell.bankType.text = model.type;
    
    if (CellIndexPath != nil && CellIndexPath == indexPath){
        cell.selectImage.hidden = NO;
    };
    cell.contentView.backgroundColor = WHColorFromRGB(0xf0f0f0);
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (self.indexFlag != 41) {
        LDBankCardViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        LDHaveCardListModel * model = self.cellDataArray[indexPath.row];
        
        self.bankID  = model.id;
        
        if (indexPath.row != self.cellDataArray.count) {
            CellIndexPath = indexPath;
        }
        cell.selectImage.hidden = NO;
    }
 
}
/**
 *  点击cell,拿到银行卡号
 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.indexFlag != 41) {
        LDBankCardViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.selectImage.hidden = YES;
    }
}
/**
 *  获取银行卡信息
 */
- (void)sendRequestHaveCard{
    
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * url = [NSString stringWithFormat:@"%@person/bankcard/list",KBaseUrl];
    
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
           
            NSLog(@"=================%@",response);
            [HDLoading dismissHDLoading];
            
            
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                /** 4.解析银行卡信息 */
                if (backInfo.result != nil){
                    [self.cellDataArray removeAllObjects];
                    
                    HDBankResult * bankResult = [HDBankResult mj_objectWithKeyValues:backInfo.result];
                    
                    self.dataArray = [LDHaveCardListModel mj_objectArrayWithKeyValuesArray:bankResult.list];
                    
                    
                    [self.cellDataArray addObjectsFromArray:self.dataArray];
                
                }
                
                
                self.cellCount = (int)self.cellDataArray.count;
                
                //提交按钮隐藏
                if (self.footer.hidden) {
                    
                    if (self.cellCount * self.cellHeight > LDScreenHeight - 64 - 60) {
                        
                        [UIView animateWithDuration:0.35 animations:^{
                            //重新设置添加银行卡试图的frame
                            self.addbankCardView.frame = CGRectMake(0, LDScreenHeight  - 50 - 64, LDScreenWidth, 45);
                            
                            
                            //重新设置tableView的frame
                            self.tableview.frame = CGRectMake(0, 5, LDScreenWidth, LDScreenHeight - 254+130);
                        }];
                        
                        
                        
                    }else{
                        
                        [UIView animateWithDuration:0.35 animations:^{
                            self.tableview.frame = CGRectMake(0, 5, LDScreenWidth, self.cellCount * self.cellHeight);
                            self.addbankCardView.frame = CGRectMake(0, 10+ self.tableview.frame.size.height, LDScreenWidth, 45);
                        }];
                        
                    }
                    
                    
                    
                    //提交按钮不隐藏
                }else{
                    if (self.cellCount * self.cellHeight > LDScreenHeight - 64- 130 - 50) {
                        
                        [UIView animateWithDuration:0.35 animations:^{
                            //重新设置添加银行卡试图的frame
                            self.addbankCardView.frame = CGRectMake(0, LDScreenHeight - 130 - 50, LDScreenWidth, 45);
                            
                            //重新设置tableView的frame
                            self.tableview.frame = CGRectMake(0, 69, LDScreenWidth, LDScreenHeight - 254);
                        }];
                        
                    }else{
                        
                        [UIView animateWithDuration:0.35 animations:^{
                            self.tableview.frame = CGRectMake(0, 69, LDScreenWidth, self.cellCount * self.cellHeight);
                            self.addbankCardView.frame = CGRectMake(0, 74+ self.tableview.frame.size.height, LDScreenWidth, 45);
                        }];
                        
                    }
                    
                }
                
                
                
                [self.tableview reloadData];
                
                for (int i = 0; i < self.cellDataArray.count; i++) {
                    
                    LDHaveCardListModel * model = self.cellDataArray[i];
                    
                    LDLog(@"%@-%@",model.bank,model.cardtailno);
                    
                    if(self.cellDataArray.count>0)
                        
                    {
                        
                        [self.tableview selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                        
                        [self tableView:self.tableview didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];//实现点击第一行所调用的方法
                        
                    }
                    
                }
                
                
            }else{
            
                [HDLoading showFailViewWithString:backInfo.message];
            }
        }
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {  // 点击了“删除”
        
        
        LDHaveCardListModel * model = self.cellDataArray[indexPath.row];
        
        LDLog(@"%@",model.id);
        
        
        
        [HDLoading showWithImageWithString:@"正在加载"];
        
        NSString * url = [NSString stringWithFormat:@"%@person/bankcard/remove",KBaseUrl];
        
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        
        [params setObject:NULLSTR([LDUserInformation sharedInstance].token) forKey:@"token"];
        
        [params setObject:NULLOBJ([LDUserInformation sharedInstance].UserId) forKey:@"id"];
        
        [params setObject:model.id forKey:@"cardId"];
        
        
        [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
            
            if(error != nil){
                 /** 1.打印请求错误信息*/
                NSLog(@"%@",error);
            
                /** 2.请求错误提示  */
                [HDLoading showFailViewWithString:@"网络错误"];
                
                
            }else{
                

                NSLog(@"=================%@",response);

                /** 3.解析返回信息 */
                LDBackInformation * backInfor = [LDBackInformation mj_objectWithKeyValues:response];
                
                if ([backInfor.code isEqualToString:@"0"]) {
                    
                    
                    [HDLoading dismissHDLoading];

                    // 删除模型
                    [self.cellDataArray removeObjectAtIndex:indexPath.row];
                    
                    self.cellCount = (int)self.cellDataArray.count;
                    
                    
                    //提交按钮隐藏
                    if (self.footer.hidden) {
                        
                        if (self.cellCount * self.cellHeight > LDScreenHeight - 64 - 50) {
                            
                            [UIView animateWithDuration:0.35 animations:^{
                                //重新设置添加银行卡试图的frame
                                self.addbankCardView.frame = CGRectMake(0, LDScreenHeight  - 50, LDScreenWidth, 45);
                                
                                
                                //重新设置tableView的frame
                                self.tableview.frame = CGRectMake(0, 69, LDScreenWidth, LDScreenHeight - 254+130);
                            }];
                            
                            
                            
                        }else{
                            
                            [UIView animateWithDuration:0.35 animations:^{
                                self.tableview.frame = CGRectMake(0, 69, LDScreenWidth, self.cellCount * self.cellHeight);
                                self.addbankCardView.frame = CGRectMake(0, 74+ self.tableview.frame.size.height, LDScreenWidth, 45);
                            }];
                            
                        }
                        
                        
                        
                        //提交按钮不隐藏
                    }else{
                        if (self.cellCount * self.cellHeight > LDScreenHeight - 64- 130 - 50) {
                            
                            [UIView animateWithDuration:0.35 animations:^{
                                //重新设置添加银行卡试图的frame
                                self.addbankCardView.frame = CGRectMake(0, LDScreenHeight - 130 - 50, LDScreenWidth, 45);
                                
                                //重新设置tableView的frame
                                self.tableview.frame = CGRectMake(0, 69, LDScreenWidth, LDScreenHeight - 254);
                            }];
                            
                        }else{
                            
                            [UIView animateWithDuration:0.35 animations:^{
                                self.tableview.frame = CGRectMake(0, 69, LDScreenWidth, self.cellCount * self.cellHeight);
                                self.addbankCardView.frame = CGRectMake(0, 74+ self.tableview.frame.size.height, LDScreenWidth, 45);
                            }];
                            
                        }
                        
                    }
                    
                    

                    // 刷新表格
                    [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    
                }else if ([backInfor.code isEqualToString:@"-3"]){
                    
                    [HDLoading showFailViewWithString:@"该银行卡已绑定还款不可删除"];

                }else{
                
                    [HDLoading showFailViewWithString:backInfor.message];

                
                }
                
               
               
              
            }
        }];

        


    }
}

@end
