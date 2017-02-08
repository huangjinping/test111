

#import <Foundation/Foundation.h>

@interface HDOrderRepays : NSObject

/** 本月代还款金额  */
@property (nonatomic, strong) NSString * perioddebt;

/** 账单列表 */
@property (nonatomic, strong) NSArray * list;

@end
