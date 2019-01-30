//
//  BJHomeTypeTwoTableViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/8.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTypeTwoTableViewCell.h"
#import "BaseHeader.h"

@interface BJHomeTypeTwoTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BJHomeTypeTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

// 热点课程

- (void)createSubViews {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.itemSize = CGSizeMake((KScreenW - 20) / 3, 180);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 200) collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BJHomeTypeTwoCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [self.contentView addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BJHomeTypeTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    return cell;
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
