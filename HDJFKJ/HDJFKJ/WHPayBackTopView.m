

#import "WHPayBackTopView.h"

@implementation WHPayBackTopView

+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHPayBackTopView" owner:nil options:nil] lastObject];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

@end
