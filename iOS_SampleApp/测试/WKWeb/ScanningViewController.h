//
//  ScanningViewController.h
//  CXScanning
//
//  Created by artifeng on 16/1/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^scanHandle)(NSString*message);

@interface ScanningViewController : UIViewController

-(void)configureScanHandle:(void(^)(NSString* scanObject))handle;

@end
