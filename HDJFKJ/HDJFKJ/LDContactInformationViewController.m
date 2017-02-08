

#import "LDContactInformationViewController.h"
#import "WHContactInfoView.h"
#import "LDBasicGroupModel.h"
#import "LDBasicModel.h"
#import "LDBaseInformationCell.h"
#import "LDTabBarController.h"
#import "LTPickerView/LTPickerView.h"
#import "WHTiJiaoControllrt.h"
#import "AuthorizViewController.h"
#import "WHLianXiRenInfoModel.h"
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "STPickerArea.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"
#import "WHPersonProcessTopView.h"
#import "WHSendOtherMateriaController.h"
#import "LDNavgationVController.h"
#import "HDAddressBookController.h"
#import "WHAddressBookModel.h"

/** 是否需要授权运营商模型 */
#import "HDForceAuthFlag.h"
/** 通讯录类  */
#import "WHGetAddressBook.h"

//#import "IQKeyboardManager.h"

@interface LDContactInformationViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ABPeoplePickerNavigationControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) WHContactInfoView * contactInfoView;

//选择按钮的tag值
@property (nonatomic, assign) NSInteger buttonTag;
//打回修改。联系人模型
@property (nonatomic, strong) WHLianXiRenInfoModel * reliatonModel;

/**
 *  关系
 */
@property (nonatomic,strong) NSString * relationshipNum1;
@property (nonatomic,strong) NSString * relationshipNum2;
@property (nonatomic,strong) NSString * relationshipNum3;

@property (nonatomic, assign) BOOL  isEnding;

@property (nonatomic,assign) float addHeight;

@property (nonatomic, weak) NSTimer * timer;

/** 通讯录数据 */
@property (nonatomic, strong) NSMutableArray * addressBookArray;

@end

@implementation LDContactInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [IQKeyboardManager sharedManager].enable = NO;
    
    self.title = @"联系人信息";
    self.view.backgroundColor = WHColorFromRGB(0xf0f0f0);
    //1.创建ScrollView
    [self createScrollView];
    
    //2.创建联系人试图
    [self createContactInfoView];
    
    //3.获取联系人信息
    if (([self.fromeWhere isEqualToString:@"xinyongfen"] && [self.isFinsh isEqualToString:@"1"]) || [self.fromeWhere isEqualToString:@"xiugai"] || ([self.fromeWhere isEqualToString:@"shenhe"] && [self.isFinsh isEqualToString:@"1"])) {
        [self requestUserMessageRequest];
    }
    self.isEnding = YES;
    

    //消除第一响应者
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponderForTextFiled:)];
    [self.view addGestureRecognizer:tap];
}
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    BOOL isAddressBook = [WHGetAddressBook getAddressBookMessage];
    
    if (isAddressBook) {
        /** 获取通讯录 */
        self.addressBookArray = [WHGetAddressBook returnAddressBookMessage];
    }else{
        
        UIAlertController *avc = [UIAlertController alertControllerWithTitle:@"提示" message:@"访问通讯录，选择联系人是否允许？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
            
            
        }];
        [avc addAction:action];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [avc addAction:action2];
        
        [self presentViewController:avc animated:YES completion:nil];
    }
}


- (void)resignFirstResponderForTextFiled:(UITapGestureRecognizer *)tap{
    
    
    [self.view endEditing:YES];
}



