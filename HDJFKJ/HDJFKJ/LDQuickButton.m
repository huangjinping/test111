//
//  LDQuickButton.m
//  HDJFKJ
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDQuickButton.h"

@implementation LDQuickButton
+ (instancetype)LDQuickButtonWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return (LDQuickButton *)button;
}
@end
