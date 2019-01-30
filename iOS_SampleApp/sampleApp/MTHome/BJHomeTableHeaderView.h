//
//  BJHomeTableHeaderView.h
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/12/26.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSMutableDictionary *dic);

@interface BJHomeTableHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) MyBlock block;


@end
