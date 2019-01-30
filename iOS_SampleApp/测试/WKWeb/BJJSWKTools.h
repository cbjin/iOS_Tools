//
//  BJJSWKTools.h
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/18.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJJSWKTools : NSObject
// 初始化
+ (instancetype)sharedInstance;
// 返回js 方法以及参数 字符串
- (NSString *)toStringForDic:(NSMutableDictionary *)dic andMethodName:(NSString *)method;

@end
