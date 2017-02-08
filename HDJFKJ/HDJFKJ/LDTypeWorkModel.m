//
//  LDTypeWorkModel.m
//  HDJFKJ
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDTypeWorkModel.h"

@implementation LDTypeWorkModel
+ (instancetype)modelWithDict:(NSDictionary *)Dict{
    return [[self alloc]initWithDict:Dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}
@end
