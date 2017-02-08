//
//  LDGoodsDetailViewController.m
//  HDJFKJ
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDGoodsDetailViewController.h"
#import "LDGoodsDetailModel.h"
#import "LDGoodsIDAndZhuanAnId.h"
#import "LDGoodsDetailCell.h"
#import "LDGoodsSection1.h"
#import "LDSection2.h"
#import "LDSection4.h"
#import "LDSection3.h"
#import "LDGoodsDetailModel.h"
#import "AuthorizViewController.h"
#import "LDConformOrderViewController.h"
#import "LDBusnessController.h"
#import "LDSignInViewController.h"
#import "LDNavgationVController.h"
#import "LDBusnessController.h"
#import "SDCycleScrollView.h"
#define heightProportion 375 * LDScreenHeight / 667

@interface LDGoodsDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) LDGoodsDetailModel * goodsDetailModel;
@property (nonatomic,strong) NSArray * cases;
/**
 *  商品名称
 */
@property (nonatomic,strong) NSString  * goodsName;
@property (nonatomic,strong) UILabel * monthMoney;

@end

@implementation LDGoodsDetailViewController
static NSString * const LDGoodsDetail = @"LDGoodsDetail";
static NSString * const Section1 = @"Section1";
static NSString * const Section2 = @"Section2";
static NSString * const Section3 = @"Section3";
static NSString * const Section4 = @"Section4";
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-39, 0, 0, 0);
    
    self.view.backgroundColor = LDBackroundColor;
    
    self.navigationItem.title = @"商品详情";
    
    [self creatSubView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    }

- (void)topButtonClick{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatSubView{

    UITableView * tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, LDScreenHeight - 50) style:UITableViewStyleGrouped];
    tabbleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabbleView];
    tabbleView.delegate = self;
    tabbleView.dataSource = self;
    self.tableView = tabbleView;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDGoodsDetailCell class]) bundle:nil] forCellReuseIdentifier:LDGoodsDetail];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDGoodsSection1 class]) bundle:nil] forCellReuseIdentifier:Section1];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDSection2 class]) bundle:nil] forCellReuseIdentifier:Section2];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDSection4 class]) bundle:nil] forCellReuseIdentifier:Section4];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDSection3 class]) bundle:nil] forCellReuseIdentifier:Section3];
    
    UIView * BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, LDScreenHeight - 50, LDScreenWidth, 50)];

    BottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BottomView];
    
    UIView * upline = [UIView new];
    [BottomView addSubview:upline];
    upline.alpha = 0.5;
    upline.backgroundColor = [UIColor blackColor];
    [upline makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(BottomView);
        make.height.equalTo(0.5);
    }];
    UIView * downline = [UIView new];
    [BottomView addSubview:downline];
    downline.alpha = 0.5;
    downline.backgroundColor = [UIColor blackColor];
    [downline makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(BottomView);
        make.height.equalTo(0.5);
    }];
    UILabel * monthLable = [UILabel new];
    monthLable.text = @"月供:";
    [BottomView addSubview:monthLable];
    [monthLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BottomView).offset(LDPadding);
        make.top.equalTo(upline);
        make.bottom.equalTo(downline);
        make.width.equalTo(40);
    }];
    
    UILabel * monthMoney = [UILabel new];
    monthMoney.textColor = [UIColor redColor];
    monthMoney.text = @"99999元起";
    self.monthMoney = monthMoney;
    [BottomView addSubview:monthMoney];
    [monthMoney makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(monthLable.right);
        make.centerY.equalTo(monthLable);
    }];
    
  UIButton * bottomButotn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButotn setTitle:@"立刻购买" forState:UIControlStateNormal];
    [BottomView addSubview:bottomButotn];
    [bottomButotn setBackgroundImage:[UIImage imageNamed:@"购买按钮"] forState:UIControlStateNormal];
    [bottomButotn addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
    [bottomButotn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upline);
        make.bottom.equalTo(downline);
      make.right.equalTo(BottomView.right);//.offset(10);
    }];
}

- (void)buyNow{
    
    
    //统计买点
    [WHTongJIRequest sendTongjiRequestWithBusinessId:self.goodsID oprType:GMSPXQ];
    
    [self isLogin];
    
}

