//
//  BJHomeTypeThreeTableViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/8.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTypeThreeTableViewCell.h"
#import "BaseHeader.h"

@interface BJHomeTypeThreeTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BJHomeTypeThreeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

// 推荐活动
- (void)createSubViews {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.itemSize = CGSizeMake((KScreenW - 20) / 2, 90);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.headerReferenceSize = CGSizeMake(KScreenW - 20, 120);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 230) collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BJHomeTypeThreeCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:KCollectionHeader withReuseIdentifier:@"header"];
    [self.contentView addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:KCollectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, KScreenW - 20, 120)];
    img.image = [UIImage imageNamed:@"timg"];
    [view addSubview:img];
    
    return view;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BJHomeTypeThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
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
