//
//  BJHomeHeaderView.h
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/29.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HomeBlock)(NSDictionary *dic);

@interface BJHomeHeaderView : UIView

@property (nonatomic, copy) HomeBlock myBlock;

@end
