//
//  BJScanViewController.m
//  
//
//  Created by 蔡佰津 on 2019/1/2.
//

#import "BJScanViewController.h"
#import <LBXAlertAction/LBXAlertAction.h>

@interface BJScanViewController ()

@property (nonatomic, strong) UIButton *btnBack;

@end

@implementation BJScanViewController

- (void)viewDidLoad {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [super viewDidLoad];
    self.cameraInvokeMsg = @"相机启动中";
    [self setUpNavi];
    // Do any additional setup after loading the view.
}

- (void)setUpNavi {
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(bBack:)];
    self.edgesForExtendedLayout = UIRectEdgeTop;
}

- (void)bBack:(UIButton *)btn {
    NSLog(@"back");
    [self dismiss];
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array {
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
        
        [weakSelf reStartDevice];
    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult {
    NSLog(@"二维码为：%@",strResult.strScanned);
    
    [self dismiss];
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
