//
//  LDConformOrderViewController.m
//  HDJFKJ
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDConformOrderViewController.h"
#import "LDGoodsSection1.h"
#import "LDSection2.h"
#import "LDSection3.h"
#import "LDSection4.h"
#import "LDConformOrderCell.h"
#import "LDGoodsDetailCell.h"
#import "LDSelectButton.h"
#import "LDMonthPayCell.h"
#import "LDConformOrderViewCell.h"
#import "LDMonthPayViewCell.h"
#import "LDGoodsDetailModel.h"
#import "LDHaveCardListModel.h"
#import "LDBaseInformationTableViewController.h"

#import "LDContactInformationViewController.h"
#import "WHWorkViewController.h"
#import "LDGoodsIDAndZhuanAnId.h"

#import "LDPostIDCard.h"
#import "LDtest2222ViewController.h"
#import "LDBankCardViewController.h"
#import "LDPaymentPasswordController.h"
#import "AuthorizViewController.h"
#import "WHSendOtherMateriaController.h"
#import "WHPasswordView.h"
#import "TZMD5.h"

/** 是否需要收取运营商模型 */
#import "HDForceAuthFlag.h"

@interface LDConformOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) UILabel * monthMoney;

@property (nonatomic,strong) NSArray * cellDataArray;
@property (nonatomic,strong) LDGoodsDetailModel * goodsDetailModel;

@property (nonatomic,strong) NSArray * cases;
@property (nonatomic,strong) UIButton * button;
@property (nonatomic,strong) UIButton * SelectButton;
@property (nonatomic,strong) UIButton * firstButton;

//2.0.4修改
//支付密码的b半透明背景
@property (nonatomic,strong) UIView * backgroundView;
//密码框，半窗白色背景图
@property (nonatomic,strong) UIView * passwordBgView;
//密码框
@property (nonatomic,strong) WHPasswordView * passwordView;

@end

@implementation LDConformOrderViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //取消键盘通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

//键盘通知
- (void)registerForKeyboardNotifications
{
 
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LDBackroundColor;
    [self creatSubView];
    self.navigationItem.title = @"确认订单";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDConformOrderCell class]) bundle:nil] forCellReuseIdentifier:ConformOrderCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDSelectButton class]) bundle:nil] forCellReuseIdentifier:SelectButton];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDMonthPayCell class]) bundle:nil] forCellReuseIdentifier:monthPay];
    
}
static NSString * const ConformOrderCell = @"ConformOrderCell";
static NSString * const SelectButton = @"SelectButton";
static NSString * const monthPay = @"monthPay";
-(void)setGoodsID:(NSString *)goodsID{
    
    _goodsID = goodsID;
    
    [self OnceModresendRequest];
}
- (NSArray *)cases
{
    if (!_cases) {
        
        _cases = [NSArray array];
        
    }
    
    return _cases;
}
//网络请求(加载页面数据)
- (void)OnceModresendRequest{
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * url = [NSString stringWithFormat:@"%@detail/commodity",KBaseUrl];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:self.goodsID forKey:@"id"];
    
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
                
                /** 4.解析请求结果 */
                if (backInfo.result != nil){
                    self.goodsDetailModel = [LDGoodsDetailModel mj_objectWithKeyValues:backInfo.result];
                    
                    
                    self.cases = [LDGoodsDetailIDModel mj_objectArrayWithKeyValuesArray:self.goodsDetailModel.cases];
                    
                    LDLog(@"%lu",(unsigned long)self.cases.count);
                }
                
                [self.tableView reloadData];
            }
            else{
                
                [HDLoading showFailViewWithString:backInfo.message];
            }
 
        }
    }];
}


