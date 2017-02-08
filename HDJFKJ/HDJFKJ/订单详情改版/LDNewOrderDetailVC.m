//
//  LDNewOrderDetailVC.m
//  HDJFKJ
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDNewOrderDetailVC.h"
#import "LDNewOrderDetailCell.h"
#import "LDOrderDetailGoodsCell.h"
#import "LDOrderDetailModel.h"
#import "LDNewOrderDetailModel.h"
#import "LDPostIDCard.h"
#import "WHZhiFuTanChuangView.h"
#import "WHCashSuccessController.h"
#import "WHChekListController.h"
#import "HDQRCommodity.h"
#import "LDReViewInformation.h"
#import "LDNavgationVController.h"

#define LDSectionOneCellHeight 115
#define LDOtherSectionCellHeight 100
#define LDRepaymentLableHeight 60
#define LDNavgationBarHeight 0


@interface LDNewOrderDetailVC ()<UITableViewDataSource,UITableViewDelegate>
/** tableView  */
@property (nonatomic,strong) UITableView * tableView;
/** 订单编号  */
@property (nonatomic,strong) UILabel * orderNumber;
/** 下单时间  */
@property (nonatomic,strong) UILabel * orderTimeLable;
/** 商户  */
@property (nonatomic,strong) UILabel * businessName;
/** 还款银行卡  */
@property (nonatomic,strong) UILabel * repaymentBankCard;
/** 商品数量  */
@property (nonatomic,strong) UILabel * goodsNumLable;
/** 合计  */
@property (nonatomic,strong) UILabel * goodsSumPrice;
/** 月还款额  */
@property (nonatomic,strong) UILabel * monthPay;
/** 订单状态  */
@property (nonatomic,strong) UILabel * orderStatus;
/**
 *  订单详情模型
 */
@property (nonatomic,strong) LDNewOrderDetailModel * OrderDetailModel;
/** 数据源  */
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) BOOL isOpen;
/** button  */
@property (nonatomic,strong) UIButton * ClickButton;
/** smallArray  */
@property (nonatomic,strong) NSArray * smallArray;
/** 商品数量  */
@property (nonatomic,strong) UILabel * goodsNum;

//底部按钮高度
@property (nonatomic, assign) float LDBottomLableHeight ;

/** 打回原因，拒绝原因，取消原因Label*/
@property (nonatomic, strong) UILabel * reasonLabel;
@end

@implementation LDNewOrderDetailVC

- (UILabel *) reasonLabel{

    if (!_reasonLabel) {
        _reasonLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10,LDScreenWidth - 26, 0)];
        _reasonLabel.textColor = WHColorFromRGB(0x4279d6);
        _reasonLabel.font = [UIFont systemFontOfSize:15];
        _reasonLabel.numberOfLines = 0;
        _reasonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _reasonLabel;
}

