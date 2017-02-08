

#import "WHPayBackModel.h"
#import "HDPayBackCommodity.h"
@implementation WHPayBackModel

- (void)setCommoditys:(NSArray *)commoditys{

    _commoditys = [HDPayBackCommodity mj_objectArrayWithKeyValuesArray:commoditys];
}


























@end
