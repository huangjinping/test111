

#import "HDMineMoreController.h"
#import "LDSafetyCenter.h"
#import "WHUserLoginModel.h"
#import "LDSignInViewController.h"
#import "LDNavgationVController.h"
@interface HDMineMoreController ()

@property (weak, nonatomic) IBOutlet UIButton *anquanButton;

@property (weak, nonatomic) IBOutlet UILabel *banbenLabel;

@property (weak, nonatomic) IBOutlet UILabel *weixinLabel;
@property (weak, nonatomic) IBOutlet UIButton *tuichuButton;

@end

@implementation HDMineMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
        
    // 获得当前软件的版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    self.banbenLabel.text = currentVersion;
    
    
}



- (IBAction)clickTuChuButton:(id)sender {
    
    //统计买点
    [WHTongJIRequest sendTongjiRequestWithBusinessId:nil oprType:TCDL];
    
    //删除本地保存的用户信息
    [WHUserLoginModel deleteUserLogin];
    [[LDUserInformation sharedInstance] setUserId:nil];
    [[LDUserInformation sharedInstance] setToken:nil];
    
    //推出登录界面
    LDSignInViewController * signinVC = [[LDSignInViewController alloc]init];
    signinVC.fromWhere = @"tuichu";
    LDNavgationVController * nav = [[LDNavgationVController alloc] initWithRootViewController:signinVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

- (IBAction)clickAnQuanButton:(id)sender {
    
    LDSafetyCenter * safety = [[LDSafetyCenter alloc] init];
    
    [self.navigationController pushViewController:safety animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