- (NSArray *)smallArray{

    if (!_smallArray) {
        
        _smallArray = [NSArray array];
        
    }
    return _smallArray;
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
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"订单详情";
    
    self.view.backgroundColor = LDBackroundColor;
    
    self.LDBottomLableHeight = 0;
    
    
    
    self.isOpen = NO;
    
    self.ClickButton.tag = 10121;
    [self createLeftNavButton];
    
    
    /** 删除缓存的下单数据 */
    [[HDSubmitOrder shardSubmitOrder] setAttributeNull];
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
- (UIButton *)ClickButton{
    if (!_ClickButton) {
        _ClickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _ClickButton;
}
/**
 *  set方法  触发 网络请求
 */
-(void)setApplyId:(NSString *)applyId{
    
    _applyId = applyId;//2147483647,2147483647
    
    [self sendOrderDetetailRequest];
}


/**
 *  订单详情网络请求
 */
- (void)sendOrderDetetailRequest{
    
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * url = [NSString stringWithFormat:@"%@order/detail",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:self.applyId forKey:@"applyId"];
    
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    
    [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
        
        if(error != nil){
            
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
            [HDLoading dismissHDLoading];
            
            LDLog(@"%@",response);
            
            /** 3.解析返回结果 */
            
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                /** 4.解析订单详情 */
                if (backInfo.result != nil){
                    
                    /** 解析订单模型 */
                    self.OrderDetailModel = [LDNewOrderDetailModel mj_objectWithKeyValues:backInfo.result];
                    
                    if (self.OrderDetailModel.feedback == nil) {
                        self.OrderDetailModel.feedback = @"暂无原因，如有需要请联系客服";
                    }
                    
                    
                    self.reasonLabel.text = self.OrderDetailModel.feedback;
                    CGSize size = [self.reasonLabel sizeThatFits:CGSizeMake(self.reasonLabel.frame.size.width, MAXFLOAT)];
                    self.reasonLabel.frame =CGRectMake(self.reasonLabel.frame.origin.x, self.reasonLabel.frame.origin.y, self.reasonLabel.frame.size.width, size.height);
                    
                    
                    
                    /** 解析商品 */
                    self.dataArray = [LDSmallNewOrderDetailModel mj_objectArrayWithKeyValuesArray:self.OrderDetailModel.orderCommoditys];
                    
                    if (self.dataArray.count >2 ) {
                        self.smallArray = @[[self.dataArray objectAtIndex:0],[self.dataArray objectAtIndex:1]];
                    }else{
                        self.smallArray = self.dataArray;
                    }
                    
                    for (LDSmallNewOrderDetailModel * model in self.dataArray) {
                        LDLog(@"%@",model.pic);
                        LDLog(@"%@",model.commodityName);
                        LDLog(@"%@",model.commodityPrice);
                    }
                    
                    // 还款中  视图
                    [self setUpTopView];
                    //订单详情,tableView
                    [self setUpTableView];
                    
                    
                    //查看账单视图
                    if (([self.OrderDetailModel.status isEqualToString:@"已通过"] && [self.OrderDetailModel.loanType isEqualToString:@"1"]) || [self.OrderDetailModel.status isEqualToString:@"已完成"] || [self.OrderDetailModel.status isEqualToString:@"已打回"] || [self.OrderDetailModel.status isEqualToString:@"还款中"]){
                        self.LDBottomLableHeight = 50;
                        if([self.OrderDetailModel.status isEqualToString:@"已完成"] ||[self.OrderDetailModel.status isEqualToString:@"还款中"]){
                            [self setUpOrderViewWithTitle:@"查看账单"];
                            self.tableView.frame = CGRectMake(0, LDNavgationBarHeight + LDRepaymentLableHeight , LDScreenWidth, LDScreenHeight - LDNavgationBarHeight - 64 - LDRepaymentLableHeight - self.LDBottomLableHeight);
                        }
                        else if ([self.OrderDetailModel.status isEqualToString:@"已打回"]){
                            [self setUpOrderViewWithTitle:@"修改信息"];
                            self.tableView.frame = CGRectMake(0, LDNavgationBarHeight + LDRepaymentLableHeight , LDScreenWidth, LDScreenHeight - LDNavgationBarHeight - 64 - LDRepaymentLableHeight - self.LDBottomLableHeight);
                        }
                        else{
                            
                            self.tableView.frame = CGRectMake(0, LDNavgationBarHeight + LDRepaymentLableHeight , LDScreenWidth, LDScreenHeight - LDNavgationBarHeight - 64 - LDRepaymentLableHeight);
                        }
                        
                    }else{
                        self.tableView.frame = CGRectMake(0, LDNavgationBarHeight + LDRepaymentLableHeight , LDScreenWidth, LDScreenHeight - LDNavgationBarHeight - 64 - LDRepaymentLableHeight);
                    }
                    
                    
                    [self.tableView reloadData];
                    //界面元素赋值
                    [self setUpReloadData:self.OrderDetailModel];
                
                }
                
            }else{
                
                [HDLoading showFailViewWithString:backInfo.message];
            }
        
            

        }
    }];
}
static NSString * const NewOrderDetailCell = @"NewOrderDetailCell";
static NSString * const OrderDetailCell = @"OrderDetailCell";
/**
 *  界面元素赋值
 */
