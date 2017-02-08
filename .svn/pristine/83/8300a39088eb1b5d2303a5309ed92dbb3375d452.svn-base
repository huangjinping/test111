//
//  LDOrderDetailViewController.m
//  HDJFKJ
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDOrderDetailViewController.h"
#import "LDTabBarController.h"
#import "LDOrderDetailModel.h"
#import "LDBaseInformationTableViewController.h"
#import "WHChekListController.h"
#import "WHZhiFuTanChuangView.h"
#import "WHCashSuccessController.h"
#import "WHComfierOrderPassword.h"
#import "LDPostIDCard.h"



@interface LDOrderDetailViewController ()<UIAlertViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong) UIView * goodsView;
@property (nonatomic,strong) LDOrderDetailModel * OrderDetailModel;

/**
 *  商户名称,最上部
 */
@property (nonatomic,strong) UILabel * bussnessName;
/**
 *  商品名称,
 */
@property (nonatomic,strong) UILabel * goodsNameLable;
/**
 *  订单号
 */
@property (nonatomic,strong) UILabel * classLableDetail;
/**
 *  下单时间,
 */
@property (nonatomic,strong) UILabel * timeLableText;
/**
 *  总价格
 */
@property (nonatomic,strong) UILabel * sumPrice;

/**
 *  首付 + ...
 */
@property (nonatomic,strong) UILabel * firstPay;
/**
 *  订单状态
 */
@property (nonatomic,strong) UILabel * changeLable;
/**
 *  还款银行卡类型
 */
@property (nonatomic,strong) UILabel * bankCardType;
/**
 *  还款银行卡尾号
 */
@property (nonatomic,strong) UILabel * bankCardNumber;


//查看账单视图
@property (nonatomic,strong) UIView * checkView;


//确认按钮
@property (nonatomic,strong) UIButton * sureButton;

//根据不同的订单状态提示信息的Label
@property (nonatomic, strong) UILabel * note;
//根据不同的订单状态提示信息的Label
@property (nonatomic, strong) UILabel * dahuiNote;


@end

@implementation LDOrderDetailViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
/**
 *  界面元素赋值
 */
- (void)reloadData{
 
    if ([self.OrderDetailModel.status isEqualToString:@"还款中"] || [self.OrderDetailModel.status isEqualToString:@"已完成"]){
        self.checkView.hidden = NO;
        self.note.hidden = YES;
        self.sureButton.hidden = YES;
        
    }
    if ([self.OrderDetailModel.status isEqualToString:@"已支付"]) {
        self.checkView.hidden = YES;
        self.note.hidden = YES;
        self.sureButton.hidden = YES;
        self.note.text  = @"正在为您的生成分期账单，请耐心等待！";
    }
    if ([self.OrderDetailModel.status isEqualToString:@"已通过"]){
        [self.sureButton setBackgroundColor:WHColorFromRGB(0xd33a31)];
        [self.sureButton setTitle:@"去支付" forState:UIControlStateNormal];
        self.sureButton.userInteractionEnabled = YES;
        self.sureButton.hidden = NO;
        self.note.hidden = NO;
        self.note.text  = @"确认购买商品即去支付，支付后分期账单即将生成!";
        self.checkView.hidden = YES;
    }
    
    if ([self.OrderDetailModel.status isEqualToString:@"已打回"]) {
        self.checkView.hidden = YES;
        self.sureButton.userInteractionEnabled = YES;
        [self.sureButton setBackgroundColor:WHColorFromRGB(0xd33a31)];
        [self.sureButton setTitle:@"修改信息" forState:UIControlStateNormal];
        self.note.text =[NSString stringWithFormat:@"您的订单被打回，打回原因：%@",self.OrderDetailModel.feedback] ;
        self.note.numberOfLines = 0;
        
    }
    if ([self.OrderDetailModel.status isEqualToString:@"已取消"] ){
        self.checkView.hidden = YES;
        self.note.hidden = NO;
        self.sureButton.hidden = YES;
        self.note.text =[NSString stringWithFormat:@"您的订单已取消，取消原因：%@",self.OrderDetailModel.feedback] ;
        self.note.numberOfLines = 0;
    }
    if ( [self.OrderDetailModel.status isEqualToString:@"已拒绝"]){
        self.checkView.hidden = YES;
        self.note.hidden = NO;
        self.sureButton.hidden = YES;
        self.note.text =[NSString stringWithFormat:@"您的订单被拒绝，拒绝原因：%@",self.OrderDetailModel.feedback] ;
        self.note.numberOfLines = 0;
    }
    
    //受托支付订单隐藏确认按钮，不再有确认订单流程
    if ([self.OrderDetailModel.loanType isEqualToString:@"0"] && ![self.OrderDetailModel.status isEqualToString:@"已打回"]) {
        
            self.sureButton.hidden = YES;
        
    }
    
    self.bussnessName.text = self.OrderDetailModel.businessName;
    
    self.goodsNameLable.text = self.OrderDetailModel.commodityname;
    
    self.classLableDetail.text = self.OrderDetailModel.orderNo;
    
    self.timeLableText.text = self.OrderDetailModel.time;
    self.sumPrice.text = [NSString stringWithFormat:@"¥%.2f",[self.OrderDetailModel.totalPrice floatValue]];

    self.changeLable.text = self.OrderDetailModel.status;
    
    //首付金额
    NSString * payment = @"";
    if ([self.OrderDetailModel.downpayment isEqualToString:@"<null>"] || [self.OrderDetailModel.downpayment isEqualToString:@"(null)"] || [self.OrderDetailModel.downpayment isEqualToString:@""] || self.OrderDetailModel.downpayment == nil || [self.OrderDetailModel.downpayment floatValue] == 0) {
        payment = @"0首付";
    }else{
        payment = [NSString stringWithFormat:@"首付%.2f",[self.OrderDetailModel.downpayment floatValue]];
    }
    
    self.firstPay.text = [NSString stringWithFormat:@"%@ + ¥%.2f x %@期",payment,[self.OrderDetailModel.periodAmount floatValue],self.OrderDetailModel.duration];
 
    self.bankCardType.text = self.OrderDetailModel.bankName;
    self.bankCardNumber.text = [NSString stringWithFormat:@"(尾号%@)",self.OrderDetailModel.cardNo];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = WHColorFromRGB(0xf0f0f0);
    self.navigationItem.title  =@"订单详情";

    self.tabBarController.tabBar.hidden = YES;
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(beiYinH5success) name:@"beiYinH5success" object:nil];
    
    //订单详情上部view
    [self creatHeaderView];
    
    //需要改变状态的View:首付.. 已通过
    [self creatNeddToChangeView];
    
    [self creatConformOrder];
}

