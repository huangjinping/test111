

#import "WHCheckTopView.h"

@implementation WHCheckTopView

+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHCheckTopView" owner:nil options:nil] lastObject];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

@end
