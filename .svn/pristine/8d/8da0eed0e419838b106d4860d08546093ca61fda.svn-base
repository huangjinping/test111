//
//  LDOrderDetailGoodsCell.m
//  HDJFKJ
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDOrderDetailGoodsCell.h"
#import "LDOrderDetailModel.h"
#import "LDNewOrderDetailModel.h"


@interface LDOrderDetailGoodsCell ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

/**
 *  规格
 */
@property (weak, nonatomic) IBOutlet UILabel *rule;

@end


@implementation LDOrderDetailGoodsCell
- (void)setSmallDetailModel:(LDSmallNewOrderDetailModel *)smallDetailModel{

    _smallDetailModel = smallDetailModel;
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:smallDetailModel.pic] placeholderImage:[UIImage imageNamed:@"商品 1:1"]];
    
    self.goodsName.text = [NSString stringWithFormat:@"%@",smallDetailModel.commodityName];
    
    NSString * str1 = [NSString stringWithFormat:@" ￥%.2f",[smallDetailModel.commodityPrice floatValue]];
    
    NSRange rang1 = [str1  rangeOfString:@" "];
    
    NSRange rang2 = [str1 rangeOfString:[NSString stringWithFormat:@"￥%.2f",[smallDetailModel.commodityPrice floatValue]]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang1];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rang2];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rang1];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:rang2];
    
    self.goodsPrice.text = [NSString stringWithFormat:@" ￥%.2f",[smallDetailModel.commodityPrice floatValue]];
    
    self.rule.text = [NSString stringWithFormat:@"共有%@个",smallDetailModel.commodityCount];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
