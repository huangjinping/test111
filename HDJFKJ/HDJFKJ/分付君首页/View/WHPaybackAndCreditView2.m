

#import "WHPaybackAndCreditView2.h"

@implementation WHPaybackAndCreditView2


+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHPaybackAndCreditView2" owner:nil options:nil] lastObject];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
//        [self.creditLabel sizeToFit];
//        
//        [self.goLoginLabel sizeToFit];
//        
//        [self.titleLable sizeToFit];
        
    }
    return self;
}





























@end
