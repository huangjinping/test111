//
//  WHNavMiddleVIew.m
//  HDJFKJ
//
//  Created by 石伟浩 on 16/3/25.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "WHNavMiddleVIew.h"

@implementation WHNavMiddleVIew

+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHNavMiddleVIew" owner:nil options:nil] lastObject];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

@end
