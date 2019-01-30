//
//  BJHomeTableHeaderView.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/12/26.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTableHeaderView.h"
#import "BaseHeader.h"

@interface BJHomeTableHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgV;

@end

@implementation BJHomeTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenW, self.frame.size.height) imageNamesGroup:@[@"1", @"2", @"3", @"4"]];
    bannerView.autoScrollTimeInterval = 2;
    bannerView.showPageControl = YES;
    bannerView.delegate = self;
    [self.contentView addSubview:bannerView];
    
    _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _imgV.image = [UIImage imageNamed:@"timg"];
//    [self.contentView addSubview:_imgV];
    _imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg)];
    [_imgV addGestureRecognizer:tap];
}

- (void)clickImg {
    if (self.block) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"徐野" forKey:@"name"];
        self.block(dic);
    }
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.block) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"徐野" forKey:@"name"];
        self.block(dic);
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