/**
 *  返回多少行cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        LDConformOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ConformOrderCell];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodsDetailModel = self.goodsDetailModel;
        return cell;
        
    }else if (indexPath.section == 1){
        
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * note = [UILabel new];
        note.text = @"选择期数";
        note.font = LD15Font;
        [cell.contentView addSubview:note];
        
        
        [note makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(LDPadding);
            if (self.cases.count < 3) {
                make.centerY.equalTo(cell.contentView);
            }else{
                make.top.equalTo(cell.contentView).offset(5);
            }
            
            make.width.equalTo(70);
        }];
        for (int i = 0 ; i < self.cases.count; i++) {
            
            LDGoodsDetailIDModel * model = self.cases[i];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            self.button = button;
            
            if (i == 0) {
                [self cellButtonClick:self.button];
            }
            [button setTitle:[NSString stringWithFormat:@"%@期",model.duration] forState:UIControlStateNormal];
            [button setFont:[UIFont systemFontOfSize:10]];
            
            
            [button setTitleColor:[UIColor blackColor
                                   ] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor
                                   ] forState:UIControlStateSelected];
            [button setTitle:[NSString stringWithFormat:@"%@期",model.duration] forState:UIControlStateSelected];
            
            [cell.contentView addSubview:button];
            [button setBackgroundImage:[UIImage imageNamed:@"没选中"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
            
            button.tag = i;
            [button addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [button makeConstraints:^(MASConstraintMaker *make) {
                if (i<3) {
                    
                    make.left.equalTo(note.right).offset(i*75);
                    
                }else if ((i>2)&&(i<6)){
                    
                    make.left.equalTo(note.right).offset((i - 3)*75);
                    
                    
                }else if ((i>5)&&(i<9)){
                    
                    make.left.equalTo(note.right).offset((i - 6)*75);
                }
                
                if (i < 3) {
                    make.centerY.equalTo(note);
                    
                }else if ((i>2)&&(i<6)){
                    make.top.equalTo(cell.contentView.top).offset(30);
                    
                }else if ((i>5)&&(i<9)){
                    
                    make.top.equalTo(cell.contentView.top).offset(60);
                }
                make.size.equalTo(CGSizeMake(60, 25));
                
                
            }];
            
            
        }
        
        return cell;
        
        
        
    }else{
        
        LDMonthPayCell * cell = [tableView dequeueReusableCellWithIdentifier:monthPay];
        
        cell.monthPay.hidden = YES;
        if (self.monthMoney == nil) {
            
            UILabel * lable1 = [UILabel new];
            
            [cell.contentView addSubview:lable1];
            
            lable1.backgroundColor = [UIColor clearColor];
            
            self.monthMoney = lable1;
            
            [lable1 makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.monthPay);
            }];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
}



- (void)cellButtonClick:(UIButton *)button{
    self.SelectButton.selected = NO;
    button.selected = YES;
    self.SelectButton = button;
    
    NSInteger tag = button.tag;
    
    LDGoodsDetailIDModel * model = self.cases[tag];
    
    self.monthMoney.text = [NSString stringWithFormat:@"%.2f",[model.periodamount floatValue]];
    self.monthMoney.textColor = [UIColor redColor];
    
    [[LDGoodsIDAndZhuanAnId sharedInstance] setZhuanAnID:model.id];
    LDLog(@"%@",model.id);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 190;
        
    }else if (indexPath.section == 1){
        
        if (self.cases.count < 3) {
            return 45;
        }else if ((self.cases.count>2)&&(self.cases.count<6)){
            
            return 30*2;
        }else{
            
            return 30*3;
            
        }
    }else{
        
        return 50;
    }
    
}



- (void)creatSubView{
    
    UITableView * tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LDScreenWidth, LDScreenHeight - 50) style:UITableViewStyleGrouped];
    tabbleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabbleView];
    tabbleView.delegate = self;
    tabbleView.dataSource = self;
    self.tableView = tabbleView;
    
    
    UIView * BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, LDScreenHeight - 50, LDScreenWidth, 50)];
    
    BottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:BottomView];
    
    UIView * upline = [UIView new];
    [BottomView addSubview:upline];
    upline.alpha = 0.5;
    upline.backgroundColor = [UIColor blackColor];
    upline.hidden = YES;
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
    
    
    UIButton * bottomButotn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButotn setTitle:@"确认" forState:UIControlStateNormal];
    bottomButotn.font = LD17Font;
    [BottomView addSubview:bottomButotn];
    [bottomButotn setBackgroundImage:[UIImage imageNamed:@"购买按钮"] forState:UIControlStateNormal];
    [bottomButotn addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
    [bottomButotn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upline);
        make.bottom.equalTo(downline);
        make.right.equalTo(BottomView.right);
        make.left.equalTo(BottomView.left);
        
    }];
}
/**
 *  立刻购买
 */
