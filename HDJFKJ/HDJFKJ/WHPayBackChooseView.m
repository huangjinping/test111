

#import "WHPayBackChooseView.h"

@implementation WHPayBackChooseView

+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHPayBackChooseView" owner:nil options:nil] lastObject];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

@end
