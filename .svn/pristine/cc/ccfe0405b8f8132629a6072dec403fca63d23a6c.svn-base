//
//  AppDelegate.m
//  北京互动金服科技
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "AppDelegate.h"
#import "LDPostIDCard.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "LDTabBarController.h"
#import "LDNavgationVController.h"
#import "LDBaseInformationTableViewController.h"
#import "LDContactInformationViewController.h"
#import "LDDiscoverViewController.h"
#import "LDBankCardViewController.h"
#import "LDSubmitVCController.h"
#import "LDtest2222ViewController.h"
#import "LDPaymentPasswordController.h"
#import "LDNavgationVController.h"
#import "LDBusnessController.h"
#import "LDConformOrderViewController.h"
#import "LDRestPassWordController.h"
#import "LDGuideView.h"
#import "LDSignInViewController.h"
#import "LDFirstViewController.h"
#import "LDDetailMessage.h"
#import "AuthorizViewController.h"
#import "BaiduMobStat.h"
#import "WHWorkViewController.h"
#import "LDNewOrderDetailVC.h"
#import "HDFexOrderDetail.h"

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (nonatomic,assign) int isLogin;

@property (nonatomic, strong) CLLocationManager * locationManager;

@end


@implementation AppDelegate
- (void)pushGuide{
    
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        
        self.window.rootViewController = [[LDGuideView alloc] init];
        
    }else{
        
        LDTabBarController * tab = [[LDTabBarController alloc] init];
        

        self.window.rootViewController = tab;
        
            }

}
// 启动百度移动统计
- (void)startBaiduMobileStat{
    /*若应用是基于iOS 9系统开发，需要在程序的info.plist文件中添加一项参数配置，确保日志正常发送，配置如下：
     NSAppTransportSecurity(NSDictionary):
     NSAllowsArbitraryLoads(Boolen):YES
     详情参考本Demo的BaiduMobStatSample-Info.plist文件中的配置
     */
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = YES;
    
    [statTracker startWithAppId:@"81d99919ab"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}

//校准位置
- (void)newLocation{
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    //判断是否启动了定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位服务没打开，请启动定位服务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            //向用户请求授权
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    
    //设置定位的精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    //开始定位用户的位置
    [_locationManager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations firstObject];
    [_locationManager stopUpdatingLocation];

    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    
    [revGeo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && [placemarks count] > 0){
            NSDictionary *dict =[[placemarks objectAtIndex:0] addressDictionary];
            //记录地址
            NSLog(@"%@",dict);
            
            NSString * city = [dict objectForKey:@"City"];
            NSString * name = [dict objectForKey:@"Name"];
            [[LDUserInformation sharedInstance] setLocationName:name];
            [[LDUserInformation sharedInstance] setLocationCity:city];
            //归档存储用户信息
            [NSKeyedArchiver archiveRootObject:city toFile:LoacationArea];
        
        }
        else{
            NSLog(@"ERROR: %@", error);
        }
    }];
}

- (void)changeRootViewController{
    
    self.window.rootViewController = [[LDTabBarController alloc] init];
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [self startBaiduMobileStat];
    //延长启动图时间
    //[NSThread sleepForTimeInterval:1.0];
    
    //数据赋值
    [self shareInstance];
    //启动定位服务
    [self newLocation];
    
    
    //设置SDWebImageView的缓存
    SDImageCache * cache = [SDImageCache sharedImageCache];
    cache.maxCacheSize = 1024 * 5;
    cache.maxMemoryCountLimit = 10;
    

    
    [[UIApplication sharedApplication] setStatusBarStyle:
     UIStatusBarStyleLightContent animated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootViewController) name:@"registerSucess" object:nil];
    
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置窗口的根控制器
    
    [self pushGuide];

    self.window.backgroundColor = LDBackroundColor;
    //显示窗口控制器
    [self.window makeKeyAndVisible];
    //18503316901..13611290917  wo123456


    //self.window.rootViewController =[[HDFexOrderDetail alloc] init];
    
    if ([KBaseUrl isEqualToString: @"http://123.56.233.192/hd-merchant-web/mobile/"]) {
        [self sendRequest];
    }
    
    


    return YES;

}


/**
 *  数据存储,单例赋值
 */
- (void)shareInstance{
    
    //保存ID和token

    [[LDUserInformation sharedInstance] setPassWord:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
    [[LDUserInformation sharedInstance] setPhoneNumber:[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"]];
  
    //归档存储打回修改的订单ID,制空
    [NSKeyedArchiver archiveRootObject:@"" toFile:BackOrderID];
    [NSKeyedArchiver archiveRootObject:@"" toFile:LoanType];
}



- (void)sendRequest{
    
    NSString * str = nil;
    
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([identifier isEqualToString:@"cn.hdfex.hufenqi"]) {
        str = [NSString stringWithFormat:@"http://www.hdfex.cn/hd-merchant-web/mobile/release?appName=fenfujun"];
    }
    else{
        str = [NSString stringWithFormat:@"http://www.hdfex.cn/hd-merchant-web/mobile/release?appName=daiyu"];
    }

    [[LDNetworkTools sharedTools] request:POST url:str params:nil callback:^(id response, NSError *error) {
        if (error != nil) {
            
           
        }else{
            
            NSLog(@"%@",response);
            
            LDBackInformation * backInfo = [LDBackInformation mj_objectWithKeyValues:response];
            
            
            //code == 200请求成功
            if ([backInfo.code isEqualToString:@"0"]) {
                NSDictionary * dict = [response objectForKey:@"result"];
                NSString * version = [dict objectForKey:@"iosversion"];
                
                NSString *key = @"CFBundleShortVersionString";
                NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
                
                if (version == nil || [version isEqualToString:@""]) {
                    
                }
                else {
                    if (![version isEqualToString:currentVersion]) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"升级提示" message:@"检测到新版本，是否立即更新？" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles: nil];
                        alert.tag = 13;
                        [alert show];
                    }
                }
                
            }else{
                
            }
        }
    }];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 13) {
        NSString * str = nil;
        NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
        if ([identifier isEqualToString:@"cn.hdfex.hufenqi"]) {
            str = @"itms-apps://itunes.apple.com/cn/app/fen-fu-jun/id1108375587?mt=8";
        }
        else{
            str = @"itms-apps://itunes.apple.com/cn/app/dai-yu/id1111504267?mt=8";
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
//监听app前台后天转换
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //
    [WHTongJIRequest sendTongjiRequestWithBusinessId:nil oprType:GBAPP];
    NSLog(@"进入后台");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 回到前台
    
}
@end
