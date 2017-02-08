

#import <Foundation/Foundation.h>

@interface WHPayBackModel : NSObject

//贷款申请id
@property (nonatomic, strong) NSString * id;
//下单时间
@property (nonatomic, strong) NSString * time;
//当前期数
@property (nonatomic, strong) NSString * currentperiod;
//订单号
@property (nonatomic, strong) NSString * orderno;
//剩余天数
@property (nonatomic, strong) NSString * remainday;
//商品图片url
@property (nonatomic, strong) NSString * pic;

@property (nonatomic, strong) NSString * commodityno;
//商品名称
@property (nonatomic, strong) NSString * commodityName;
//总期数
@property (nonatomic, strong) NSString * duration;
//该账单本月还款金额
@property (nonatomic, strong) NSString * perioddebt;
//商品列表
@property (nonatomic, strong) NSArray * commoditys;
//商品价格
@property (nonatomic, strong) NSString * commodityPrice;
//商品数量
@property (nonatomic, strong) NSString * count;
@property (nonatomic, strong) NSString * commodityCount;














@end
