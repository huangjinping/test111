

#import <UIKit/UIKit.h>

@interface WHCheckListCell : UITableViewCell
//当前期数
@property (weak, nonatomic) IBOutlet UILabel *currentperiodLabel;
//本期还款金额
@property (weak, nonatomic) IBOutlet UILabel *perioddebtLabel;
//还清日期
@property (weak, nonatomic) IBOutlet UILabel *time;



@end
