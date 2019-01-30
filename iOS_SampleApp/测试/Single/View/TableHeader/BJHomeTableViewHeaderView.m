//
//  BJHomeTableViewHeaderView.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/25.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeTableViewHeaderView.h"
#import "BaseHeader.h"
#import "BJOneCollectionViewCell.h"
#import "BJBtnCollectionViewCell.h"


@interface BJHomeTableViewHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *btnMenu;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) UICollectionViewFlowLayout *flow;

@end

@implementation BJHomeTableViewHeaderView

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
    _arrData = [NSMutableArray array];
//    _arrData addObject:_arr
    _arrData = [self splitArray:_arr withSubSize:12].mutableCopy;
    [self tableHeaderGetSize];
    [_collectionView reloadData];
    [self autoScrollCollectionView];
}

- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        int index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    
    return [arr copy];
}

- (void)autoScrollCollectionView {
    if (_arr.count % 12 != 0) {
        NSInteger count = _arr.count / 12;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    } else {
        NSInteger count = _arr.count / 12 - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (void)tableHeaderGetSize {
    CGFloat between = 10.0f;
    CGSize size = CGSizeMake((KScreenW - 50) / 4, 160.0 / 3.0);
    NSInteger count = _arr.count;
    if (count > 8) {
        _collectionView.frame = CGRectMake(0, 0, KScreenW, 200);
        _flow.itemSize = CGSizeMake(KScreenW, 200);
    } else if (count > 4) {
        _collectionView.frame = CGRectMake(0, 0, KScreenW, size.height * 2 + between * 3);
        _flow.itemSize = CGSizeMake(KScreenW, size.height * 2 + between * 3);
    } else if (count > 0 && count <= 4) {
        _collectionView.frame = CGRectMake(0, 0, KScreenW, size.height + between * 2);
        _flow.itemSize = CGSizeMake(KScreenW, size.height + between * 2);
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flow = [[UICollectionViewFlowLayout alloc] init];
        _flow.minimumLineSpacing = 0;
        _flow.minimumInteritemSpacing = 0;
        _flow.itemSize = CGSizeMake(KScreenW, 200);
        _flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 200) collectionViewLayout:_flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = YES;
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BJOneCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_arr.count % 12 != 0) {
        return _arr.count / 12 + 1;
    } else {
        return _arr.count/ 12;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BJOneCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.arr = _arrData[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor brownColor];
    }
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
