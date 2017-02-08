//
//  LDHaveCardListModel.h
//  HDJFKJ
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDHaveCardListModel : NSObject

/**
 *  银行名称
 */
@property (nonatomic,strong) NSString * bank;
/**
 *  银行卡号
 */
@property (nonatomic,strong) NSString * cardtailno;
/**
 *  id
 */
@property (nonatomic,strong) NSString * id;
/**
 *  name
 */
@property (nonatomic,strong) NSString * name;
//卡类型
@property (nonatomic, strong) NSString * type;

@end
