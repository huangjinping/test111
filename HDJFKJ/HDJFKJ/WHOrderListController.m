

#import "WHOrderListController.h"
#import "WHOrderListCell.h"
#import "HDOrderModel.h"
#import "LDNewOrderDetailVC.h"
#import "LDNewOrderListModel.h"
#import "LDOrderListCell.h"

@interface WHOrderListController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
//当前选中的Button
@property (nonatomic, strong) UIButton * currentButton;
//当前选中的button对应的下方的横线
@property (nonatomic, strong) UILabel * currentLabel;

@property (nonatomic, strong) UIScrollView * scrollView;

//显示订单的TableView
@property (nonatomic, strong) UITableView * mainTableView;

//没有数据的试图
@property (nonatomic, strong) UIView * nullDataView;

//======新模型赋值====//
/** dataArray  */
@property (nonatomic,strong) NSArray * dataArray;
/** 商户名  */
@property (nonatomic,strong) UILabel * busiessName;
/** 订单状态  */
@property (nonatomic,strong) UILabel * status;
/** 商品数量  */
@property (nonatomic,strong) UILabel * goodsNum;
/** 合计  */
@property (nonatomic,strong) UILabel * sumPrice;
/** 首付,期数,  */
@property (nonatomic,strong) UILabel * firstPay;
/** 商户图片  */
@property (nonatomic,strong) UIImageView * busiesNameImage;

@end

@implementation WHOrderListController




//隐藏taber
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //设置导航栏的背景色
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.hidden = YES;
    self.parentViewController.tabBarController.tabBar.hidden = YES;
    
    
}
//显示taber
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.parentViewController.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    
    self.view.backgroundColor = WHColorFromRGB(0xe8e8e8);
    
    //1.创建按钮
    [self createContentButtonView];
    
    //2.创建订单列表
    [self createOrderListView];
    
    //3.创建无数据试图
    [self createNullDataView];
    
    
    //发送网络请求
    [self sendRequest];
    
}

//创建订单状态按钮的试图，及按钮
- (void)createContentButtonView{
    
    //按钮title数组
    NSArray * array = @[@"全部",@"审核中",@"已通过",@"已打回",@"已取消",@"已拒绝",@"还款中",@"已完成"];
    
    //scrollview用于加载订单状态按钮
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    _scrollView.contentSize = CGSizeMake(80 * array.count, 40);
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    
    //分割线
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 40 - 0.5, self.view.frame.size.width, 0.5)];
    
    bottomLine.backgroundColor = WHColorFromRGB(0xdcdbde);
    [self.view addSubview:bottomLine];

    float buttonWidth = 80;
    for (int i = 0; i < array.count; i++) {
        
        //创建按钮
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [[UIButton alloc]initWithFrame:CGRectMake(i*buttonWidth,0, buttonWidth, 40)];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:WHColorFromRGB(0x323232) forState:UIControlStateNormal];
        [button setTitleColor:WHColorFromRGB(0x4279d6) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        if (i > 5){
            button.tag = i+1;
        }
        else{
            button.tag = i;
        }
        
        [button addTarget:self action:@selector(clickOrderStatus:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];

        //默认选中第一个按钮
        if (i == 0) {
            
            button.selected = YES;
           
            self.currentButton = button;
            
        }
    }
    
    //按下方放入红色横线
    self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 , 39, 50, 1)];
    self.currentLabel.backgroundColor = WHColorFromRGB(0x4279d6);
    
    [_scrollView addSubview:self.currentLabel];
    
    
}
//按钮响应方法
- (void)clickOrderStatus:(UIButton *)sender{
    self.currentButton.selected = NO;
    
    
    sender.selected = YES;
    self.currentButton = sender;
 
    self.orderStatus = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self sendRequest];
    
    [UIView animateWithDuration:0.3f animations:^{
        if (sender.tag > 5) {
             self.currentLabel.frame = CGRectMake(15 + 80*(sender.tag -1) , 39, 50, 1);
        }
        else{
             self.currentLabel.frame = CGRectMake(15 + 80*sender.tag , 39, 50, 1);
        }
       
    }];
    
}
static NSString * const OrderListCell = @"OrderListCell";

//创建订单列表
- (void)createOrderListView{

    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width,self.view.frame.size.height - 104) style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = WHColorFromRGB(0xe8e8e8);
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDOrderListCell class]) bundle:nil] forCellReuseIdentifier:OrderListCell];
}