- (void)setUpReloadData:(LDNewOrderDetailModel *)model{
    
    LDLog(@"%@",self.OrderDetailModel.applyAmount);
    LDLog(@"%@",self.OrderDetailModel.bankName);
    LDLog(@"%@",self.OrderDetailModel.businessName);
    LDLog(@"%@",self.OrderDetailModel.cardNo);
    //订单状态
    self.orderStatus.text = self.OrderDetailModel.status;

    //订单编号
    self.orderNumber.text = [NSString stringWithFormat:@"订单编号: %@",self.OrderDetailModel.orderNo];
    NSInteger count = 0;
    
    for (int i = 0;i < self.dataArray.count; i++) {
        
        LDSmallNewOrderDetailModel * model = self.dataArray[i];
        
        count += [model.commodityCount intValue];
    }
   
    //共多少件商品
    self.goodsNumLable.text = [NSString stringWithFormat:@"共%lu件商品",(long)count];
    self.goodsNumLable.textColor = WHColorFromRGB(0x6f7179);
    
    //合计
    NSString * str1 = [NSString stringWithFormat:@"合计: ￥%.2f",[self.OrderDetailModel.totalPrice floatValue]];
    NSRange rang1 = [str1  rangeOfString:@"合计: "];
    
    NSRange rang2 = [str1 rangeOfString:[NSString stringWithFormat:@"￥%.2f",[self.OrderDetailModel.totalPrice floatValue]]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
    [str addAttribute:NSForegroundColorAttributeName value:WHColorFromRGB(0x6f7179) range:rang1];
    [str addAttribute:NSForegroundColorAttributeName value:WHColorFromRGB(0x4279d6) range:rang2];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rang1];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:rang2];
    self.monthPay.attributedText = str;
    
    //商户
    self.businessName.text = [NSString stringWithFormat:@"商户: %@",self.OrderDetailModel.businessName];
    self.businessName.textColor = WHColorFromRGB(0x6f7179);
    
    //银行卡
    self.repaymentBankCard.text = [NSString stringWithFormat:@"%@(%@)",self.OrderDetailModel.bankName,self.OrderDetailModel.cardNo];
    self.repaymentBankCard.textColor = WHColorFromRGB(0x6f7179);
    
    if (self.isOpen) {
        
        [self.ClickButton setTitle:@"收起" forState:UIControlStateNormal];
        [self.ClickButton setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateNormal];
    }else{
    
        [self.ClickButton setTitle:@"展开" forState:UIControlStateNormal];
        
        [self.ClickButton setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    }
    
    [self.ClickButton setTitleColor:WHColorFromRGB(0x6f7179) forState:UIControlStateNormal];

}
/**
 * 订单详情,tableView
 */
