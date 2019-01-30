//
//  BJBtnCollectionViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/25.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJBtnCollectionViewCell.h"
#import "BaseHeader.h"

@interface BJBtnCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation BJBtnCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)setStr:(NSString *)str {
    _str = str;
    _label.text = _str;
}

- (void)createSubViews {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.contentView addSubview:_label];
}


@end
