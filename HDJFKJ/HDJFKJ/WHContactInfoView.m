

#import "WHContactInfoView.h"

@implementation WHContactInfoView


+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHContactInfoView" owner:nil options:nil] lastObject];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}
@end
