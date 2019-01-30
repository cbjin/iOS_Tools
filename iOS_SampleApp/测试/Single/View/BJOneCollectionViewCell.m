//
//  BJFourCollectionViewCell.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/25.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJOneCollectionViewCell.h"
#import "BaseHeader.h"
#import "BJBtnCollectionViewCell.h"

@interface BJOneCollectionViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BJOneCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.collectionView];
    //    CGFloat btnWBt = (KScreenW - 4 * 50) / 5;
    //    CGFloat btnHBt = (CGRectGetHeight(self.frame) -  50 * 2) / 3;
    //    for (int i = 0; i < 9; i++) {
    //        NSInteger Wnum = i % 4;
    //        NSInteger Hnum = i / 4;
    //        _btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    //        _btnMenu.frame = CGRectMake((Wnum + 1) * btnWBt + 50 *  Wnum, 60, 50, 50);
    //    }
    
    
}

- (void)setArr:(NSMutableArray *)arr {
    _arr = arr;
    
    [_collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.minimumLineSpacing = 10;
        flow.minimumInteritemSpacing = 10;
        flow.itemSize = CGSizeMake((KScreenW - 50) / 4, 160.0 / 3.0);
        flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 200) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = YES;
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BJBtnCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BJBtnCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.str = _arr[indexPath.row];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor brownColor];
    }
    return cell;
}



@end
