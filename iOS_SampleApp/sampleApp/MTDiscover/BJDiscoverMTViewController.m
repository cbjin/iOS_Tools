//
//  BJDiscoverMTViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2019/1/3.
//  Copyright © 2019年 蔡佰津. All rights reserved.
//

#import "BJDiscoverMTViewController.h"

@interface BJDiscoverMTViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, TOCropViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) TOCropViewController *cropViewController;
@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation BJDiscoverMTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _imageV = [[UIImageView alloc] init];
    [self.view addSubview:_imageV];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [btn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view.
}

- (void)btn {
    [self openCamera];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}

//相机
- (void)openCamera{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusDenied) {
        NSMutableDictionary *error = [NSMutableDictionary dictionary];
        error[@"respCode"] = @"2002";
        error[@"respDesc"] = @"相机权限被限制";
        //        NSString *retInfo = [self returnJsonStringWithDictionary:error];
        //        [[JSTools bridge] callAction:OCActionGetPhoto param:@[retInfo]];
        return;
    }
    
    //判断是否可以打开相机，模拟器此功能无法使用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSMutableDictionary *error = [NSMutableDictionary dictionary];
        error[@"respCode"] = @"2003";
        error[@"respDesc"] = @"该设备不支持相机";
        //        NSString *retInfo = [self returnJsonStringWithDictionary:error];
        //        [[JSTools bridge] callAction:OCActionGetPhoto param:@[retInfo]];
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
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
    
    [picker dismissViewControllerAnimated:NO completion:^{
        
    }];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image = nil;
    if ([mediaType isEqualToString:@"public.image"]) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    [self presentCropViewController:image];
}

- (void)presentCropViewController:(UIImage *)img
{
    UIImage *image = img; //Load an image
    
    _cropViewController = [[TOCropViewController alloc] initWithImage:image];
    _cropViewController.delegate = self;
    [self presentViewController:_cropViewController animated:YES completion:nil];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    // 'image' is the newly cropped version of the original image
    
    [_cropViewController dismissAnimatedFromParentViewController:self toView:nil toFrame:CGRectZero setup:nil completion:^{
        UIImage *imgChange = image;
        CGFloat height = (100 * imgChange.size.height) / imgChange.size.width;
        _imageV.frame = CGRectMake(88, 100, 100, height);
        _imageV.image = imgChange;
        NSData *dataImg = UIImageJPEGRepresentation(imgChange, 0.9);
        NSLog(@"%.2lu",dataImg.length / 1024);
    }];

}

- (void)cropViewController:(TOCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled {
    
    [_cropViewController dismissAnimatedFromParentViewController:self toView:nil toFrame:CGRectZero setup:nil completion:^{
        
    }];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
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
