//
//  LDGoodsSection1.m
//  HDJFKJ
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDGoodsSection1.h"

@interface LDGoodsSection1 ()

@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *buyCount;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;

@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *firstPay;
@property (weak, nonatomic) IBOutlet UILabel *monthPay;

@property (weak, nonatomic) IBOutlet UILabel *duration;

@property (weak, nonatomic) IBOutlet UILabel *SumPrice;


@end


@implementation LDGoodsSection1
- (void)setGoodsDetailModel:(LDGoodsDetailModel *)goodsDetailModel{
    
    self.backgroundColor  =[UIColor whiteColor];
    _goodsDetailModel = goodsDetailModel;
    self.goodsName.text = goodsDetailModel.name;
    self.buyCount.text = [NSString stringWithFormat:@"%@人已购买",goodsDetailModel.sale];
    
    self.SumPrice.text = [NSString stringWithFormat:@"%@",goodsDetailModel.commodityprice];
    //   %@首付 + ￥%@ x %@期,,
    
    //首付金额
    NSString * payment = @"";
    if ([self.goodsDetailModel.downpayment isEqualToString:@"<null>"] || [self.goodsDetailModel.downpayment isEqualToString:@"(null)"] || [self.goodsDetailModel.downpayment isEqualToString:@""] || self.goodsDetailModel.downpayment == nil || [self.goodsDetailModel.downpayment floatValue] == 0) {
        payment = @"0首付";
    }else{
        payment = [NSString stringWithFormat:@"首付%.2f",[self.goodsDetailModel.downpayment floatValue]];
    }
    
    self.firstPay.text = [NSString stringWithFormat:@"%@",payment];
    
    //self.firstPay.text = [NSString stringWithFormat:@"%@首付",NIL0STR(goodsDetailModel.privilege)];
    
    self.monthPay.text = [NSString stringWithFormat:@"%.2f",[goodsDetailModel.periodamount floatValue]];
    
    self.duration.text = [NSString stringWithFormat:@"%@",goodsDetailModel.duration];
    
   
    
    
    if ([goodsDetailModel.star floatValue] == 3.0) {//评分3
        self.star1.hidden = NO;
        self.star2.hidden = NO;
        self.star3.hidden = NO;
        self.star4.hidden = YES;
        self.star5.hidden = YES;
    }
    if ([goodsDetailModel.star floatValue] > 3.0 && [goodsDetailModel.star floatValue] < 4.0 ){//评分3.5
        self.star1.hidden = NO;
        self.star2.hidden = NO;
        self.star3.hidden = NO;
        
        self.star4.hidden = NO;
        self.star5.hidden = YES;
    }
    if ([goodsDetailModel.star floatValue] == 4.0) {//评分4.0
        self.star1.hidden = NO;
        self.star2.hidden = NO;
        self.star3.hidden = NO;
        
        self.star4.hidden = NO;
        self.star5.hidden = YES;
    }
    if ([goodsDetailModel.star floatValue] > 4.0 && [goodsDetailModel.star floatValue] < 5.0){//评分4.5
        self.star1.hidden = NO;
        self.star2.hidden = NO;
        self.star3.hidden = NO;
        
        self.star4.hidden = NO;
        self.star5.hidden = NO;
    }
    if ([goodsDetailModel.star floatValue] == 5.0){//评分5
        self.star1.hidden = NO;
        self.star2.hidden = NO;
        self.star3.hidden = NO;
        
        self.star4.hidden = NO;
        self.star5.hidden = NO;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