- (void)createNullDataView{
    
    self.nullDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height -104)];
    self.nullDataView.backgroundColor = WHColorFromRGB(0xf5f5f9);
    
    UIImageView * nullImageView = [[UIImageView alloc]initWithFrame:CGRectMake((LDScreenWidth-80)/2, (self.nullDataView.frame.size.height - 80)/2-57, 80, 80)];
    NSLog(@"%f",nullImageView.frame.origin.y);
    nullImageView.image = [UIImage imageNamed:@"firstpage_noLogin"];
    [self.nullDataView addSubview:nullImageView];
    self.nullDataView.hidden = YES;
    
    UILabel * nullDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, nullImageView.frame.origin.y + 80 + 16, LDScreenWidth, 17)];
    nullDataLabel.text = @"暂无订单";
    nullDataLabel.font = [UIFont systemFontOfSize:13];
    nullDataLabel.textAlignment = NSTextAlignmentCenter;
    nullDataLabel.textColor = WHColorFromRGB(0x979797);
    [self.nullDataView addSubview:nullDataLabel];
    
    
    [self.view addSubview:self.nullDataView];

}


#pragma mark -- tableView协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
    
}
- (void)reloadSectionFooterAndHeaderViewData{
    
    self.goodsNum.text = @"共20件商品";

    self.sumPrice.text = [NSString stringWithFormat:@"合计:%@",@"共20件商品"];
    self.firstPay.text = [NSString stringWithFormat:@"首付:%@",@"共20件商品"];
    self.busiesNameImage.image = [UIImage imageNamed:@"choosework_xuesheng"];
    self.busiessName.text = @"北京对打啊啊啊请问额";
    self.status.text = @"带审核";

    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView * backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    
    self.goodsNum = [UILabel new];
    
    self.goodsNum.textColor = WHColorFromRGB(0x2b2b2b);
    
    self.goodsNum.font = [UIFont systemFontOfSize:12];
    [backView addSubview:self.goodsNum];
    [self.goodsNum makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(LDPadding);
        make.top.equalTo(backView).offset(5);
        make.height.equalTo(15);
    }];

    self.sumPrice = [UILabel new];
    
    self.sumPrice.textColor = WHColorFromRGB(0x2b2b2b);
    
    self.sumPrice.font = [UIFont systemFontOfSize:12];
    [backView addSubview:self.sumPrice];
    [self.sumPrice makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(5);
        make.left.equalTo(self.goodsNum.right).offset(10);
        make.height.equalTo(15);
    }];

    self.firstPay = [UILabel new];
    
    self.firstPay.textColor = WHColorFromRGB(0x2b2b2b);
    
    self.firstPay.font = [UIFont systemFontOfSize:12];

    [backView addSubview:self.firstPay];
    [self.firstPay makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsNum.bottom);
        make.left.equalTo(self.goodsNum);
        make.bottom.equalTo(backView);
    }];
    
    NSInteger goodsCount = 0;
    
    LDNewOrderListModel * list = self.dataArray[section];

    for (int i = 0; i < list.orderCommoditys.count; i++) {
        
        LDSmallOrderListModel * small = list.orderCommoditys[i];
        
        goodsCount += [small.commodityCount integerValue];
    }
    
    //几件商品
    self.goodsNum.text = [NSString stringWithFormat:@"共%ld件商品",(long)goodsCount];
    self.goodsNum.textColor = WHColorFromRGB(0x6f7179);
    
    //合计,总价
    self.sumPrice.text = [NSString stringWithFormat:@"合计:￥%.2f",[list.totalPrice floatValue]];
    self.sumPrice.textColor = WHColorFromRGB(0x6f7179);
    
    //首付
    self.firstPay.text = [NSString stringWithFormat:@"首付%.2f + ￥%.2f x %@期",[list.downpayment floatValue],[list.periodAmount floatValue],list.duration];
    self.firstPay.textColor = WHColorFromRGB(0x4279d6);
    
    
    
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = LDBackroundColor;
    
    UIView * backView = [UIView new];
    
    [backgroundView addSubview:backView];
    
    
    if (section != 0) {
        
        backView.frame = CGRectMake(0, 10, LDScreenWidth, 40);
    }else{
        backView.frame = CGRectMake(0, 0, LDScreenWidth, 40);
    }
    
    
    backView.backgroundColor = [UIColor whiteColor];
    
    self.busiesNameImage = [[UIImageView alloc] init];
    [backView addSubview:self.busiesNameImage];
    
    [self.busiesNameImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(13);
        make.bottom.equalTo(backView).offset(-12);
        make.left.equalTo(backView).offset(LDPadding);
        make.width.equalTo(15);
    }];
    
    self.busiessName = [UILabel new];
    self.busiessName.font = LD15Font;
    
    self.busiessName.textColor = WHColorFromRGB(0x2b2b2b);
    
    [backView addSubview:self.busiessName];
    
    [self.busiessName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.busiesNameImage.right).offset(LDPadding);
        make.top.bottom.equalTo(backView);
        
    }];

    /**   箭头图标         */
    UIImageView * arrowImageView = [UIImageView new];
    arrowImageView.image = [UIImage imageNamed:@"返回"];
    [backView addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(13);
        make.right.equalTo(backView).offset(-LDPadding);
        make.width.equalTo(8);
        make.height.equalTo(15);
    }];
    
    
    /**   订单状态label    */
    self.status = [UILabel new];
    self.status.font = LD15Font;
    self.status.textColor = WHColorFromRGB(0x4279d6);
    [backView addSubview:self.status];
    [self.status makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.right.equalTo(arrowImageView).offset(-LDPadding);
    }];
    LDNewOrderListModel * list = self.dataArray[section];
    self.status.text = [NSString stringWithFormat:@"%@",list.status];
    self.busiessName.text = [NSString stringWithFormat:@"%@",list.businessName];
    self.busiesNameImage.image = [UIImage imageNamed:@"shop"];

    
    //return backView;
    return backgroundView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LDNewOrderListModel * list = self.dataArray[section];
    
    return list.orderCommoditys.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    //return 35;
    if (section != 0) {
        return 50;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LDOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderListCell];
    
    LDNewOrderListModel * list = self.dataArray[indexPath.section];
    
    LDSmallOrderListModel* smallModel = list.orderCommoditys[indexPath.row];
    
    cell.smallModel = smallModel;
    
    
    return cell;

    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDNewOrderListModel * orderModel = self.dataArray[indexPath.section];
    

    LDNewOrderDetailVC * orderDetail = [[LDNewOrderDetailVC alloc]init];
    
    orderDetail.applyId = [NSString stringWithFormat:@"%@",orderModel.id];
    
    [self.navigationController pushViewController:orderDetail animated:YES];
    

}


