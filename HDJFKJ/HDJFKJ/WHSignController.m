

#import "WHSignController.h"
#import "SKGraphicView.h"
@interface WHSignController ()

@property (nonatomic, strong) SKGraphicView * signView;

@end

@implementation WHSignController

- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signView = [[SKGraphicView alloc] initWithFrame:CGRectMake(12, 80, LDScreenWidth - 25, LDScreenHeight - 159)];
    self.signView.backgroundColor = [UIColor whiteColor];
    self.signView.color = [UIColor blackColor];
    self.signView.lineWidth = 5;
    self.signView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.signView];

}

//返回上一界面
- (IBAction)clickCancelButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//重写按钮
- (IBAction)clickAginWrite:(UIButton *)sender {
    [self.signView clearBtnEvent];
}

//确定按钮
- (IBAction)clickSureButton:(UIButton *)sender {
    
    UIImage * image = [self.signView getDrawingImg];
    if (image) {
        _complationBlock(image);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
@end
