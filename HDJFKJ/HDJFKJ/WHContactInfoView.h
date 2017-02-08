

#import <UIKit/UIKit.h>

@interface WHContactInfoView : UIView
+ (id)view;

@property (weak, nonatomic) IBOutlet UITextField *contactName1;
@property (weak, nonatomic) IBOutlet UITextField *contactName2;
@property (weak, nonatomic) IBOutlet UITextField *contactName3;

@property (weak, nonatomic) IBOutlet UITextField *relationship1;
@property (weak, nonatomic) IBOutlet UITextField *relationship2;
@property (weak, nonatomic) IBOutlet UITextField *relationship3;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber1;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber2;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber3;

@property (weak, nonatomic) IBOutlet UIButton *contactButton1;
@property (weak, nonatomic) IBOutlet UIButton *contactButton2;
@property (weak, nonatomic) IBOutlet UIButton *contactButton3;

@property (weak, nonatomic) IBOutlet UIButton *relationButton1;
@property (weak, nonatomic) IBOutlet UIButton *relationButton2;
@property (weak, nonatomic) IBOutlet UIButton *relationButton3;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@end
