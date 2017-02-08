//
//  LDBaseTableViewController.m
//  HDJFKJ
//
//  Created by apple on 16/3/19.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDBaseTableViewController.h"
#import "BaiduMobStat.h"
#import "WHPopAnimation.h"
@interface LDBaseTableViewController ()<UIGestureRecognizerDelegate>


/** DataArray */
@property (nonatomic,strong) NSArray * dataArray;


@end

@implementation LDBaseTableViewController


- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@",  self.class, nil];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@",  self.class, nil];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    //自定义NavgationController,和返回返回按钮后，侧滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    
   
}



@end
