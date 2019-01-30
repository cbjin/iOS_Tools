//
//  BJSingleTest.h
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/12/13.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJSingleTest : NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)init;

+ (instancetype)sharedInstance;


@end
