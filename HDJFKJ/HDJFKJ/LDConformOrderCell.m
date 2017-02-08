//
//  LDConformOrderCell.m
//  HDJFKJ
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDConformOrderCell.h"

@interface LDConformOrderCell ()
@property (weak, nonatomic) IBOutlet UILabel *bussNessName;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@property (weak, nonatomic) IBOutlet UILabel *categort;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *firstPay;

@end


@implementation LDConformOrderCell
-(void)setGoodsDetailModel:(LDGoodsDetailModel *)goodsDetailModel{

    _bussNessName.text = goodsDetailModel.businessname;
    _goodsName.text = goodsDetailModel.name;
    _categort.text = [NSString stringWithFormat:@"分类:%@",goodsDetailModel.category];
    _categort.hidden = YES;
    _price.text = [NSString stringWithFormat:@"总价:%@",goodsDetailModel.commodityprice];
    [_leftImage sd_setImageWithURL:[NSURL URLWithString:goodsDetailModel.pic] placeholderImage:[UIImage imageNamed:@"商品 1:1"]];
    _firstPay.text = goodsDetailModel.downpayment;
    

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
