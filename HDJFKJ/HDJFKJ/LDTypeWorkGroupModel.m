//
//  LDTypeWorkGroupModel.m
//  HDJFKJ
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import "LDTypeWorkGroupModel.h"

@implementation LDTypeWorkGroupModel
- (NSMutableArray *)baseModelArray{
    if (!_workModelArray) {
        
        _workModelArray = [[NSMutableArray alloc] init];
    }
    return  _workModelArray;
 
}
@end
