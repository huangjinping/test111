

#import <Foundation/Foundation.h>

@interface WHCheckModel : NSObject
//下单时间
@property (nonatomic, strong) NSString * time;
//已还总金额
@property (nonatomic, strong) NSString * paid;
//贷款总额
@property (nonatomic, strong) NSString * applyamount;
//待还总额
@property (nonatomic, strong) NSString * debt;
//订单号
@property (nonatomic, strong) NSString * orderno;
//账单列表
@property (nonatomic, strong) NSArray * list;
//商品图片url
@property (nonatomic, strong) NSString * pic;
//商品名称
@property (nonatomic, strong) NSString * commodityname;
//商品列表
@property (nonatomic, strong) NSArray * commoditys;





















@end