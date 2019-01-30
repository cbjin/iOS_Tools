//
//  BJHomeTypeThreeCollectionViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/14.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTypeThreeCollectionViewCell.h"
#import "BaseHeader.h"

@interface BJHomeTypeThreeCollectionViewCell ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelDes;
@property (nonatomic, strong) UIImageView *img;

@end

@implementation BJHomeTypeThreeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, CGRectGetWidth(self.contentView.frame) - 50, 20)];
    _labelTitle.textAlignment = 0;
    _labelTitle.text = @"推荐办卡";
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelTitle];
    
    _labelDes = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, CGRectGetWidth(self.contentView.frame) - 50, 20)];
    _labelDes.textAlignment = 0;
    _labelDes.text = @"各种好礼等你来挑";
    _labelDes.textColor = [UIColor lightGrayColor];
    _labelDes.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_labelDes];
    
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) - 50, 25, 40, 40)];
    _img.clipsToBounds = YES;
    _img.layer.cornerRadius = 20;
    _img.backgroundColor = BJRandomColor;
//    _img.image = [UIImage imageNamed:@"timg"];
    [self.contentView addSubview:_img];
}

@end
