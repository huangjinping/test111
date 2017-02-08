//
//  LDMonthPayCell.m
//  HDJFKJ
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDMonthPayCell.h"

@implementation LDMonthPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.monthPay.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