/**
 * 网络请求,获取订单列表
 **/
- (void)sendRequest{
    
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * str = [NSString stringWithFormat:@"%@order/list",KBaseUrl ];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    if (self.orderStatus == nil ) {
        self.orderStatus = @"0";
    }
    [params setObject:self.orderStatus forKey:@"status"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    
    [[LDNetworkTools sharedTools] request:POST url:str params:params callback:^(id response, NSError *error) {
        if (error != nil) {
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{

            LDLog(@"%@",response);
            
            [HDLoading dismissHDLoading];
            
            /** 3.解析返回信息 */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfo.code isEqualToString:@"0"]) {
                
                /** 4.解析订单列表  */
                self.dataArray = [LDNewOrderListModel mj_objectArrayWithKeyValuesArray:backInfo.result];
                
                if (self.dataArray.count > 0) {
                    
                    self.nullDataView.hidden = YES;
                    
                    [self.mainTableView reloadData];
                }else{
                    self.nullDataView.hidden = NO;
                }
                
                for (LDNewOrderListModel * or3derListModel in self.dataArray) {
                    
                    LDSmallOrderListModel * model = or3derListModel.orderCommoditys[0];
                    
                    LDLog(@"%@",model.commodityName);
                    LDLog(@"%@",model.pic);
                    LDLog(@"%@",model.commodityCount);
                    
                    
                    
                    LDLog(@"%@",or3derListModel.id);
                    LDLog(@"%@",or3derListModel.businessId);
                    LDLog(@"%@",or3derListModel.businessName);
                    
                }
                
            }
            else{
                
                // 显示失败信息
                [HDLoading showFailViewWithString:backInfo.message];
            }
            
        }
    }];
}



@end
