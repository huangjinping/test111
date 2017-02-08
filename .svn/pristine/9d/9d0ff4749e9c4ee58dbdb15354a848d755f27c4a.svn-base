//
//  LDUserInformation.m
//  HDJFKJ
//
//  Created by apple on 16/3/20.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDUserInformation.h"

@implementation LDUserInformation

+(instancetype)sharedInstance{
    
    static LDUserInformation *instance;
    
    static dispatch_once_t oneceToken;
    
    dispatch_once(&oneceToken, ^{
        
        instance = [[LDUserInformation alloc] init];
        
    });
    
    return instance;
}

@end
@implementation LDBackInformation

@end