//
//  BJTestWebViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/15.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJTestWebViewController.h"
#import "BaseHeader.h"
#import <CoreLocation/CoreLocation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BJTestWebViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIWebView *webViewUI;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic,assign) float compression;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation BJTestWebViewController
{
    BJJSWKTools *ToolsManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ToolsManager = [BJJSWKTools sharedInstance];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)setUpUI {
    [self.view addSubview:self.webView];
//    [self.view addSubview:self.webViewUI];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.button];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, KScreenH - 50, 100, 50);
        [_button setTitle:@"click" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor brownColor]];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)btnSelect {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"徐野", @"name", @"30", @"age", @"女", @"sex", @"1", @"code", nil];
    NSString *string = [ToolsManager toStringForDic:dic andMethodName:@"alertAction"];
    [_webView evaluateJavaScript:string completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        NSLog(@"WKError=======%@", error);
    }];
}

- (UIWebView *)webViewUI {
    if (!_webViewUI) {
        _webViewUI = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW / 2, KScreenH / 2)];
        NSString *str = @"http://www.baidu.com";
        [_webViewUI loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:_webViewUI];
        _webViewUI.center = self.view.center;
    }
    return _webViewUI;
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"Share"];
        [userContentController addScriptMessageHandler:self name:@"JSBStartLocate"];
        [userContentController addScriptMessageHandler:self name:@"JSBImageSource"];
        [userContentController addScriptMessageHandler:self name:@"JSBScanQRCode"];
        [userContentController addScriptMessageHandler:self name:@"back"];
        configuration.userContentController = userContentController;
        WKPreferences *preferences = [[WKPreferences alloc] init];
        // 允许js交互
        preferences.javaScriptEnabled = YES;
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 20;
        configuration.preferences = preferences;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NaviH, KScreenW, KScreenH / 2) configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        // 监听进度条
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        NSString *h5UrlStr = @"http://www.baidu.com";
        NSString *strHtmlPath = [[NSBundle mainBundle] pathForResource:@"h5ForWKWebView" ofType:@"html"];
        NSURL *url = [NSURL URLWithString:[h5UrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        NSURL *urlhtml = [NSURL fileURLWithPath:strHtmlPath];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlhtml];
        [_webView loadRequest:request];
    }
    return _webView;
}
- (UIProgressView *)progressView {
    if (!_progressView) {
        //进度条的创建
        _progressView =[[UIProgressView alloc] init];
        //进度条的位置大小设置
        //进度条的高度是不可以变化的，这里的40是不起任何作用的系统默认
        _progressView.frame = CGRectMake(0, 0, KScreenW, 20);
        //甚至进度条的风格颜色值，默认是蓝色的
        _progressView.progressTintColor=[UIColor redColor];
        //表示进度条未完成的，剩余的轨迹颜色,默认是灰色
        _progressView.trackTintColor =[UIColor blueColor];
        //设置进度条的进度值
        //范围从0~1，最小值为0，最大值为1.
        //0.8-->进度的80%
        _progressView.progress=0.3;
        //设置进度条的风格特征
    //    _progressView.progressViewStyle=UIProgressViewStyleBar;
    _progressView.progressViewStyle=UIProgressViewStyleDefault;
        
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _progressView.progress = [change[@"new"] floatValue];
        if (_progressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _progressView.hidden = YES;
            });
        }
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 移除所有
//    [_webView.configuration.userContentController removeAllUserScripts];
    
}

