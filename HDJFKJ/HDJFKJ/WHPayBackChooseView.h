

#import <UIKit/UIKit.h>

@interface WHPayBackChooseView : UIView

//代还款按钮
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


+ (id)view;

@end
