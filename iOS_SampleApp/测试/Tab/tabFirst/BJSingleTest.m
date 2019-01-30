//
//  BJSingleTest.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/12/13.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJSingleTest.h"

@implementation BJSingleTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}




@end
