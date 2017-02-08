//
//  LDTestCell.m
//  HDJFKJ
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDTestCell.h"

@implementation LDTestCell
- (void)setGoodsDetailModel:(LDGoodsDetailModel *)goodsDetailModel{
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_goodsDetailModel != goodsDetailModel) {
        
        _goodsDetailModel = goodsDetailModel;
        self.headerView.bannerImageViewContentMode  = UIViewContentModeScaleAspectFit;
        
        self.headerView.autoScroll = NO;
        
       self.headerView.currentPageDotImage = [UIImage imageNamed:@"椭圆-11"];
        self.headerView.pageDotImage = [UIImage imageNamed:@"椭圆-11-拷贝"];
        self.headerView.imageURLStringsGroup = self.goodsDetailModel.piclist;
        
       self.headerView.backgroundColor = [UIColor clearColor];
        
    }
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