- (void)clean {
    // 页面消失的时候移除代理 否则不会调用delloc
    [_webView.configuration.userContentController
     removeScriptMessageHandlerForName:@"Share"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSBStartLocate"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSBImageSource"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSBScanQRCode"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"back"];
}

- (NSMutableDictionary *)stringChangeDic:(NSString *)string {
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSMutableDictionary *param = [self stringChangeDic:[NSString stringWithFormat:@"%@", message.body]];
    
    if ([message.name isEqualToString:@"Share"]) {
        NSLog(@"%@", message.body);
        
    } else if ([message.name isEqualToString:@"JSBStartLocate"]) {
        NSLog(@"JSBStartLocate调用成功");
        
        CLLocationAccuracy accuracy = kCLLocationAccuracyBest;
        NSString *distance = param[@"distance"];
        float dis = distance.floatValue;
        if (dis<=0) {
            accuracy = kCLLocationAccuracyBest;
        }else if (dis<=10){
            accuracy = kCLLocationAccuracyNearestTenMeters;
        }else if (dis<=100){
            accuracy = kCLLocationAccuracyHundredMeters;
        }else if (dis<=1000){
            accuracy = kCLLocationAccuracyKilometer;
        }else{
            accuracy = kCLLocationAccuracyThreeKilometers;
        }
        
        
        [self startLocationWithAccuracy:accuracy];
        
        
    } else if ([message.name isEqualToString:@"JSBImageSource"]) {
        
        NSString *imageSource = param[@"imageSource"];
        if ([imageSource isEqualToString:@"0"]) {
            [self openPhoto];
        } else if ([imageSource isEqualToString:@"1"]) {
            // 相册
            
            [self openPhoto];
        } else if ([imageSource isEqualToString:@"2"]) {
            // 相机
            [self openCamera];
        }
        NSLog(@"JSBImageSource调用成功");
    } else if ([message.name isEqualToString:@"JSBScanQRCode"]) {
        NSLog(@"JSBScanQRCode调用成功");
        [self scan];
    } else if ([message.name isEqualToString:@"back"]) {
        NSLog(@"back调用成功");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// 定位
#pragma mark - 定位
//开始定位
- (void)startLocationWithAccuracy:(CLLocationAccuracy)accuracy{
    /*
     kCLAuthorizationStatusNotDetermined                  //用户尚未对该应用程序作出选择
     kCLAuthorizationStatusRestricted                     //应用程序的定位权限被限制
     kCLAuthorizationStatusAuthorizedAlways               //一直允许获取定位
     kCLAuthorizationStatusAuthorizedWhenInUse            //在使用时允许获取定位
     kCLAuthorizationStatusAuthorized                     //已废弃，相当于一直允许获取定位
     kCLAuthorizationStatusDenied                         //拒绝获取定位
     */
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary *error = [NSMutableDictionary dictionary];
            error[@"respCode"] = @"1002";
            error[@"respDesc"] = @"用户拒绝获取位置信息";
            NSString *retInfo = [self returnJsonStringWithDictionary:error];
            [self nativeCallJSWithMethodName:@"JSBGetLocationInfo" andDic:error];
//            [[JSTools bridge] callAction:OCActionGetLoctionJsonString param:@[retInfo]];
        });
        
        return;
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        if (!self.locationManager) {
            CLLocationManager *manager = [[CLLocationManager alloc] init];
            manager.delegate = self;
            //控制定位精度
            
            manager.desiredAccuracy = accuracy;
            
            // 总是授权
            [manager requestWhenInUseAuthorization];
            manager.distanceFilter = 10.0f;
            [manager requestWhenInUseAuthorization];
            [manager startUpdatingLocation];
            self.locationManager = manager;
        }else{
            NSLog(@"已经初始化manager");
            [self.locationManager startUpdatingLocation];
        }
        
    }else{
//        XHJLog(@"无法使用定位");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary *error = [NSMutableDictionary dictionary];
            
            error[@"respCode"] = @"1003";
            error[@"respDesc"] = @"该设备不支持定位功能";
            NSString *retInfo = [self returnJsonStringWithDictionary:error];
            [self nativeCallJSWithMethodName:@"JSBGetLocationInfo" andDic:error];
//            [[JSTools bridge] callAction:OCActionGetLoctionJsonString param:@[retInfo]];
        });
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if ([error code] == kCLErrorDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您拒绝了定位服务" message:@"如需定位服务请在设置中开启本应用定位权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
//        XHJLog(@"定位:访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
//        XHJLog(@"无法获取位置信息");
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.firstObject;
    NSTimeInterval locationAge = -[location.timestamp timeIntervalSinceNow];
    if (locationAge>1.0) {
        return;
    }
    [self.locationManager stopUpdatingLocation];
    double latitude = location.coordinate.latitude;
    double longitude = location.coordinate.longitude;
    NSMutableDictionary *locInfoDic = [NSMutableDictionary dictionary];
    locInfoDic[@"respCode"] = @"0000";
    locInfoDic[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
    locInfoDic[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    self.locationManager = nil;
    
    //根据获取的地理位置，获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:
     ^(NSArray *array, NSError *error) {
         
         if (!error && array.count>0 ) {
             
             CLPlacemark *placemark = array.firstObject;
             NSDictionary *addressInfo = [placemark addressDictionary];
             NSArray *addressLines = [addressInfo objectForKey:@"FormattedAddressLines"];
             if (addressLines&&addressLines.count>0) {
                 NSString *address = addressLines.firstObject;
                 if (address&&address.length>0) {
                     NSMutableDictionary *retDic = [NSMutableDictionary dictionaryWithDictionary:locInfoDic];
                     retDic[@"respDesc"] = address;
                     
                     NSString *retInfo = [self returnJsonStringWithDictionary:retDic];
                     [self nativeCallJSWithMethodName:@"JSBGetLocationInfo" andDic:retDic];
//                     [[JSTools bridge] callAction:OCActionGetLoctionJsonString param:@[retInfo]];
                 }
             }
         }else{
             [locInfoDic setObject:@"未获取到详细地址" forKey:@"respDesc"];
             
             NSString *retInfo = [self returnJsonStringWithDictionary:locInfoDic];
             [self nativeCallJSWithMethodName:@"JSBGetLocationInfo" andDic:locInfoDic];
//             [[JSTools bridge] callAction:OCActionGetLoctionJsonString param:@[retInfo]];
         }
         
     }];
    
}



// 扫一扫

- (void)scan {
    ScanningViewController *scanVc = [[ScanningViewController alloc] init];
    [scanVc configureScanHandle:^(NSString *scanObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableDictionary *retDic = [NSMutableDictionary dictionary];
            retDic[@"QRCode"] = scanObject;
            retDic[@"respCode"] = @"0000";
            retDic[@"respDesc"] = @"二维码解析成功";
            [self nativeCallJSWithMethodName:@"JSBGetQRCodeResultInfo" andDic:retDic];
//            NSString *retInfo = [self returnJsonStringWithDictionary:retDic];
            
//            [[JSTools bridge] callAction:OCActionGetQRcodeString param:@[retInfo]];
        });
    }];
    [self presentViewController:scanVc animated:YES completion:nil];
}