- (void)isLogin{
    
    NSString * token = [LDUserInformation sharedInstance].token;
    
    NSString * ID = [LDUserInformation sharedInstance].UserId;
    
    if ((token == nil)||(ID == nil)){
        
        //未登录
        LDSignInViewController * vc = [[LDSignInViewController alloc] init];
        
        vc.fromWhere = @"goumai";
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else{
        //已登录,发送购买验证
        [self sendRequestBuyNow];
    }


}

/**
 *  网络请求,立即购买,购买验证
 */
- (void)sendRequestBuyNow{
    
    [HDLoading showWithImageWithString:@"正在验证"];
    
    NSString * url = [NSString stringWithFormat:@"%@order/buyCheck",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
   [params setObject:NULLSTR([LDUserInformation sharedInstance].token) forKey:@"token"];
    
    [params setObject:NULLOBJ([LDUserInformation sharedInstance].UserId) forKey:@"id"];
    
    [params setObject:NULLSTR([LDUserInformation sharedInstance].phoneNumber) forKey:@"phoneNo"];
    
    
    [params setObject:NULLSTR([LDGoodsIDAndZhuanAnId sharedInstance].commodityno) forKey:@"commodityNo"];
    

    LDLog(@"传值%@",[LDGoodsIDAndZhuanAnId sharedInstance].commodityno);
    
    LDLog(@"参数%@",[params objectForKey:@"commodityNo"]);
    
    
    [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
        if(error != nil){
            
            /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
        }else{
            
            NSLog(@"%@",response);
            
            /** 3.解析返回信息*/
            LDBackInformation * backInfor = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfor.code isEqualToString:@"0"]) {
            
                [HDLoading dismissHDLoading];
                
                /**
                 * 给提交订单模型赋值
                 * 用一个单利类缓存提交商品当单需要的数据，这里获取到:商户id,申请价格,首付款,商品总价,商品列表 五个值，商品列表的格式参考接口文档
                 **/
                //商户id
                [[HDSubmitOrder shardSubmitOrder] setBusinessId:self.goodsDetailModel.businessid];
                //申请价格
                [[HDSubmitOrder shardSubmitOrder] setApplyAmount:[NSString stringWithFormat:@"%.2f",[self.goodsDetailModel.commodityprice floatValue] - [self.goodsDetailModel.downpayment floatValue]]];
                //首付款
                [[HDSubmitOrder shardSubmitOrder] setDownpayment:self.goodsDetailModel.downpayment];
                //商品总价
                [[HDSubmitOrder shardSubmitOrder] setTotalAmount:self.goodsDetailModel.commodityprice];
                //商品列表
                [[HDSubmitOrder shardSubmitOrder] setCommoditys:[self returnCommoditys]];
                
                
                LDConformOrderViewController * conformVC = [[LDConformOrderViewController alloc] init];
                
                conformVC.goodsID = self.goodsID;
                
                [self.navigationController pushViewController:conformVC animated:YES];
                
            }else if ([backInfor.code intValue] == -100){
                
                //服务器异常
                [HDLoading showFailViewWithString:backInfor.message];
                
                return ;
            
            }else if ([backInfor.code intValue] == -2) {
                
                [HDLoading dismissHDLoading];
                //未登录
                LDSignInViewController * vc = [[LDSignInViewController alloc] init];
                
                vc.fromWhere = @"goumai";
                [self.navigationController pushViewController:vc animated:YES];
 
                LDLog(@"未登录1234");

                return ;
                
            }else if([backInfor.code intValue] == -3) {
                //有未完结订单,无法购买
                [HDLoading showFailViewWithString:backInfor.message];
                return;
                
            }else if([backInfor.code intValue] == -4) {
                
                //三个月内有被拒绝订单,无法购买.
                [HDLoading showFailViewWithString:backInfor.message];
                return;
                
            }else{
                [HDLoading showFailViewWithString:backInfor.message];
            }

        }
    }];
    
}

/**
 *  商品ID
 */
-(void)setGoodsID:(NSString *)goodsID{
    
    _goodsID = goodsID;
    
    [self sendRequest];
    
}
- (void)setFromWhere:(NSString *)fromWhere{
    
    _fromWhere = fromWhere;

}

//网络请求(加载页面数据)
- (void)sendRequest{
    
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * url = [NSString stringWithFormat:@"%@detail/commodity",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:self.goodsID forKey:@"id"];
    
    LDLog(@"%@",self.goodsID);
    [[LDNetworkTools sharedTools]request:POST url:url params:params callback:^(id response, NSError *error) {
        if(error != nil){
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
            [HDLoading dismissHDLoading];
            
            LDLog(@"%@",response);
            
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                /** 4.解析商品详情 */
                if (backInfo.result != nil){
                    self.goodsDetailModel = [LDGoodsDetailModel mj_objectWithKeyValues:backInfo.result];
                    
                    self.cases = [LDGoodsDetailIDModel mj_objectArrayWithKeyValuesArray:self.goodsDetailModel.cases];
                    
                    [[LDGoodsIDAndZhuanAnId sharedInstance] setId:self.goodsID];
                    
                    
                    //专案ID,专案期次,专案月供金额.
                    
                    if (self.cases.count > 0) {
                        LDGoodsDetailIDModel * IDModel = self.cases[0];
                        [[LDGoodsIDAndZhuanAnId sharedInstance] setZhuanAnID:IDModel.id];
                    }
                    
                    
                    
                    
                    
                    
                    
                    [[LDGoodsIDAndZhuanAnId sharedInstance] setCommodityno:self.goodsDetailModel.commodityno];
                    
                    [[LDGoodsIDAndZhuanAnId sharedInstance] setCategory:self.goodsDetailModel.category];
                    
                    [[LDGoodsIDAndZhuanAnId sharedInstance] setBusinessname:self.goodsDetailModel.businessname];
                    
                    [[LDGoodsIDAndZhuanAnId sharedInstance] setName:self.goodsDetailModel.name];
                    
                    [[LDGoodsIDAndZhuanAnId sharedInstance] setName:self.goodsDetailModel.commodityprice];
                    
                    [[LDGoodsIDAndZhuanAnId sharedInstance] setBusnessID:self.goodsDetailModel.businessid];
                
                }
                
            }
            
            
            
            
            [self.tableView reloadData];
            
        self.monthMoney.text = [NSString stringWithFormat:@"%.2f元起",[self.goodsDetailModel.periodamount floatValue]];
        }
    }];
}


