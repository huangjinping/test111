//
//  LDSection2.h
//  HDJFKJ
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsDetailModel.h"
@interface LDSection2 : UITableViewCell
@property (nonatomic,strong) LDGoodsDetailModel * goodsDetailModel;
@property (weak, nonatomic) IBOutlet UIButton *popButton;
@property (weak, nonatomic) IBOutlet UILabel *GoodsName;

@end
