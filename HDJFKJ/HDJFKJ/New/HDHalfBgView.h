
#import <UIKit/UIKit.h>
typedef void(^AddBankCardBlock)();
typedef void(^PasswordSuccessBlock)(NSString * bankID);

@interface HDHalfBgView : UIView
@property (nonatomic, strong) AddBankCardBlock addbankCard;

@property (nonatomic, strong) PasswordSuccessBlock successBlock;

//分期数组
@property (nonatomic, strong) NSArray * stagesArray;

//银行卡数组
@property (nonatomic, strong) NSArray * bankCardArray;

//当前银行卡id
@property (nonatomic, strong) NSString * bankCardID;

//创建视图
+ (HDHalfBgView *)createHDHalfBgViewWithView:(UIView *)view;

//加载确认分期试图
- (void)addComfimComiteView;

- (void)reloadAddBankTableViewWith:(NSArray *)bankCardArr;

@end