- (void)beiYinH5success{
    //webViewH5页面提交成功,刷新数据,并push到下一页
    
    [self reloadSendRequest];
    
    WHComfierOrderPassword * confirmPassword = [[WHComfierOrderPassword alloc]init];
    
        confirmPassword.orderDetailModel = self.OrderDetailModel;
    
    [self.navigationController pushViewController:confirmPassword animated:YES];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"beiYinH5success" object:nil];
    
    
}

-(void)setApplyId:(NSString *)applyId{

    _applyId = applyId;
    
    [self sendRequest];
}


//订单详情--网络请求
- (void)sendRequest{

    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * url = [NSString stringWithFormat:@"%@order/detail",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:self.applyId forKey:@"applyId"];
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    
    [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
        if(error != nil){
            
            [HDLoading showFailViewWithString:@"网络错误"];
            LDLog(@"%@",error);
        }else{
            LDLog(@"%@",response);
            
            [HDLoading dismissHDLoading];

            LDOrderDetailBackModel * backModel = [LDOrderDetailBackModel mj_objectWithKeyValues:response];
            
            LDLog(@"%@--%@",backModel.code,backModel.message);

            self.OrderDetailModel = [LDOrderDetailModel mj_objectWithKeyValues:response[@"result"]];
            
            
           
            
            //刷新数据===赋值
            [self reloadData];
            
        }
    }];
}
//H5页面加载完毕,不需要指示器,刷新订单数据
- (void)reloadSendRequest{
    
    
    NSString * url = [NSString stringWithFormat:@"%@order/detail",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:self.applyId forKey:@"applyId"];
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    
    [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
        
        if(error != nil){
            
        }else{
            
            
            self.OrderDetailModel = [LDOrderDetailModel mj_objectWithKeyValues:response[@"result"]];
            
            
            //刷新数据===赋值
            [self reloadData];
            
        }
    }];
}
- (UIView *)creatHeaderView{
 
        //section头部view
    UIView * sectionHeaderView = [[UIView alloc]init];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sectionHeaderView];
    [sectionHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(45);
    }];
    
        //上部imageView
        UIImageView * topImageView = [[UIImageView alloc] init];
        topImageView.image  =[UIImage imageNamed:@"shop"];
        [sectionHeaderView addSubview:topImageView];
        
        [topImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sectionHeaderView).offset(15);
            make.height.equalTo(15);
            make.left.equalTo(self.view).offset(LDPadding);
            make.width.equalTo(15);
        }];
        
        //商户名称
        UILabel * bussnessName = [[UILabel alloc] init];
        self.bussnessName = bussnessName;
        [sectionHeaderView addSubview:bussnessName];
        //上个界面存储值,
        bussnessName.text = @"";
        bussnessName.textColor = WHColorFromRGB(0x051628);
        bussnessName.font = [UIFont systemFontOfSize:13];
        [bussnessName makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(topImageView);
            
            make.left.equalTo(topImageView.right).offset(LDPadding);
            
            make.right.equalTo(self.view).offset(LDPadding);
        }];
    
        //商品详情view
        UIView * goodsView = [[UIView alloc] init];
        self.goodsView = sectionHeaderView;

        [sectionHeaderView addSubview:goodsView];
    goodsView.backgroundColor = WHColorFromRGB(0xf9f9f9);
        [goodsView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sectionHeaderView.bottom);//.offset(LDPadding);
            make.left.equalTo(sectionHeaderView);//.offset(LDPadding);
            make.right.equalTo(sectionHeaderView);//.offset(-LDPadding);
            make.height.equalTo(100);
        }];
        
        //商品详情中的imageView
        UIImageView * goodsLeftImageView = [[UIImageView alloc] init];
        [goodsView addSubview:goodsLeftImageView];

        goodsLeftImageView.image = [UIImage imageNamed:@"商品 1:1"];
        [goodsLeftImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(goodsView).offset(LDPadding);
            make.width.height.equalTo(80);
        }];
        
        //商品名称lable
        UILabel * goodsNameLable = [UILabel new];
        [goodsView addSubview:goodsNameLable];
    self.goodsNameLable = goodsNameLable;
    
        goodsNameLable.font = [UIFont systemFontOfSize:13];
        goodsNameLable.numberOfLines = 2;
        [goodsNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsLeftImageView.right).offset(LDPadding);
            make.top.equalTo(goodsLeftImageView.top);
            make.right.equalTo(goodsView).offset(-LDPadding);
        }];
        
        
        //订单号
        UILabel * classLable = [UILabel new];
        [goodsView addSubview:classLable];
        classLable.font = [UIFont systemFontOfSize:11];
        classLable.alpha = 0.5;
        classLable.text  =@"订单号";
        [classLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsLeftImageView.right).offset(LDPadding);
            make.width.equalTo(44);
            make.top.equalTo(goodsNameLable.bottom).offset(LDPadding);
        }];
        
        //订单号,内容
        UILabel * classLableDetail = [UILabel new];
        [goodsView addSubview:classLableDetail];
        classLableDetail.font = [UIFont systemFontOfSize:11];
        classLableDetail.alpha = 0.5;
    self.classLableDetail = classLableDetail;
    
        [classLableDetail makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(classLable.right).offset(LDPadding);
            make.right.equalTo(goodsView.right).offset(-LDPadding);
            make.centerY.equalTo(classLable);
        }];
    
    //下单时间
    UILabel * timeLable = [UILabel new];
    [sectionHeaderView addSubview:timeLable];
    timeLable.text = @"下单时间";
    timeLable.alpha = 0.5;
    timeLable.font = [UIFont systemFontOfSize:11];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(classLable);
        make.top.equalTo(classLable.bottom).offset(8);
    }];
    
    //下单时间text
    UILabel * timeLableText = [UILabel new];
    [sectionHeaderView addSubview:timeLableText];
    self.timeLableText = timeLableText;
    timeLableText.alpha = 0.5;
    timeLableText.font = [UIFont systemFontOfSize:11];
    [timeLableText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(classLableDetail);
        make.top.equalTo(classLable.bottom).offset(8);
    }];
    
    
        //总价: 标题lable
        UILabel * sumPrice = [UILabel new];
        [goodsView addSubview:sumPrice];
    
        self.sumPrice = sumPrice;
        sumPrice.alpha = 0.7;
        sumPrice.font = [UIFont systemFontOfSize:13];
        [sumPrice makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-LDPadding);
            make.centerY.equalTo(timeLableText);
        }];
 
    //查看账单界面
    self.checkView = [[UIView alloc]init];
    [self.view addSubview: self.checkView];
     self.checkView.backgroundColor = [UIColor whiteColor];
    [ self.checkView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(45);
        make.top.equalTo(sectionHeaderView.bottom).offset(155);
    }];
    self.checkView.hidden = YES;
    
    UILabel * checkLabel = [[UILabel alloc] init];
    
    [ self.checkView addSubview:checkLabel];
    //上个界面存储值,
    checkLabel.text = @"查看账单";
    checkLabel.textColor = WHColorFromRGB(0x051628);
    checkLabel.font = [UIFont systemFontOfSize:13];
    [checkLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo( self.checkView);
        
        make.left.equalTo( self.checkView).offset(LDPadding);
        
        make.right.equalTo(self.view).offset(LDPadding);
    }];
    
    //箭头imageView
    UIImageView * arrowImageView2 = [[UIImageView alloc] init];
    arrowImageView2.image = [UIImage imageNamed:@"返回"];
    [ self.checkView addSubview:arrowImageView2];
    [arrowImageView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo( self.checkView);
        make.right.equalTo( self.checkView).offset(-LDPadding);
    }];
    
    //最下面的线
    UIView * labelLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, LDScreenWidth, 0.5)];
    labelLine1.backgroundColor = WHColorFromRGB(0xc8c7cc);
 
    [ self.checkView addSubview:labelLine1];
    
    UILabel * labelLine2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, LDScreenWidth, 0.5)];
    labelLine2.backgroundColor = WHColorFromRGB(0xc8c7cc);
    [ self.checkView addSubview:labelLine2];
    
    UIButton * checkButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, LDScreenWidth, 45)];
    [checkButton addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.checkView addSubview:checkButton];
    
    
    
    
        //还款银行卡view
        UIView * headerLineView = [[UIView alloc] init];
        [self.view addSubview:headerLineView];
        headerLineView.backgroundColor = [UIColor whiteColor];
        [headerLineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.equalTo(45);
            make.top.equalTo(sectionHeaderView.bottom).offset(215);
        }];
    
    //还款银行卡
    UILabel * lable = [UILabel new];
    [headerLineView addSubview:lable];
    lable.text = @"还款银行卡";
    lable.font = LD15Font;
    lable.alpha = 0.5;
    [lable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerLineView).offset(LDPadding);
        make.centerY.equalTo(headerLineView);
    }];
    
    //卡号
    UILabel * bankCardNumber = [UILabel new];
    [headerLineView addSubview:bankCardNumber];
    bankCardNumber.alpha = 0.5;
    self.bankCardNumber = bankCardNumber;
    bankCardNumber.text = [NSString stringWithFormat:@"(尾号%@)",self.bankCardNumber.text];
    bankCardNumber.font = [UIFont systemFontOfSize:13];
    [bankCardNumber makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerLineView).offset(-LDPadding);
        make.centerY.equalTo(lable);
    }];
    
    //银行,卡类型
    UILabel * bankCardType = [UILabel new];
    [headerLineView addSubview:bankCardType];
    
    //bankCardType.text = @"北京银行储蓄卡";
    
    self.bankCardType = bankCardType;
    
    bankCardType.alpha = 0.5;
    bankCardType.textAlignment = 2;
    bankCardType.font = [UIFont systemFontOfSize:13];
    [bankCardType makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bankCardNumber.left).offset(-15);
        make.centerY.equalTo(bankCardNumber);
    }];
    
    UILabel * labelLine3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 44.5, LDScreenWidth, 0.5)];
    labelLine3.backgroundColor = WHColorFromRGB(0xc8c7cc);
    [headerLineView addSubview:labelLine1];
    
    UILabel * labelLine4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, LDScreenWidth, 0.5)];
    labelLine4.backgroundColor = WHColorFromRGB(0xc8c7cc);
    [headerLineView addSubview:labelLine4];
    
    
    return sectionHeaderView;
        
  
}

