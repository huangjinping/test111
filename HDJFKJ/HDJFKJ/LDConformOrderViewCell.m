//
//  LDConformOrderViewCell.m
//  HDJFKJ
//  Created by apple on 16/3/28.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDConformOrderViewCell.h"

@interface LDConformOrderViewCell ()
@property (nonatomic,strong) UIButton * button;

@end

@implementation LDConformOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton*)sender {
    
    
    
    sender.selected = YES;
    
//    self.button = sender;
//    self.button.selected = NO;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    self = [[[NSBundle mainBundle]loadNibNamed:@"LDConformOrderViewCell" owner:nil options:nil]lastObject];
    
    return self;
}

@end
