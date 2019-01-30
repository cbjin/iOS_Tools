//
//  BJHomeTableViewHeaderView.h
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/25.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HomeBlock)(NSDictionary *dic);

@interface BJHomeTableViewHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) HomeBlock myblock;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSString *str;
@end
