//
//  BJFuncTionTwoViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/25.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJFuncTionTwoViewController.h"

@interface BJFuncTionTwoViewController ()

@end

#define Base64String @"iVBORw0KGgoAAAANSUhEUgAAAGQAAABkAQAAAABYmaj5AAABIUlEQVR42rXUsY2EMBAF0I8cOIMGkKaNzdyS3QALDSwtOXMbSDQAGQHauWF9SHcBHoI75OQFFuPvGYN/fAv+RjtAYyJmwCp6Mo0R3hInRd62cNzbtrqhDlPge3K0WF1Pbv3DvNxZ2bWANiRZ52kvJVHtcGZIZ4KX2j1o2KaGUSniNco+Wjez2LJ2WFRxqt2cqy4oRDni1CSzamqikVrCRitr2nhNJJn1ThObN+YerbeKpJaQJLP8h5IqJgkjbIBT1MS5ly4A95qkT9+YOkufdEvqMC9WVr6/kqQKj6mJCIpyv9CQdm/LOubv5eYhtc+kSPq6PoYv7ytJZiXwXiN3uabIi6X+hroHOpjvdK91vBNHI8BrwtEpcm88cln/8Sr+0hc6m/TlIUrJhgAAAABJRU5ErkJggg=="

@implementation BJFuncTionTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center = self.view.center;
    imageView.image = [self base64changeImageWithString:Base64String];
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
}

#pragma mark - base64转image

- (UIImage *)base64changeImageWithString:(NSString *)base64String {
    // 将base64字符串转为NSData
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    // 将NSData转为UIImage
    UIImage *decodedImage = [UIImage imageWithData: decodeData];
    return decodedImage;
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