/**
 *  返回多少行cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 2;
        
    }else{
        
        return 1;
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            }
            
            cell.frame = CGRectMake(0, 0, LDScreenWidth, heightProportion);
            NSLog(@"cellX = %f, cellY = %f",cell.frame.origin.x,cell.frame.origin.y);
            
            
            
            SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:cell.bounds delegate:self placeholderImage:[UIImage imageNamed:@"商品 1:1"]];
            
            cycleScrollView3.bannerImageViewContentMode  = UIViewContentModeScaleAspectFit;
            
            cycleScrollView3.autoScroll = NO;
            
            cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"椭圆-11"];
            cycleScrollView3.pageDotImage = [UIImage imageNamed:@"椭圆-11-拷贝"];
            cycleScrollView3.imageURLStringsGroup = self.goodsDetailModel.piclist;
            
            cycleScrollView3.backgroundColor = [UIColor whiteColor];
            
            
            
            [cell addSubview:cycleScrollView3];
            cell.layer.shadowOffset = CGSizeMake(0, 0.5);
            
            cell.layer.shadowColor = [UIColor blackColor].CGColor;
            
            cell.layer.shadowOpacity = .1f;
            
            CGRect shadowFrame = cell.layer.bounds;
            
            CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
            
            cell.layer.shadowPath = shadowPath;
            
            
            UIButton * backBUtton = [[UIButton alloc]initWithFrame:CGRectMake(7, 20, 45, 45)];
            [backBUtton setImage:[UIImage imageNamed:@"返回-拷贝-4"] forState:UIControlStateNormal];
            [backBUtton addTarget:self action:@selector(topButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:backBUtton];
            return cell;

        }else{
        
            LDGoodsSection1 * cell = [tableView dequeueReusableCellWithIdentifier:Section1];;
            
            cell.goodsDetailModel = self.goodsDetailModel;
                        return cell;

        }
        
    }else if (indexPath.section == 1){
        
        LDSection2 * cell = [tableView dequeueReusableCellWithIdentifier:Section2];;
        cell.goodsDetailModel = self.goodsDetailModel;
        [cell.popButton addTarget:self action:@selector(popButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.GoodsName);
        }];
        [button addTarget:self action:@selector(popButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }else if (indexPath.section == 2){
        LDSection3 * cell = [tableView dequeueReusableCellWithIdentifier:Section3];;
        cell.goodsDetailModel = self.goodsDetailModel;
        
        return cell;

        
    }else{
        
        LDSection4 * cell = [tableView dequeueReusableCellWithIdentifier:Section4];
        cell.goodsDetailModel = self.goodsDetailModel;
        
        return cell;

        }
    
}


- (void)popButtonClick{
    
    if (self.fromWhere != nil) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
   
        LDBusnessController * vc = [[LDBusnessController alloc] init];
        
        vc.busnessID = [LDGoodsIDAndZhuanAnId sharedInstance].busnessID;
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        
        if (indexPath.row == 0) {
            
            return heightProportion;

        }else{
            
            return 100;

        }
        
    }else if (indexPath.section == 1){
 
        return 105;



        
    }else if (indexPath.section == 2){
        
        // 字符串模型数据
        NSString *topic = self.goodsDetailModel.parameter;
        
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2* LDPadding, MAXFLOAT);
        
        CGFloat textH = [topic boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        // cell的高度
        CGFloat cellH = 55 + textH + LDPadding;
        
        return cellH;


        
    }else{
        // 字符串模型数据
        NSString *topic = self.goodsDetailModel.desc;
        
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2* LDPadding, MAXFLOAT);
        // 字符串模型数据高度
        CGFloat textH = [topic boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        CGFloat goodsDescH = 60;
        // cell的高度
        CGFloat cellH = goodsDescH + textH + 5;
        
        return cellH;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 1;
    }else{
        
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
    
}

//返回商品类别
- (NSString *)returnCommoditys{
    
    NSMutableArray * commoditys = [NSMutableArray array];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:@"1" forKey:@"commodityCount"];
    [dict setObject:self.goodsID forKey:@"commodityId"];
    
    [commoditys addObject:dict];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:commoditys options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* sInvalid = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // 从服务器收到的类似上一行的数据 // 转换
    NSString*sValid = [sInvalid stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    sValid= [sValid stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    sValid= [sValid stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    sValid= [sValid stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData * data =[sValid dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *jsonString = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    

    
    return jsonString;
    
}

@end
