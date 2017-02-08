

#import <UIKit/UIKit.h>

@interface HDLoading : UIView


+ (void)showWithImageWithString:(NSString *)string;
+ (void)showFailViewWithString:(NSString *)string;
+ (void)showSuccessViewWithString:(NSString *)string;
+ (void)dismissHDLoading;
@end