- (UIView *)creatNeddToChangeView{
    //背景view,
    UIView * changeView = [UIView new];
    changeView.backgroundColor = [UIColor whiteColor];
    //控制器view添加背景view,
    [self.view addSubview:changeView];
    [changeView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.goodsView.bottom).offset(100);
        make.height.equalTo(45);
    }];
    

    
    //首付  文字
    UILabel * firstPay = [UILabel new];
    [changeView addSubview:firstPay];
    firstPay.textColor = WHColorFromRGB(0xd33a31);
    self.firstPay = firstPay;
    
    firstPay.font = LD15Font;

    
    [firstPay makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(changeView.left).offset(13);
        make.centerY.equalTo(changeView);
    }];
    
    
    
#pragma mark - 订单状态更改入口
    self.changeLable = [UILabel new];
    [changeView addSubview:self.changeLable];
    self.changeLable.textColor = WHColorFromRGB(0xd33a31);
    self.changeLable.font= LD15Font;
    self.changeLable.textAlignment = NSTextAlignmentRight;
    self.changeLable.text = @"审核中";
   
    [self.changeLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(changeView).offset(-LDPadding);
        make.centerY.equalTo(firstPay);
        
    }];
    
    //最下面的线
    UILabel * labelLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 44.5, LDScreenWidth, 0.5)];
    labelLine.backgroundColor = WHColorFromRGB(0xc8c7cc);
    [changeView addSubview:labelLine];
    
    return changeView;
}



