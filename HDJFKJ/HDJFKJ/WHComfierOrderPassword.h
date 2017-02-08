

#import <UIKit/UIKit.h>
#import "LDOrderDetailModel.h"
@interface WHComfierOrderPassword : LDBaseUIViewController
//确认支付按钮
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) LDOrderDetailModel * orderDetailModel;

@property (weak, nonatomic) IBOutlet UILabel *p1;

@property (weak, nonatomic) IBOutlet UILabel *p2;

@property (weak, nonatomic) IBOutlet UILabel *p3;

@property (weak, nonatomic) IBOutlet UILabel *p4;

@property (weak, nonatomic) IBOutlet UILabel *p5;

@property (weak, nonatomic) IBOutlet UILabel *p6;


@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *passwordButton;
@end