//相册
- (void)openPhoto{
    /**
     UIImagePickerControllerSourceTypePhotoLibrary ,//来自图库
     UIImagePickerControllerSourceTypeCamera ,//来自相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum //来自相册
     */
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//相机
- (void)openCamera{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusDenied) {
        NSMutableDictionary *error = [NSMutableDictionary dictionary];
        error[@"respCode"] = @"2002";
        error[@"respDesc"] = @"相机权限被限制";
        NSString *retInfo = [self returnJsonStringWithDictionary:error];
//        [[JSTools bridge] callAction:OCActionGetPhoto param:@[retInfo]];
        return;
    }
    
    //判断是否可以打开相机，模拟器此功能无法使用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSMutableDictionary *error = [NSMutableDictionary dictionary];
        error[@"respCode"] = @"2003";
        error[@"respDesc"] = @"该设备不支持相机";
        NSString *retInfo = [self returnJsonStringWithDictionary:error];
//        [[JSTools bridge] callAction:OCActionGetPhoto param:@[retInfo]];
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    /**
     
     选取的信息都在info中，info 是一个字典。
     字典中的键：
     NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
     NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     
     */
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            UIImage *image = nil;
            NSString *imgW = @"300";
            NSString *imgH = @"300";
            
            if ([mediaType isEqualToString:@"public.image"]) {
                image = [info objectForKey:UIImagePickerControllerEditedImage];
            }
            
            if (image) {
                imgW = [NSString stringWithFormat:@"%f",image.size.width];
                imgH = [NSString stringWithFormat:@"%f",image.size.height];
            }
            
            NSData *imageData = UIImageJPEGRepresentation(image, self.compression);
            NSString *imgBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary *retDic = [NSMutableDictionary dictionary];
                retDic[@"respCode"] = @"0000";
                retDic[@"imageForBase64"] = imgBase64;
                retDic[@"imageHeight"] = imgH;
                retDic[@"imageWidth"] = imgW;
                retDic[@"imageType"] = @"JPEG";
                retDic[@"respDesc"] = @"获取图片信息成功";
                
                NSString *retInfo = [self returnJsonStringWithDictionary:retDic];
//                [[JSTools bridge] callAction:OCActionGetPhoto param:@[retInfo]];
            });
        });
    }];
}

- (void)nativeCallJSWithMethodName:(NSString *)methodName andDic:(NSMutableDictionary *)dic {
    NSString *string = [ToolsManager toStringForDic:dic andMethodName:methodName];
    [_webView evaluateJavaScript:string completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        NSLog(@"WKError=======%@", error);
    }];
}

- (NSString*)returnJsonStringWithDictionary:(NSDictionary*)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return jsonStr;
}


//1. 在发送请求之前，决定是否跳转

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//}

//2. 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

////3 在接受响应后决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler {
//
//}

//4. 当页面开始返回内容时调用

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

//5. 页面加载完成之后调用

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

// 页面加载失败调用

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}
//
//// 接收到服务器跳转请求时调用， 不一定调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//
//}
//
//// 从创建一个webview
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    return nil;
//}
//
//// 关闭webview ios9新方法
//- (void)webViewDidClose:(WKWebView *)webView {
//    
//}

// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();//此处的completionHandler()就是调用JS方法时，`evaluateJavaScript`方法中的completionHandler
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// 输入框

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
}
// 确认框

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
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
