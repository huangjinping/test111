//
//  LDTestCell.h
//  HDJFKJ
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsDetailModel.h"
#import "SDCycleScrollView.h"

@interface LDTestCell : UITableViewCell
@property (nonatomic,strong) LDGoodsDetailModel * goodsDetailModel;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
