//
//  BJHomeTypeFourTableViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/14.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTypeFourTableViewCell.h"
#import "BaseHeader.h"

@interface BJHomeTypeFourTableViewCell ()

@property (nonatomic, strong) UILabel *labelNum;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;

@end

@implementation BJHomeTypeFourTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

// 精华工单

- (void)createSubViews {
    _labelNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
    _labelNum.textAlignment = 1;
    _labelNum.clipsToBounds = YES;
    _labelNum.layer.cornerRadius = 15;
    _labelNum.text = @"1";
    _labelNum.textColor = [UIColor whiteColor];
    _labelNum.backgroundColor = BJRandomColor;
    _labelNum.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelNum];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelNum.frame) + 10, 5, KScreenW - CGRectGetMaxY(_labelNum.frame) - 20, 20)];
    _labelTitle.textAlignment = 0;
    _labelTitle.text = @"5G服务开通处理业务须知";
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelTitle];
    
    _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelNum.frame) + 10, CGRectGetMaxY(_labelTitle.frame), CGRectGetWidth(_labelTitle.frame), 20)];
    _labelTime.textAlignment = 0;
    _labelTime.text = @"2017-11-10 15:40:12";
    _labelTime.textColor = [UIColor lightGrayColor];
    _labelTime.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_labelTime];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