- (void)buyNow{
    
    
    //验证用户信息是否完善
    [self sendRequest];
    
}
/**
 *  跳转到未完善页面
 */
- (void)sendRequest{
    
    [HDLoading showWithImageWithString:@"正在验证"];
    
    NSString * url = [NSString stringWithFormat:@"%@customInfo/infoStep",KBaseUrl];
    
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
            
            LDGoodsDetailModel * model = [LDGoodsDetailModel mj_objectWithKeyValues:response];
            
            switch ([model.code intValue]) {
                    
                case 0://信息已经完善,
                {
                    [HDLoading dismissHDLoading];
                    
                    [self createPasswordBan];
                }
                    break;
                case -100://服务器错误
                    
                    [HDLoading showFailViewWithString:@"网络错误"];
                    
                    break;
                    
                case -21://请完善支付密码
                {
                    [HDLoading showFailViewWithString:@"支付密码未完善"];
                    
                    LDPaymentPasswordController * vc = [[LDPaymentPasswordController alloc] init];
                    vc.fromeWhere = @"xiadan";
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    break;
                }
                case -3://请完善基本信息
                {//学生.工人,创业者,跳转到不同页面.
                    [HDLoading showFailViewWithString:@"身份证信息未完善"];
                    
                    LDPostIDCard * vc = [[LDPostIDCard alloc] init];
                    vc.fromeWhere = @"xiadan";
                    vc.requestImage = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case -4:
                {//选择身份
                    [HDLoading showFailViewWithString:@"身份证信息未完善"];
                    LDPostIDCard * vc = [[LDPostIDCard alloc] init];
                    vc.fromeWhere = @"xiadan";
                    vc.requestImage = NO;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case -41://请完善上班族工作信息
                {
                    [HDLoading showFailViewWithString:@"工作信息未完善"];
                    WHWorkViewController * vc = [[WHWorkViewController alloc] init];
                    vc.fromeWhere = @"xiadan";
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                    
                case -42://完善学生工作信息
                {
                    
                    [HDLoading showFailViewWithString:@"工作信息未完善"];
                    WHWorkViewController * vc = [[WHWorkViewController alloc] init];
                    vc.fromeWhere = @"xiadan";
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                    
                case -43://完善创业者工作信息
                {
                    
                    
                    [HDLoading showFailViewWithString:@"工作信息未完善"];
                    
                    
                    WHWorkViewController * vc = [[WHWorkViewController alloc] init];
                    vc.fromeWhere = @"xiadan";
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case -5://请完善高级信息
                {
                    [HDLoading showFailViewWithString:@"身份证信息未完善"];
                    LDPostIDCard * vc = [[LDPostIDCard alloc] init];
                    vc.fromeWhere = @"xiadan";
                    vc.requestImage = NO;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case -6://请完善联系人信息
                {
                    [HDLoading showFailViewWithString:@"联系人信息未完善"];
                    
                    
                    LDContactInformationViewController * vc = [[LDContactInformationViewController alloc] init];
                    vc.fromeWhere = @"xiadan";
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    break;
                }
                    
            }
            
        }
        
    }];
    
}

//弹出支付密码窗
- (void)createPasswordBan{
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];;
    
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self.backgroundView];
    
    self.passwordBgView= [[UIView alloc]initWithFrame:CGRectMake(0, LDScreenHeight, LDScreenWidth, 800)];
    self.passwordBgView.backgroundColor = WHColorFromRGB(0xf0f0f0);
    self.passwordBgView.layer.cornerRadius = 10.0f;
    self.passwordBgView.layer.borderColor = [[UIColor clearColor] CGColor];
    self.passwordBgView.layer.borderWidth = 0;
    [self.backgroundView addSubview:self.passwordBgView];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, LDScreenWidth, 50)];
    titleLabel.text = @"输入支付密码";
    titleLabel.textColor = WHColorFromRGB(0x2b2b2b);
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.passwordBgView addSubview:titleLabel];
    
    
    UIButton * cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"quxiao_helight"] forState:UIControlStateHighlighted];
    [self.passwordBgView addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(removePasswordView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, LDScreenWidth, 0.5)];
    lineView.backgroundColor = WHColorFromRGB(0xd9d9d9);
    [self.passwordBgView addSubview:lineView];
    
    self.passwordView= [[WHPasswordView alloc]initWithFrame:CGRectMake((LDScreenWidth-270*LDScreenWidth/375)/2, 80, 270*LDScreenWidth/375, 270*LDScreenWidth/375/6)];
    
    
    __weak LDConformOrderViewController * weakSelf = self;
    self.passwordView.complationBlock = ^(NSString * password){
        
        if (password.length == 6) {
            [weakSelf sendZhifuPassword:password];
            [weakSelf removePasswordView];
        }
        
    };
    [self.passwordBgView addSubview:self.passwordView];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        self.passwordBgView.frame = CGRectMake(0, self.view.frame.size.height -266 - 150, LDScreenWidth, 800);
    }];
}


