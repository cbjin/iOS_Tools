//
//  BJHomeHeaderView.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/29.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeHeaderView.h"
#import "BaseHeader.h"

@interface BJHomeHeaderView ()

@property (nonatomic, strong) UIButton *btnMenu;

@end

@implementation BJHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    CGFloat between = 8;
    CGFloat btnWidth = (viewWidth - 5 * between) / 4;
    NSMutableArray *arr = @[@"支付码", @"看数据", @"办业务", @"查进展"].mutableCopy;
    
    for (int i = 0; i < 4; i++) {
        _btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnMenu.frame = CGRectMake(between * (i + 1) + btnWidth * i, 10, btnWidth, viewHeight - between * 2);
        [_btnMenu setTitle:arr[i] forState:UIControlStateNormal];
        _btnMenu.titleLabel.font = [UIFont systemFontOfSize:HomeFont];
        [_btnMenu setImage:[UIImage imageNamed:arr[0]] forState:UIControlStateNormal];
        [_btnMenu verticalImageAndTitle:2];
        _btnMenu.tag = i + 500;
        [_btnMenu addTarget:self action:@selector(btnSelectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnMenu];
    }
}

- (void)btnSelectMenu:(UIButton *)btn {
    if (self.myBlock) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[NSString stringWithFormat:@"%ld", btn.tag - 500] forKey:@"type"];
        self.myBlock(dic);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
