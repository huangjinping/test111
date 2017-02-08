//
//  LDSection3.m
//  HDJFKJ
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDSection3.h"

@interface LDSection3 ()

@property (weak, nonatomic) IBOutlet UILabel *goodsRegular;



@end


@implementation LDSection3
- (void)setGoodsDetailModel:(LDGoodsDetailModel *)goodsDetailModel{
    
    _goodsDetailModel = goodsDetailModel;
    self.goodsRegular.text = goodsDetailModel.parameter;
    
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
