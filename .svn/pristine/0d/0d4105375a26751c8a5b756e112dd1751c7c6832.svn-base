//
//  LDGoodsDetailCell.m
//  HDJFKJ
//
//  Created by apple on 16/4/10.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDGoodsDetailCell.h"
#import "SDCycleScrollView.h"


@interface LDGoodsDetailCell ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@end


@implementation LDGoodsDetailCell
- (void)setGoodsDetailModel:(LDGoodsDetailModel *)goodsDetailModel{
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    if (_goodsDetailModel != goodsDetailModel) {
        
    _goodsDetailModel = goodsDetailModel;
    
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:[UIImage imageNamed:@"商品 1:1"]];
     
    cycleScrollView3.bannerImageViewContentMode  = UIViewContentModeScaleAspectFit;

    cycleScrollView3.autoScroll = NO;
        
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"椭圆-11"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"椭圆-11-拷贝"];
    cycleScrollView3.imageURLStringsGroup = self.goodsDetailModel.piclist;
    
    cycleScrollView3.backgroundColor = [UIColor clearColor];
      
    [self.headerImage addSubview:cycleScrollView3];
        
    }
    
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.headerImage.userInteractionEnabled = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame{


}
@end
