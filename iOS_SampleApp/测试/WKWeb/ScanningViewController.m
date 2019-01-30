//
//  ScanningViewController.m
//  CXScanning
//
//  Created by artifeng on 16/1/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "ScanningViewController.h"
#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y

#define SHeight 20

#define SWidth (XCenter+30)


@interface ScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView * imageView;
    int _scanY;//Y轴偏移量
    BOOL _Isup;//线移动位置
    NSTimer * _timer;
}

@property (strong,nonatomic) AVCaptureDevice * device;
@property (strong,nonatomic) AVCaptureDeviceInput * input;
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
@property (strong,nonatomic) AVCaptureSession * session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (strong,nonatomic) UIImageView * line;
@property (strong,nonatomic) UIButton *closeBtn;
@property (strong,nonatomic) UILabel *infoLab;
@property (nonatomic,copy) scanHandle handle;
@end

@implementation ScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpDefault];
    [self setupCamera];
    [self.view bringSubviewToFront:self.infoLab];
    [self.view bringSubviewToFront:self.closeBtn];
}

-(void)setUpDefault{
    _Isup = NO;
    _scanY =0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

-(void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(Width*0.2,(Height - SWidth)/2+SWidth+10, Width*0.6, 100)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor orangeColor];
    labIntroudction.text=@"将二维码放入指定区域,将自动进行扫描";
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labIntroudction];
    self.infoLab = labIntroudction;
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 35, 35)];
    [closeBtn setImage:[UIImage imageNamed:@"close_preview"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(disAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    self.closeBtn = closeBtn;
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((Width-SWidth)/2,(Height-SWidth)/2,SWidth,SWidth)];
    imageView.image = [UIImage imageNamed:@"scanscanBg.png"];
    [self.view addSubview:imageView];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5, SWidth-10,4)];
    _line.image = [UIImage imageNamed:@"scanLine@2x.png"];
    [self.view addSubview:_line];
}

-(void)viewWillAppear:(BOOL)animated{
    [self starTimer];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self stopTimer];
}

#pragma mark action

-(void)disAction{
    [self dismissViewControllerAnimated:YES completion:^{
        if (_session) {
            [_session stopRunning];
        }
        [_timer timeInterval];
    }];
}

-(void)starTimer{
    [_timer setFireDate:[NSDate date]];
}

-(void)stopTimer{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)animation
{
    if (_Isup == NO) {
        _scanY ++;
        _line.frame = CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*_scanY, SWidth-10,4);
       
        if (_scanY ==(int)(( SWidth-10)/2)) {
            _Isup = YES;
        }
    }
    else {
        _scanY --;
        _line.frame =CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*_scanY, SWidth-10,4);
        
        if (_scanY == 0) {
            _Isup = NO;
        }
    }
    
}

#pragma mark handle

-(void)configureScanHandle:(void (^)(NSString*))handle{
    if (handle) {
        self.handle = handle;
    }
}

- (void)setupCamera
{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机权限被限制" message:@"请在设置中打开本应用相机权限后重新尝试本次操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _output.rectOfInterest =[self rectOfInterestByScanViewRect:imageView.frame];
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]){
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]){
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResize;
    _preview.frame =self.view.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    //扫描线,放在最上层
    [self.view bringSubviewToFront:imageView];
    //限制透明范围
    [self setOverView];
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if ([metadataObjects count] >0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *stringValue = metadataObject.stringValue;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"扫描结果：%@", stringValue] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.handle) {
                self.handle(stringValue);
            }
            [self disAction];
        }];
        [alert addAction:okAction];
        UIAlertAction *reDoAction = [UIAlertAction actionWithTitle:@"重新扫描" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [_session startRunning];
        }];
        [alert addAction:reDoAction];
        [self presentViewController:alert animated:true completion:nil];
    }
    
    [_session stopRunning];

}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2.0 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2.0 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
   
    //(top left width height)---默认(0,0,1,1)
    return CGRectMake(x, y, w, h);
}

#pragma mark - 添加模糊效果
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(imageView.frame);
    CGFloat y = CGRectGetMinY(imageView.frame);
    CGFloat w = CGRectGetWidth(imageView.frame);
    CGFloat h = CGRectGetHeight(imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.7;
    UIColor *backColor = [UIColor grayColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
