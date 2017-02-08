//
//  LDSection4.m
//  HDJFKJ
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDSection4.h"


@interface LDSection4 ()

@property (weak, nonatomic) IBOutlet UILabel *goodsIntrolDuce;


@end


@implementation LDSection4
- (void)setGoodsDetailModel:(LDGoodsDetailModel *)goodsDetailModel{

    _goodsDetailModel = goodsDetailModel;
    self.goodsIntrolDuce.text = goodsDetailModel.desc;

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
