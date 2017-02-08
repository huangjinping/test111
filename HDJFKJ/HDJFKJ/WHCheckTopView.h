

#import <UIKit/UIKit.h>

@interface WHCheckTopView : UIView

//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
//商品名称
@property (weak, nonatomic) IBOutlet UILabel *commoditynameLabel;
//订单号
@property (weak, nonatomic) IBOutlet UILabel *ordernoLabel;
//下单时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//账单总金额
@property (weak, nonatomic) IBOutlet UILabel *applyamountLabel;
//底部试图
@property (weak, nonatomic) IBOutlet UIView *bottomView;

+ (id)view;
@end
