//
//  LDNewOrderDetailCell.m
//  HDJFKJ
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDNewOrderDetailCell.h"
#import "LDNewOrderDetailModel.h"

@interface LDNewOrderDetailCell ()
/**
 *  首付金额
 */
@property (weak, nonatomic) IBOutlet UILabel *firstPay;
/**
 *  分期金额
 */
@property (weak, nonatomic) IBOutlet UILabel *stagePay;
/**
 *  分期数
 */
@property (weak, nonatomic) IBOutlet UILabel *duration;
/**
 *  月还款金额
 */
@property (weak, nonatomic) IBOutlet UILabel *monthPay;

@end


@implementation LDNewOrderDetailCell
- (void)setOrderDetailModel:(LDNewOrderDetailModel *)orderDetailModel{

    _orderDetailModel = orderDetailModel;
    
    NSString * str1 = [NSString stringWithFormat:@"月还款额: ￥%.2f",[orderDetailModel.periodAmount floatValue]];
    NSRange rang1 = [str1  rangeOfString:@"月还款额: "];
    
    NSRange rang2 = [str1 rangeOfString:[NSString stringWithFormat:@"￥%.2f",[orderDetailModel.periodAmount floatValue]]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
    [str addAttribute:NSForegroundColorAttributeName value:WHColorFromRGB(0x6f7179) range:rang1];
    [str addAttribute:NSForegroundColorAttributeName value:WHColorFromRGB(0x4279d6) range:rang2];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rang1];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:rang2];
    
    self.monthPay.attributedText = str;
    
    
    self.firstPay.text = [NSString stringWithFormat:@"￥%.2f",[orderDetailModel.downpayment floatValue]];
    
    self.stagePay.text = [NSString stringWithFormat:@"￥%.2f",[orderDetailModel.applyAmount floatValue]];
    
    self.duration.text = [NSString stringWithFormat:@"期数: %@期",orderDetailModel.duration];
    

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
