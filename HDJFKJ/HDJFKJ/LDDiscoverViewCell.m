//
//  LDDiscoverViewCell.m
//  HDJFKJ
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDDiscoverViewCell.h"

@implementation LDDiscoverViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setModel:(LDResponseModel *)model{
    _model = model;
   
}
- (void)setFrame:(CGRect)frame
{

//    frame.size.height -= 10;
//    frame.origin.y += 10;
    self.backgroundColor = LDBackroundColor;
    [super setFrame:frame];
}

@end