- (void)setUpTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LDNavgationBarHeight + LDRepaymentLableHeight , LDScreenWidth, LDScreenHeight - 64 - LDRepaymentLableHeight - 50) style:UITableViewStyleGrouped];
    NSLog(@"%f",self.tableView.frame.size.height);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDNewOrderDetailCell class]) bundle:nil] forCellReuseIdentifier:NewOrderDetailCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDOrderDetailGoodsCell class]) bundle:nil] forCellReuseIdentifier:OrderDetailCell];
}
/**
 *  UITableViewDataSource  UITableViewDelegate
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (section == 0) {
        
        UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, 0)];
        
        UIView * secondView = [UIView new];
        secondView.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:secondView];
        
        [secondView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(footerView);
            make.height.equalTo(40);
        }];
        
        
        self.goodsNumLable = [UILabel new];
        
        self.goodsNumLable.font = [UIFont systemFontOfSize:12];
//        self.goodsNumLable.alpha = 0.5;
        [secondView addSubview:self.goodsNumLable];
        [self.goodsNumLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(secondView.left).offset(LDPadding);
            make.top.bottom.equalTo(secondView);
        }];
        
        
        [self.ClickButton setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateNormal];
        if(self.OrderDetailModel.orderCommoditys.count<3){
            self.ClickButton.hidden = YES;
        }

        [self.ClickButton setFont:[UIFont systemFontOfSize:12]];
        [secondView addSubview:self.ClickButton];
        [self.ClickButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(secondView);
            make.left.equalTo(self.goodsNumLable.right).offset(2*LDPadding);
            make.width.equalTo(40);
        }];
        // 交换button中title和image的位置
        self.ClickButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -40);
        self.ClickButton.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        [self.ClickButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
   
        self.monthPay = [UILabel new];
        [secondView addSubview:self.monthPay];
        [self.monthPay makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(secondView);
            make.right.equalTo(secondView.right).offset(-LDPadding);
        }];
        
        
        return footerView;
    }else{
        return nil;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UIView * section1Header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, 45)];
        section1Header.backgroundColor = [UIColor whiteColor];
        //订单列表
        UILabel * orderListLable = [UILabel new];
        orderListLable.text = @"订单列表";
        [section1Header addSubview:orderListLable];
        orderListLable.font = LD15Font;
        [orderListLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(section1Header).offset(LDPadding);
            make.top.bottom.equalTo(section1Header);
            make.width.equalTo(62);
        }];
        
        //订单编号
        self.orderNumber = [UILabel new];
        self.orderNumber.font = [UIFont systemFontOfSize:12];

        [section1Header addSubview:self.orderNumber];

        [self.orderNumber makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(section1Header);
            make.right.equalTo(section1Header.right).offset(-LDPadding);
            
        }];
        
        UILabel * line = [UILabel new];
        [section1Header addSubview:line];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.2;
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderListLable);
            make.right.equalTo(section1Header);
            make.bottom.equalTo(section1Header);
            make.height.equalTo(0.5);
        }];
        
        [self setUpReloadData:self.OrderDetailModel];
        return section1Header;
        
    }else if(section == 2){
        
        UIView * section1Header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, 45)];
        section1Header.backgroundColor = [UIColor whiteColor];
        //还款银行卡
        UILabel * orderListLable = [UILabel new];
        orderListLable.text = @"还款银行卡";
        [section1Header addSubview:orderListLable];
        orderListLable.font = LD15Font;
        [orderListLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(section1Header).offset(LDPadding);
            make.top.bottom.equalTo(section1Header);
            make.width.equalTo(LDRepaymentLableHeight + 20);
        }];
        
        //订单编号
        self.repaymentBankCard = [UILabel new];
        self.repaymentBankCard.font = [UIFont systemFontOfSize:12];
//        self.repaymentBankCard.alpha = 0.5;
        [section1Header addSubview:self.repaymentBankCard];

        [self.repaymentBankCard makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(section1Header);
            make.right.equalTo(section1Header.right).offset(-LDPadding);
            
        }];
        
        UILabel * line = [UILabel new];
        [section1Header addSubview:line];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.2;
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(section1Header);
            make.right.equalTo(section1Header);
            make.bottom.equalTo(section1Header);
            make.height.equalTo(0.5);
        }];
        
        [self setUpReloadData:self.OrderDetailModel];
        return section1Header;


    }else if (section == 1) {
    
        UIView * section1Header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, 45)];
        section1Header.backgroundColor = [UIColor whiteColor];
        //订单详情
        UILabel * orderListLable = [UILabel new];
        orderListLable.text = @"订单详情";
        [section1Header addSubview:orderListLable];
        orderListLable.font = LD15Font;
        [orderListLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(section1Header).offset(LDPadding);
            make.top.bottom.equalTo(section1Header);
            make.width.equalTo(62);
        }];
        
        //商户
        self.businessName = [UILabel new];
        self.businessName.font = [UIFont systemFontOfSize:12];
//        self.businessName.alpha = 0.5;
        [section1Header addSubview:self.businessName];

        [self.businessName makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(section1Header);
            make.right.equalTo(section1Header.right).offset(-LDPadding);
            
        }];
        
        UILabel * line = [UILabel new];
        [section1Header addSubview:line];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.18;
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(section1Header);
            make.right.equalTo(section1Header);
            make.bottom.equalTo(section1Header);
            make.height.equalTo(0.5);
        }];
        
        [self setUpReloadData:self.OrderDetailModel];
        return section1Header;
    }
    else{
        UIView * section3Header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, 45)];
        section3Header.backgroundColor = [UIColor whiteColor];
        //订单详情
        UILabel * orderListLable = [UILabel new];
        
        if ([self.OrderDetailModel.status isEqualToString:@"已打回"]) {
            orderListLable.text = @"打回原因:";
        }
        if ([self.OrderDetailModel.status isEqualToString:@"已取消"]) {
            orderListLable.text = @"取消原因:";
        }
        if ([self.OrderDetailModel.status isEqualToString:@"已拒绝"]) {
            orderListLable.text = @"拒绝原因:";
        }
        [section3Header addSubview:orderListLable];
        orderListLable.font = LD15Font;
        [orderListLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(section3Header).offset(LDPadding);
            make.top.bottom.equalTo(section3Header);
            make.width.equalTo(LDRepaymentLableHeight+10);
        }];
        
        
        UILabel * line = [UILabel new];
        [section3Header addSubview:line];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.18;
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(section3Header).offset(LDPadding);
            make.right.equalTo(section3Header);
            make.bottom.equalTo(section3Header);
            make.height.equalTo(0.5);
        }];
        
        
        
        return section3Header;
    
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 50;
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {

        if (self.isOpen) {
            
            return self.dataArray.count;
        
            
        }else{
        
            
            return self.smallArray.count;
        }
            
        
    }else if(section == 1){
        
        return 1;
    }else{
    
        if ([self.OrderDetailModel.status isEqualToString:@"已打回"] || [self.OrderDetailModel.status isEqualToString:@"已取消"] || [self.OrderDetailModel.status isEqualToString:@"已拒绝"]) {
            return 1;
        }
        
        return 0;
    }
    
}
/**
 *  展开 & 收起 触发事件
 */