//1.创建ScrollView
- (void)createScrollView{
    

    //初始化scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, LDScreenWidth, LDScreenHeight -64)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
//    self.addHeight= 0.0;
//    
//    if (![self.fromeWhere isEqualToString:@"xinyongfen"] && ![self.fromeWhere isEqualToString:@"xiugai"] && ![self.fromeWhere isEqualToString:@"shenhe"]) {
//        self.addHeight = 90 * LDScreenWidth/375;
//        WHPersonProcessTopView * topView = [WHPersonProcessTopView view];
//        topView.frame = CGRectMake(0, 0, LDScreenWidth, 90 * LDScreenWidth/375);
//        NSArray * array1 = @[@"person_shenfenzheng_selected",@"person_jiben_selected",@"person_congye_selected",@"person_lianxiren_selected"];
//        NSArray * array2 = @[@"person_arrow1",@"person_arrow2",@"person_arrow3"];
//        [topView initImageNameWithIconImageNameArr:array1 arrowImageNameArr:array2];
//        [_scrollView addSubview:topView];
//    }
    _scrollView.contentSize = CGSizeMake(LDScreenWidth, LDScreenHeight -64);
    _scrollView.backgroundColor = LDBackroundColor;
}
//2.创建联系人试图
- (void)createContactInfoView{
    //初始化子视图
    _contactInfoView = [WHContactInfoView view];
   
    _contactInfoView.frame = CGRectMake(0, 0, LDScreenWidth, LDScreenHeight -64);
    [_scrollView addSubview:_contactInfoView];
    
    //设置控件(联系人1)
    _contactInfoView.contactName1.keyboardType = UIKeyboardTypeDefault;
    _contactInfoView.contactName1.tag = 1;
    _contactInfoView.contactName1.delegate = self;
    [_contactInfoView.contactButton1 addTarget:self action:@selector(clickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _contactInfoView.relationship1.tag = 2;
    _contactInfoView.relationship1.delegate = self;
    _contactInfoView.relationship1.keyboardType = UIKeyboardTypeDefault;
    [_contactInfoView.relationButton1 addTarget:self action:@selector(clickRelationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _contactInfoView.phoneNumber1.keyboardType = UIKeyboardTypeNumberPad;
    _contactInfoView.phoneNumber1.tag = 3;
    _contactInfoView.phoneNumber1.delegate = self;
    
    //(联系人2)
    _contactInfoView.contactName2.keyboardType = UIKeyboardTypeDefault;
    _contactInfoView.contactName2.tag = 4;
    _contactInfoView.contactName2.delegate = self;
    [_contactInfoView.contactButton2 addTarget:self action:@selector(clickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _contactInfoView.relationship2.tag = 5;
    _contactInfoView.relationship2.delegate = self;
    _contactInfoView.relationship2.keyboardType = UIKeyboardTypeDefault;
    [_contactInfoView.relationButton2 addTarget:self action:@selector(clickRelationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _contactInfoView.phoneNumber2.keyboardType = UIKeyboardTypeNumberPad;
    _contactInfoView.phoneNumber2.tag = 6;
    _contactInfoView.phoneNumber2.delegate = self;
    
    
   /*************************************/
    _contactInfoView.contactButton1.tag = 1;
    _contactInfoView.contactButton2.tag = 2;
    _contactInfoView.contactButton3.tag = 3;
    
    _contactInfoView.relationButton1.tag = 1;
    _contactInfoView.relationButton2.tag = 2;
    _contactInfoView.relationButton3.tag = 3;
    
    [_contactInfoView.nextButton addTarget:self action:@selector(clickNextButton:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.fromeWhere isEqualToString:@"xinyongfen"]){
        [_contactInfoView.nextButton setTitle:@"提交" forState:UIControlStateNormal];
    }
    
    _contactInfoView.nextButton.layer.borderWidth = 0.0;
    _contactInfoView.nextButton.layer.cornerRadius = 5.0;
}

//点击联系人按钮
- (void)clickRelationButton:(UIButton *)sender{
    self.isEnding = NO;
    [self.view endEditing:YES];
    
    
    if (sender.tag == 1) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"关系选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"配偶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship1.text = @"配偶";
            self.relationshipNum1 = @"1";
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"父母" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship1.text = @"父母";
            self.relationshipNum1 = @"2";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"子女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship1.text = @"子女";
            self.relationshipNum1 = @"3";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"兄弟姐妹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship1.text = @"兄弟姐妹";
            self.relationshipNum1 = @"9";
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    if (sender.tag == 2) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"关系选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"配偶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"配偶";
            self.relationshipNum2 = @"1";
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"父母" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"父母";
            self.relationshipNum2 = @"2";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"子女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"子女";
            self.relationshipNum2 = @"3";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"兄弟姐妹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"兄弟姐妹";
            self.relationshipNum2 = @"9";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"朋友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"朋友";
            self.relationshipNum2 = @"11";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"同事" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"同事";
            self.relationshipNum2 = @"6";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"同学" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"同学";
            self.relationshipNum2 = @"10";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"合伙人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"合伙人";
            self.relationshipNum2 = @"7";
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"其他血亲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"其他血亲";
            self.relationshipNum2 = @"4";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"其他姻亲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"其他姻亲";
            self.relationshipNum2 = @"5";
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"其他关系" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _contactInfoView.relationship2.text = @"其他关系";
            self.relationshipNum2 = @"8";
        }]];
        
        
        
    }
    
    
    

    
}
#pragma mark -- textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField.tag > 4 && LDScreenHeight < 667) {
        
        [UIView animateWithDuration:0.35f animations:^{
            
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        
    }
    else{
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.35f animations:^{
        
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

//点击下一步按钮,校验用户信息
- (void)clickNextButton:(UIButton *)sender{
    [self.view endEditing:YES];
    
    
    if (_contactInfoView.contactName1.text.length == 0 || _contactInfoView.contactName1.text == nil || self.relationshipNum1.length == 0 || self.relationshipNum1 == nil || self.relationshipNum2.length == 0 || self.relationshipNum2 == nil || _contactInfoView.contactName2.text.length == 0 || _contactInfoView.contactName2.text == nil ) {
        [HDLoading showFailViewWithString:@"请完善联系人信息"];
    }
    else if (![_contactInfoView.contactName1.text isChinese]) {
        [HDLoading showFailViewWithString:@"联系人1的姓名不合法"];
    }
    else if (![_contactInfoView.contactName2.text isChinese]) {
        [HDLoading showFailViewWithString:@"联系人2的姓名不合法"];
    }
    else if (![_contactInfoView.phoneNumber1.text isTelephone:_contactInfoView.phoneNumber1.text]){
        [HDLoading showFailViewWithString:@"联系人1的联系方式不合法"];
    }
    else if (![_contactInfoView.phoneNumber2.text isTelephone:_contactInfoView.phoneNumber2.text]){
        [HDLoading showFailViewWithString:@"联系人2的联系方式不合法"];
    }
    else if (_contactInfoView.contactName3.text.length > 0 && ![_contactInfoView.contactName1.text isChinese]){
        [HDLoading showFailViewWithString:@"联系人3的姓名不合法"];
    }
    else if (_contactInfoView.phoneNumber3.text.length > 0 && ![_contactInfoView.phoneNumber3.text isTelephone:_contactInfoView.phoneNumber3.text]){
        [HDLoading showFailViewWithString:@"联系人3的联系方式不合法"];
    }
    else if ([_contactInfoView.contactName3.text isEqualToString:_contactInfoView.contactName1.text] || [_contactInfoView.contactName3.text isEqualToString:_contactInfoView.contactName2.text] || [_contactInfoView.contactName2.text isEqualToString:_contactInfoView.contactName1.text]){
        [HDLoading showFailViewWithString:@"联系人姓名不能相同"];
    }
    else if ([_contactInfoView.phoneNumber3.text isEqualToString:_contactInfoView.phoneNumber1.text] || [_contactInfoView.phoneNumber3.text isEqualToString:_contactInfoView.phoneNumber2.text] || [_contactInfoView.phoneNumber2.text isEqualToString:_contactInfoView.phoneNumber1.text]){
        [HDLoading showFailViewWithString:@"联系人的联系方式不能相同"];
    }
    else if (_contactInfoView.contactName3.text.length != 0 && (_contactInfoView.relationship3.text.length == 0 ||  _contactInfoView.phoneNumber3.text.length == 0)){
        
        [HDLoading showFailViewWithString:@"联系人3信息不完整"];
    }
    else if ((_contactInfoView.contactName3.text.length == 0 || _contactInfoView.relationship3.text.length == 0 )&&  _contactInfoView.phoneNumber3.text.length != 0){
        
        [HDLoading showFailViewWithString:@"联系人3信息不完整"];
    }
    else if ((_contactInfoView.contactName3.text.length == 0  ||  _contactInfoView.phoneNumber3.text.length == 0 ) && _contactInfoView.relationship3.text.length != 0){
        
        [HDLoading showFailViewWithString:@"联系人3信息不完整"];
    }
    
    else{
        [self sendRequest];
    }
    
}

#pragma mark -- 发送网络请求
/**
 * 发送联系人信息
 **/
- (void)sendRequest{
    
    [HDLoading showWithImageWithString:@"正在提交"];
    
    NSString * url = [NSString stringWithFormat:@"%@register/contacterInfo",KBaseUrl];
    
    [[LDNetworkTools sharedTools] request:POST url:url params:[self getParameters] callback:^(id response, NSError *error) {
        if (error != nil) {
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
            LDLog(@"%@",response);
            
            LDBackInformation * backInfor = [LDBackInformation mj_objectWithKeyValues:response];
            
            if ([backInfor.code isEqualToString:@"0"]) {
                
                [HDLoading dismissHDLoading];

                if ([self.fromeWhere isEqualToString:@"xinyongfen"]) {
                    
                    for (UIViewController * vc in self.navigationController.viewControllers) {
                        
                        NSString * vcClass = [NSString stringWithFormat:@"%@",[vc class]];
                        
                        if ([vcClass isEqualToString:@"LDMySore"]) {
                            
                            //如果是确认订单控制器,就pop到该控制器
                            [self.navigationController popToViewController:vc animated:NO];
                            
                        }
                    }
                    
                }
                
                else if([self.fromeWhere isEqualToString:@"shenhe"]){
                    
                    for (UIViewController * vc in self.navigationController.viewControllers) {
                        
                        NSString * vcClass = [NSString stringWithFormat:@"%@",[vc class]];
                        
                        if ([vcClass isEqualToString:@"LDReViewInformation"]) {
                            [self.navigationController popToViewController:vc animated:YES];
                            
                        }
                    }
                }
                
                else{
                    LDTabBarController * tab = [[LDTabBarController alloc] init];
                    
                    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
                    
                }
  
            }else{
                [HDLoading showFailViewWithString:backInfor.message];
            
            }
        }
    }];
}

- (NSMutableDictionary *)getParameters{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    [parameters setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [parameters setObject:NILSTR(self.contactInfoView.contactName1.text) forKey:@"name1"];
    [parameters setObject:NILSTR(self.relationshipNum1) forKey:@"relation1"];
    [parameters setValue:self.contactInfoView.phoneNumber1.text forKey:@"phone1"];
    [parameters setObject:NILSTR(self.contactInfoView.contactName2.text) forKey:@"name2"];
    [parameters setObject:NILSTR(self.relationshipNum2) forKey:@"relation2"];
    [parameters setValue:self.contactInfoView.phoneNumber2.text forKey:@"phone2"];
    [parameters setObject:NILSTR(self.contactInfoView.contactName3.text) forKey:@"name3"];
    [parameters setObject:NILSTR(self.relationshipNum3) forKey:@"relation3"];
    [parameters setValue:self.contactInfoView.phoneNumber3.text forKey:@"phone3"];
    
    LDLog(@"%@-%@-%@-%@-%@-%@-%@-%@-%@-%@-%@",self.contactInfoView.contactName1.text,self.contactInfoView.relationship1.text,self.contactInfoView.phoneNumber1.text,self.contactInfoView.contactName2.text,self.contactInfoView.relationship2.text,self.contactInfoView.phoneNumber2.text,self.contactInfoView.contactName3.text,self.contactInfoView.relationship3.text,self.contactInfoView.phoneNumber3.text,[LDUserInformation sharedInstance].UserId ,[LDUserInformation sharedInstance].token);
    return parameters;
    
}

#pragma mark -- 获取联系人信息
/**
 * 网络请求,获取联系人信息
 **/
- (void)requestUserMessageRequest{
    
    [HDLoading showWithImageWithString:@"正在加载"];
    
    NSString * str = [NSString stringWithFormat:@"%@customInfo/contacts",KBaseUrl];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[LDUserInformation sharedInstance].UserId forKey:@"id"];
    [params setObject:[LDUserInformation sharedInstance].token forKey:@"token"];
    
    [[LDNetworkTools sharedTools] request:POST url:str params:params callback:^(id response, NSError *error) {
        if (error != nil) {
            
             /** 1.打印请求错误信息*/
            NSLog(@"%@",error);
            
            /** 2.请求错误提示  */
            [HDLoading showFailViewWithString:@"网络错误"];
            
        }else{
            
            /** 3.解析返回数据  */
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
                       
            /** 4.code == 0请求成功 */
            if ([backInfo.code isEqualToString:@"0"]) {
                
                [HDLoading dismissHDLoading];
                
                /** 5.解析联系人信息 */
                if (backInfo.result != nil){
                    
                    self.reliatonModel = [WHLianXiRenInfoModel mj_objectWithKeyValues:backInfo.result];
                    
                    /** 6.给控件赋值*/
                    [self loadRelationData];
                
                }
                
            }else{
                
                /** 7.请求异常提示 */
                [HDLoading showFailViewWithString:backInfo.message];
            }
            
            LDLog(@"%@",response);
        }
    }];
}

- (void)loadRelationData{
    
    //联系人姓名赋值
    if ([self.reliatonModel.name1 isEqualToString:@"(null)"] || [self.reliatonModel.name1 isEqualToString:@"<null>"] || self.reliatonModel.name1 == nil) {
        
    }else{
        _contactInfoView.contactName1.text = _reliatonModel.name1;
        
    }
    if ([self.reliatonModel.name2 isEqualToString:@"(null)"] || [self.reliatonModel.name2 isEqualToString:@"<null>"] || self.reliatonModel.name2 == nil) {
        
    }else{
        _contactInfoView.contactName2.text = _reliatonModel.name2;
        
    }
    if ([self.reliatonModel.name3 isEqualToString:@"(null)"] || [self.reliatonModel.name3 isEqualToString:@"<null>"] || self.reliatonModel.name3 == nil) {
        
    }else{
        _contactInfoView.contactName3.text = _reliatonModel.name3;
        
    }
    
    //联系人手机号
    if ([self.reliatonModel.phone1 isEqualToString:@"(null)"] || [self.reliatonModel.phone1 isEqualToString:@"<null>"] || self.reliatonModel.phone1 == nil) {
        
    }else{
        _contactInfoView.phoneNumber1.text = _reliatonModel.phone1;
        
    }
    if ([self.reliatonModel.phone2 isEqualToString:@"(null)"] || [self.reliatonModel.phone2 isEqualToString:@"<null>"] || self.reliatonModel.phone2 == nil) {
        
    }else{
        _contactInfoView.phoneNumber2.text = _reliatonModel.phone2;
        
    }
    if ([self.reliatonModel.phone3 isEqualToString:@"(null)"] || [self.reliatonModel.phone3 isEqualToString:@"<null>"] || self.reliatonModel.phone3 == nil) {
        
    }else{
        _contactInfoView.phoneNumber3.text = _reliatonModel.phone3;
        
    }
    
    //联系人关系
    NSArray * array = @[@"配偶",@"父母",@"子女",@"其他血亲",@"其他姻亲",@"同事",@"合伙人",@"其他关系",@"兄弟姐妹",@"同学",@"朋友"];
    int relation = [self.reliatonModel.relation1 intValue];
    if (relation > 0) {
        if (relation < 4) {
            _contactInfoView.relationship1.text = array[relation - 1];
            self.relationshipNum1 = self.reliatonModel.relation1;
        }
        else if (relation == 9) {
            _contactInfoView.relationship1.text = @"兄弟姐妹";
            self.relationshipNum1 = self.reliatonModel.relation1;
        }
        
    }
    
    relation = [self.reliatonModel.relation2 intValue];
    if (relation > 0) {
        _contactInfoView.relationship2.text = array[relation - 1];
        self.relationshipNum2 = self.reliatonModel.relation2;
    }
    
    
    relation = [self.reliatonModel.relation3 intValue];
    if (relation > 0) {
        _contactInfoView.relationship3.text = array[relation - 1];
        self.relationshipNum3 = self.reliatonModel.relation3;
    }
}


#pragma mark -- 打开系统通讯录
-(void)clickContactButton:(UIButton *)button{
    [self.view endEditing:YES];
    self.buttonTag = button.tag;
    
    
    if (self.addressBookArray.count > 0) {
        HDAddressBookController * addBookVC = [[HDAddressBookController alloc]init];
        
        addBookVC.dataArray = [WHAddressBookModel mj_objectArrayWithKeyValuesArray:self.addressBookArray];
        
        LDNavgationVController * nav = [[LDNavgationVController alloc]initWithRootViewController:addBookVC];
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
        addBookVC.addressBook = ^(WHAddressBookModel * addressBook){
            
            if (self.buttonTag == 1) {
                _contactInfoView.contactName1.text = addressBook.name;
                addressBook.mobile= [addressBook.mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
                _contactInfoView.phoneNumber1.text = addressBook.mobile;
            }else if (self.buttonTag == 2){
                _contactInfoView.contactName2.text = addressBook.name;
                addressBook.mobile= [addressBook.mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
                _contactInfoView.phoneNumber2.text = addressBook.mobile;
            }
            else{
                _contactInfoView.contactName3.text = addressBook.name;
                addressBook.mobile= [addressBook.mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
                _contactInfoView.phoneNumber3.text = addressBook.mobile;
            }
        };
        
    }else{
    
        [HDLoading showFailViewWithString:@"您的通讯录暂无联系人"];
    
    }
    
    
    
//    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
//    peoplePicker.peoplePickerDelegate = self;
//    [self presentViewController:peoplePicker animated:YES completion:nil];
    
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *phone = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonPhoneProperty));
    
    NSString *phoneNumber = (__bridge NSString *)ABMultiValueCopyValueAtIndex((__bridge ABMultiValueRef)(phone), index);
    phoneNumber= [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if ([firstName isEqualToString:@"(null)"] || [firstName isEqualToString:@"<null>"] || firstName == nil) {
        firstName = @"";
    }
    if ([lastName isEqualToString:@"(null)"] || [lastName isEqualToString:@"<null>"] || lastName == nil) {
        lastName = @"";
    }
    
    NSLog(@"firstName:%@",firstName);
    NSLog(@"lastName:%@",lastName);
    NSLog(@"phone:%@",phoneNumber);
    
    
    if (self.buttonTag == 1) {
        _contactInfoView.contactName1.text = [NSString stringWithFormat:@"%@%@",lastName,firstName];
        _contactInfoView.phoneNumber1.text = phoneNumber;
    }else if (self.buttonTag == 2){
        _contactInfoView.contactName2.text = [NSString stringWithFormat:@"%@%@",lastName,firstName];
        _contactInfoView.phoneNumber2.text = phoneNumber;
    }
    else{
        _contactInfoView.contactName3.text = [NSString stringWithFormat:@"%@%@",lastName,firstName];
        _contactInfoView.phoneNumber3.text = phoneNumber;
    }
}
@end