//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.35 animations:^{
        self.passwordBgView.frame = CGRectMake(0, self.view.frame.size.height , LDScreenWidth, 800);
    } completion:^(BOOL finished){
        
        [self.backgroundView removeFromSuperview];
    }];
}


/**
 * 发送支付密码
 **/
- (void)sendZhifuPassword:(NSString *)password{
    [HDLoading showWithImageWithString:@"正在验证"];
    
    NSString * str = [NSString stringWithFormat:@"%@order/pay",KBaseUrl ];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    [params setObject:[TZMD5 md5:password] forKey:@"payPassword"];
    
    
    [[LDNetworkTools sharedTools] request:POST url:str params:params callback:^(id response, NSError *error) {
        if (error != nil) {
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
            
            LDLog(@"%@",response);
            
            /** 3.解析返回信息*/
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                /** 4.发送是否需要授信请求 */
                [self panDuanShiFouXuYaoShouXin];
            }else{
                
                /** 5.请求异常提示  */
                [HDLoading showFailViewWithString:backInfo.message];
            }
        }
    }];
    
}

- (void)panDuanShiFouXuYaoShouXin{
    NSString * str = [NSString stringWithFormat:@"%@forceAuthFlag",KBaseUrl ];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    [params setObject:self.goodsDetailModel.businessid forKey:@"businessId"];
    
    
    [[LDNetworkTools sharedTools] request:POST url:str params:params callback:^(id response, NSError *error) {
        if (error != nil) {
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
        
            //给提交订单模型，赋值
            [[HDSubmitOrder shardSubmitOrder] setCaseId:[LDGoodsIDAndZhuanAnId sharedInstance].zhuanAnID];
            
            /** 4.code == 0请求成功 */
            if ([backInfo.code isEqualToString:@"0"]) {
                [HDLoading dismissHDLoading];
                
                /** 5.解析返回信息 */
                if (backInfo.result != nil) {
                    HDForceAuthFlag * force = [HDForceAuthFlag mj_objectWithKeyValues:backInfo.result];
                    
                    //0表示不需要授信，1表示需要授信
                    if ([force.authFlag isEqualToString:@"0"]) {
                        
                        WHSendOtherMateriaController * sendMateria = [[WHSendOtherMateriaController alloc]init];
                        
                        sendMateria.fromWhere = @"xiadan";
                        
                        [self.navigationController pushViewController:sendMateria animated:YES];
                    }else{
                        
                        AuthorizViewController * auth = [[AuthorizViewController alloc]init];
                        auth.fromWhere = @"xiadan";
                        [self.navigationController pushViewController:auth animated:YES];
                    }
                }else{
                    AuthorizViewController * auth = [[AuthorizViewController alloc]init];
                    auth.fromWhere = @"xiadan";
                    [self.navigationController pushViewController:auth animated:YES];
                }
                
            }else{
                
                /** 6.请求异常提示 */
                [HDLoading showFailViewWithString:backInfo.message];
                
            }
            
            LDLog(@"%@",response);
        }
    }];

}

//取消输入支付密码
- (void)removePasswordView{
    [self.passwordView endEditing:YES];
}




@end