- (void)buttonClick:(UIButton *)button{
    
    if (self.ClickButton.tag == 10121 && self.dataArray.count > 2) {
        
        self.smallArray = [NSArray arrayWithObject:[self.dataArray objectAtIndex:0]];
        
        self.smallArray = @[[self.dataArray objectAtIndex:0],[self.dataArray objectAtIndex:1]];
        
        self.isOpen = YES;

        //[self.tableView reloadData];
        [UIView transitionWithView: self.tableView duration: 0.35f options: UIViewAnimationOptionTransitionCrossDissolve animations: ^(void){
            [self.tableView reloadData];
            
        }completion: ^(BOOL isFinished){
            
        }];
        
        [self.ClickButton setTitle:@"展开" forState:UIControlStateNormal];
        self.ClickButton.tag = 20121;
        
        [self.ClickButton setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateNormal];
        
        
    }else{
        
        self.isOpen = NO;

        //[self.tableView reloadData];
        [UIView transitionWithView: self.tableView duration: 0.35f options: UIViewAnimationOptionTransitionCrossDissolve animations: ^(void){
            [self.tableView reloadData];
            
        }completion: ^(BOOL isFinished){
            
        }];
        
        self.ClickButton.tag = 10121;
        [self.ClickButton setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        
        
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        return LDSectionOneCellHeight;
        
    }else if (indexPath.section == 0){
        
        return LDOtherSectionCellHeight;
        
    }
    else if (indexPath.section == 2){
        return 0;
    }
    else{
        if (self.reasonLabel.frame.size.height == 0.0) {
            return 0;
        }
        
        return (self.reasonLabel.frame.size.height + 20.0);
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self.OrderDetailModel.status isEqualToString:@"已打回"] || [self.OrderDetailModel.status isEqualToString:@"已取消"] || [self.OrderDetailModel.status isEqualToString:@"已拒绝"]) {
        return 4;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 1) {
        
        LDNewOrderDetailCell * cell = [self.tableView dequeueReusableCellWithIdentifier:NewOrderDetailCell];
        
        cell.orderDetailModel = self.OrderDetailModel;
        return cell;
        
        
    }else if(indexPath.section == 0){
    
        LDSmallNewOrderDetailModel * model = self.dataArray[indexPath.row];
        
        LDOrderDetailGoodsCell * cell = [self.tableView dequeueReusableCellWithIdentifier:OrderDetailCell];
        
        cell.smallDetailModel = model;
        
        return cell;
        
    }else{
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            cell.backgroundColor = [UIColor whiteColor];
            
            [cell addSubview: self.reasonLabel];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    
}

/**
 *  底部  :查看账单视图
 */
- (void)setUpOrderViewWithTitle:(NSString *)title{
    UIButton * bottomLable = [UIButton new];
    [bottomLable setBackgroundColor: WHColorFromRGB(0x4279d6)];
    [self.view addSubview:bottomLable];
    
    [bottomLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomLable setTitle:title forState:UIControlStateNormal];
   
    [bottomLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(self.LDBottomLableHeight);
    }];
    [bottomLable addTarget:self action:@selector(bottomLableClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}
/**
 *  查看账单响应方法
 */
- (void)bottomLableClick:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:@"修改信息"]) {
        
        //归档存储打回修改的订单ID
        [NSKeyedArchiver archiveRootObject:self.OrderDetailModel.orderNo toFile:BackOrderID];
        //归档存储打回修改的订单类型
        [NSKeyedArchiver archiveRootObject:self.OrderDetailModel.loanType toFile:LoanType];
        [NSKeyedArchiver archiveRootObject:self.OrderDetailModel.businessId toFile:BusinessID];
        
        [[HDSubmitOrder shardSubmitOrder] setBusinessId:self.OrderDetailModel.businessId];
        
        
        //申请价格
        [[HDSubmitOrder shardSubmitOrder] setApplyAmount:self.OrderDetailModel.applyAmount];
        
        //首付款
        [[HDSubmitOrder shardSubmitOrder] setDownpayment:self.OrderDetailModel.downpayment];
        
        //总价
        [[HDSubmitOrder shardSubmitOrder] setTotalAmount:self.OrderDetailModel.totalPrice];
        
        //专案id
        //[[HDSubmitOrder shardSubmitOrder] setCaseId:self.OrderDetailModel.casesId];
        
        /** 分期详情 */
        [[HDSubmitOrder shardSubmitOrder] setCaseDetail:[NSString stringWithFormat:@"¥%@ x %@期",self.OrderDetailModel.periodAmount,self.OrderDetailModel.duration]];

        
        //订单号
        [[HDSubmitOrder shardSubmitOrder] setOrderNo:self.OrderDetailModel.orderNo];
        
        //商品名称
        [[HDSubmitOrder shardSubmitOrder] setGoodsName:[self returnGoodsName]];
        
        
        
        LDReViewInformation * reviewInfo = [[LDReViewInformation alloc]init];
        
        LDNavgationVController * nvc = [[LDNavgationVController alloc]initWithRootViewController:reviewInfo];
        [self.navigationController presentViewController:nvc animated:YES completion:nil];
       
        
    }
    if ([sender.titleLabel.text isEqualToString:@"去支付"]) {
        //统计买点
        [WHTongJIRequest sendTongjiRequestWithBusinessId:self.OrderDetailModel.orderNo oprType:QRDDXQ];
        
        
        WHZhiFuTanChuangView * tanchuang = [WHZhiFuTanChuangView view];
        
        UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
        
        [appWindow addSubview:tanchuang];
        
        tanchuang.frame = CGRectMake(0, 0, LDScreenWidth, LDScreenHeight);
        
        [tanchuang.sureButton addTarget:self action:@selector(clickTanChuangSureButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([sender.titleLabel.text isEqualToString:@"查看账单"]) {
        WHChekListController * checkController = [[WHChekListController alloc]init];
        
        checkController.payBackID = self.OrderDetailModel.orderNo;
        
        [self.navigationController pushViewController:checkController animated:YES];
    }
    
    
    LDLogFunc;

}
/** 返回拼接商品名称  */
- (NSMutableString *)returnGoodsName{
    
    NSMutableString * string = [[NSMutableString alloc]init];
    
    for (LDSmallNewOrderDetailModel * commoditys in self.self.dataArray) {
        
        if (string.length == 0) {
            [string appendString:commoditys.commodityName];
        }
        else{
            [string appendString:@","];
            [string appendString:commoditys.commodityName];
        }
        
    }
    return string;
}


#pragma mark -- 确认支付弹窗的按钮响应方法
- (void)clickTanChuangCancelButton:(UIButton *)sender{
    
    [sender.superview removeFromSuperview];
    
}

- (void)clickTanChuangSureButton:(UIButton *)sender{
    
    [sender.superview removeFromSuperview];
    
    
    WHCashSuccessController * cashSucess = [[WHCashSuccessController alloc]init];
    
    cashSucess.applyId = self.OrderDetailModel.orderNo;
    
    [self.navigationController pushViewController:cashSucess animated:YES];
    
}


/**
 *     还款中  视图
 */
- (void)setUpTopView{
    self.view.backgroundColor = LDBackroundColor;

    UIView * topBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, LDNavgationBarHeight, LDScreenWidth, LDRepaymentLableHeight)];
    topBaseView.backgroundColor =WHColorFromRGB(0x4279d6);
   
    [self.view addSubview:topBaseView];
    
    //还款中
    self.orderStatus = [UILabel new];

    self.orderStatus.textColor = [UIColor whiteColor];
    [topBaseView addSubview:self.orderStatus];
    
    [self.orderStatus makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBaseView).offset(LDPadding);
        make.top.bottom.equalTo(topBaseView);
        make.width.equalTo(LDRepaymentLableHeight);
    }];

    //下单时间
    self.orderTimeLable = [UILabel new];
    self.orderTimeLable.font = [UIFont systemFontOfSize:12];
    self.orderTimeLable.textColor = [UIColor whiteColor];
    self.orderTimeLable.text = [NSString stringWithFormat:@"下单时间:%@",self.OrderDetailModel.time];
    [topBaseView addSubview:self.orderTimeLable];
    [self.orderTimeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderStatus.right).offset(LDPadding);
        make.centerY.equalTo(self.orderStatus);
        make.right.equalTo(topBaseView);
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
