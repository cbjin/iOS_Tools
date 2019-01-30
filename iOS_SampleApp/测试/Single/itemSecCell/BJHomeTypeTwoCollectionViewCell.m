//
//  BJHomeTypeTwoCollectionViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/14.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTypeTwoCollectionViewCell.h"
#import "BaseHeader.h"

@interface BJHomeTypeTwoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *label;

@end

@implementation BJHomeTypeTwoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.contentView.frame) - 10, 90)];
    _img.image = [UIImage imageNamed:@"timg"];
    [self.contentView addSubview:_img];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_img.frame), CGRectGetWidth(_img.frame), 40)];
    _label.textAlignment = 0;
    _label.numberOfLines = 2;
    _label.text = @"联通专业知识技能导论一";
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_label];
}

@end
