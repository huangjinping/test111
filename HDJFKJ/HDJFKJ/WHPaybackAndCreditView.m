//
//  WHPaybackAndCreditView.m
//  HDJFKJ
//
//  Created by 石伟浩 on 16/6/15.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "WHPaybackAndCreditView.h"

@implementation WHPaybackAndCreditView

+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHPaybackAndCreditView" owner:nil options:nil] lastObject];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}
@end
