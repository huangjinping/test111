//
//  LDTypeWorkModel.h
//  HDJFKJ
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDTypeWorkModel : NSObject

@property(nonatomic,copy) NSString * lableText;
@property(nonatomic,copy) NSString * imageName;
+ (instancetype)modelWithDict:(NSDictionary *)Dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
