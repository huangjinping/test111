

#import "WHZhiFuTanChuangView.h"

@implementation WHZhiFuTanChuangView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (id)view {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WHZhiFuTanChuangView" owner:nil options:nil] lastObject];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}
@end
