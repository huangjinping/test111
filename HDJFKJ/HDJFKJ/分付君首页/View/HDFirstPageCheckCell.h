

#import <UIKit/UIKit.h>
#import "HDFirstPageDebtInfo.h"
@interface HDFirstPageCheckCell : UITableViewCell

@property (nonatomic, strong) HDFirstPageDebtInfo * debtInfo;
@property (weak, nonatomic) IBOutlet UILabel *repaymentAmtLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end
