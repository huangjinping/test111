//
//  LDBankCardViewCell.m
//  HDJFKJ
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDBankCardViewCell.h"

@implementation LDBankCardViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    //self = [super initWithFrame:frame];
    
    self = [[[NSBundle mainBundle]loadNibNamed:@"LDBankCardViewCell" owner:nil options:nil]lastObject];
    
    
    return self;
}

@end
