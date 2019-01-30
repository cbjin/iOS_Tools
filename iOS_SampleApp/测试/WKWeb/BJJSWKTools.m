//
//  BJJSWKTools.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/18.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJJSWKTools.h"
#import "BaseHeader.h"

@interface BJJSWKTools ()

@property (nonatomic, strong) WKWebView *webView;

@end

static BJJSWKTools *mySingleton = nil;

@implementation BJJSWKTools

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(mySingleton == nil)
        {
            mySingleton = [[self alloc] init];
        }
    });
    
    return mySingleton;
}

- (void)jsCallOCWithMethodArray:(NSArray *)methodArray {
    
}

- (NSString *)toStringForDic:(NSMutableDictionary *)dic andMethodName:(NSString *)method {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
    NSString *strJSON = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", strJSON);
    NSString *string = [NSString stringWithFormat:@"%@('%@')", method, strJSON];
    return string;
}



@end