/**
 *  确认订单状态入口.
 *
 */
- (void)creatConformOrder{
    
    self.note = [UILabel new];
    [self.view addSubview:self.note];
   
    self.note.alpha = 0.5;
    self.note.numberOfLines = 0;
    self.note.textAlignment = NSTextAlignmentCenter;
    self.note.text = @"该订单正在审核中,审核通过后您可确认订单完成操作";
    self.note.font = [UIFont systemFontOfSize:13];
    [self.note makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LDPadding);
        make.right.equalTo(self.view).offset(-LDPadding);
        make.top.equalTo(self.view.bottom).offset(-150);
        
    }];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.sureButton];
    [self.sureButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.sureButton setTitle:@"去支付" forState:UIControlStateNormal];
    [self.sureButton setBackgroundColor:WHColorFromRGB(0xdddddd)];
    [self.sureButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(13);
        make.bottom.equalTo(self.view).offset(-LDPadding);
        make.height.equalTo(45);
        make.right.equalTo(self.view).offset(-13);
    }];
    

    
        self.sureButton.userInteractionEnabled = NO;
        

    
}

//查看账单
- (void)checkButtonClick{

    WHChekListController * checkController = [[WHChekListController alloc]init];
    
    checkController.payBackID = self.OrderDetailModel.orderNo;
    
    [self.navigationController pushViewController:checkController animated:YES];

}



