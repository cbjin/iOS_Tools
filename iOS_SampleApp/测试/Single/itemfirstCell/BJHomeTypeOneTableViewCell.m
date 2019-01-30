//
//  BJHomeTypeOneTableViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/8.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTypeOneTableViewCell.h"
#import "BaseHeader.h"

@interface BJHomeTypeOneTableViewCell ()

@property (nonatomic, strong) UILabel *labelTitle;

@end

@implementation BJHomeTypeOneTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self createSubViews];
//    }
//    return self;
//}
//
//// 最新公告
//
//- (void)createSubViews {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(9, 24, 2, 2)];
//    view.backgroundColor = [UIColor blackColor];
//    [self.contentView addSubview:view];
//    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, KScreenW - 40, 30)];
//    _labelTitle.textAlignment = 0;
//    _labelTitle.text = @"2017年上半年服务质量公告";
//    _labelTitle.textColor = [UIColor blackColor];
//    _labelTitle.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:_labelTitle];
//
//}

- (void)layoutSubviews {
    
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
