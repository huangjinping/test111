//
//  LDSection2.m
//  HDJFKJ
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDSection2.h"

@interface LDSection2 ()

@property (weak, nonatomic) IBOutlet UILabel *goodsPlace;


@end



@implementation LDSection2
- (void)setGoodsDetailModel:(LDGoodsDetailModel *)goodsDetailModel{
    _goodsDetailModel = goodsDetailModel;
    self.GoodsName.text = goodsDetailModel.businessname;
    
    self.goodsPlace.text = goodsDetailModel.address;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // 字符串模型数据
    //        NSString *topic1 = self.goodsDetailModel.address;
    //        NSString *topic2 = self.goodsDetailModel.businessname;
    //
    //        // 文字的最大尺寸
    //        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2* LDPadding - 43, MAXFLOAT);
    //
    //        CGFloat textH1 = [topic1 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    //        CGFloat textH2 = [topic2 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    // cell的高度
    //        CGFloat cellH = (18 + textH1) +(29 + textH2)+ LDPadding;
}

@end