- (void)buttonClick{
    
    if ([self.OrderDetailModel.status isEqualToString:@"已通过"]) {
        
        //统计买点
        [WHTongJIRequest sendTongjiRequestWithBusinessId:self.OrderDetailModel.orderNo oprType:QRDDXQ];
        
        
        WHZhiFuTanChuangView * tanchuang = [WHZhiFuTanChuangView view];
        
        UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
        
        [appWindow addSubview:tanchuang];
        
        tanchuang.frame = CGRectMake(0, 0, LDScreenWidth, LDScreenHeight);
        
        [tanchuang.sureButton addTarget:self action:@selector(clickTanChuangSureButton:) forControlEvents:UIControlEventTouchUpInside];
        

        
       
    }
    
    if ([self.OrderDetailModel.status isEqualToString:@"已打回"]) {
        
        //归档存储打回修改的订单ID
        [NSKeyedArchiver archiveRootObject:self.OrderDetailModel.orderNo toFile:BackOrderID];
        //归档存储打回修改的订单类型
        [NSKeyedArchiver archiveRootObject:self.OrderDetailModel.loanType toFile:LoanType];
        [NSKeyedArchiver archiveRootObject:self.OrderDetailModel.businessId toFile:BusinessID];
        
        LDPostIDCard * baseInfo = [[LDPostIDCard alloc]init];
        baseInfo.fromeWhere = @"xiugai";
        baseInfo.requestImage = YES;
        baseInfo.sendUserMessage = YES;
        [self.navigationController pushViewController:baseInfo animated:YES];
        
    }

    
}


#pragma mark -- 确认支付弹窗的按钮响应方法
- (void)clickTanChuangCancelButton:(UIButton *)sender{
    
    [sender.superview removeFromSuperview];
    
}

- (void)clickTanChuangSureButton:(UIButton *)sender{
    
    [sender.superview removeFromSuperview];
    
    if ([self.OrderDetailModel.loanType isEqualToString:@"0"]){
        
        
       
        
    }else{
        
        WHCashSuccessController * cashSucess = [[WHCashSuccessController alloc]init];
        
        cashSucess.applyId = self.OrderDetailModel.orderNo;
        
        [self.navigationController pushViewController:cashSucess animated:YES];
        
    }
    
   
}

@end
