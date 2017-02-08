

#import <UIKit/UIKit.h>

typedef void(^ComplationBlock)(UIImage * signImage);

@interface WHSignController : LDBaseUIViewController
@property (nonatomic, copy) ComplationBlock complationBlock;
@end
