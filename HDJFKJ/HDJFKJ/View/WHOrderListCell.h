

#import <UIKit/UIKit.h>

@interface WHOrderListCell : UITableViewCell
//商户名称
@property (weak, nonatomic) IBOutlet UILabel *businessnameLabel;
//上平名称
@property (weak, nonatomic) IBOutlet UILabel *commoditynameLabel;

//分类
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
//分期描述
@property (weak, nonatomic) IBOutlet UILabel *fenqiDetailLabel;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
//贷款总金额
@property (weak, nonatomic) IBOutlet UILabel *apply_amountLabel;

















@end
