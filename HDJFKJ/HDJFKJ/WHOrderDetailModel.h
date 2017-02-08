

#import <Foundation/Foundation.h>

@interface WHOrderDetailModel : NSObject

//商户id
@property (nonatomic, strong) NSString * businessid;

//商户名称
@property (nonatomic, strong) NSString * businessname;

//商户图片url
@property (nonatomic, strong) NSString * pic;

//商品名称
@property (nonatomic, strong) NSString * commodityname;

//订单号
@property (nonatomic, strong) NSString * orderno;

//下单时间
@property (nonatomic, strong) NSString * time;

//商品价格
@property (nonatomic, strong) NSString * totalamount;

//期供金额
@property (nonatomic, strong) NSString * periondamount;

//总期数
@property (nonatomic, strong) NSString * duration;

//首付金额
@property (nonatomic, strong) NSString * downpayment;

//订单状态
@property (nonatomic, strong) NSString * status;

//审核反馈信息
@property (nonatomic, strong) NSString * feedback;

//银行名称
@property (nonatomic, strong) NSString * bankname;

//银行卡位数
@property (nonatomic, strong) NSString * bankcardtailno;























@end
