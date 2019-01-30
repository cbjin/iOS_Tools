//
//  BJHomeViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/25.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeViewController.h"

@interface BJHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) BJHomeHeaderView *viewCard;
@property (nonatomic, strong) NSMutableArray *arraySection;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) BJHomeTableViewHeaderView *headView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, copy) NSString *str;
@end

@implementation BJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self setUpNavi];
    [self setUpUI];
    
    // Do any additional setup after loading the view.
}

- (void)handleData {
    self.arrayData = @[@"item0", @"item1", @"item2", @"item3", @"item4",@"item5",@"item6",@"item7",@"item8",@"item9",@"item10", @"item11", @"item12", @"item13", @"item14",@"item15",@"item16",@"item17",@"item18",@"item19",@"item20", @"item21", @"item22", @"item23", @"item24",@"item25",@"item26",@"item27",@"item28",@"item29",@"item30", @"item31", @"item32", @"item33", @"item34",@"item35",@"item36",@"item37",@"item38",@"item39"].mutableCopy;;
    _arraySection = @[@"最新公告", @"热点课程", @"推荐活动", @"精华工单"].mutableCopy;
}
- (NSMutableArray *)arrayData {
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

- (NSMutableArray *)arraySection {
    if (!_arraySection) {
        _arraySection = [NSMutableArray array];
    }
    return _arraySection;
}

- (void)setUpNavi {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    // 设置navigationBar的颜色为透明的
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIView *viewNavi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW * 0.8, 44)];
    viewNavi.backgroundColor = [UIColor whiteColor];
    [viewNavi addSubview:self.searchBar];
    // 设置 navititleview
    self.navigationItem.titleView = viewNavi;
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(naviItemOne:) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:@"用户"] forState:UIControlStateNormal];
    [informationCardBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 10;
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn addTarget:self action:@selector(naviItemTwo:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItems = @[settingBtnItem,fixedSpaceBarButtonItem,informationCardItem];
}


- (void)naviItemOne:(UIBarButtonItem *)btnItem {
    NSLog(@"用户");
//    CGRectMake(0, 0, KScreenW, 350)
//    CGRectMake(0, 150, KScreenW, 200)
    if (_arrayData.count > 1) {
        [_arrayData removeLastObject];
        _headView.arr = _arrayData;
        [self tableHeaderGetSize];
        
    }
}



- (void)tableHeaderGetSize {
    CGFloat between = 10.0f;
    CGSize size = CGSizeMake((KScreenW - 50) / 4, 160.0 / 3.0);
    NSInteger count = _arrayData.count;
    if (count > 8) {
        _tableHeaderView.frame = CGRectMake(0, 0, KScreenW, 350);
        _headView.frame = CGRectMake(0, 150, KScreenW, size.height * 3 + between * 4);
        [_tableView reloadData];
    } else if (count > 4) {
        _tableHeaderView.frame = CGRectMake(0, 0, KScreenW, 150 + size.height * 2 + between * 3);
        _headView.frame = CGRectMake(0, 150, KScreenW, size.height * 2 + between * 3);
        [_tableView reloadData];
    } else if (count > 0 && count <= 4) {
        _tableHeaderView.frame = CGRectMake(0, 0, KScreenW, 150 + size.height + between * 2);
        _headView.frame = CGRectMake(0, 150, KScreenW, size.height + between * 2);
        [_tableView reloadData];
        
    }
}

- (void)naviItemTwo:(UIBarButtonItem *)btnItem {
    NSLog(@"扫一扫");
    [_arrayData addObject:@"item(添加)"];
    _headView.arr = _arrayData;
    [self tableHeaderGetSize];
}

#pragma mark - set UI

- (void)setUpUI {
    [self.view addSubview:self.tableView];
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 350)];
    _tableHeaderView.backgroundColor = [UIColor whiteColor];
    _viewCard = [[BJHomeHeaderView alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(_tableHeaderView.frame) - 40, 150 - 40)];
    _viewCard.backgroundColor = BJRGBColor(252, 90, 8);
    _viewCard.layer.cornerRadius = 25;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_viewCard.bounds];
    _viewCard.layer.shadowColor = [UIColor blackColor].CGColor;
    _viewCard.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    _viewCard.layer.shadowOpacity = 0.4f;
    _viewCard.layer.shadowPath = shadowPath.CGPath;
    _viewCard.layer.shadowRadius = 25;
    [_tableHeaderView addSubview:_viewCard];
    
    _headView = [[BJHomeTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 150, KScreenW, 200)];
    _headView.contentView.backgroundColor = [UIColor whiteColor];
    _headView.arr = _arrayData;
    [_tableHeaderView addSubview:_headView];
    
    __weak typeof(self) weakSelf = self;
    _viewCard.myBlock = ^(NSDictionary *dic) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSInteger type = [dic[@"type"] integerValue];
        switch (type) {
            case 0:
            {
                BJTestWebViewController *web = [BJTestWebViewController new];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:web];
                [strongSelf presentViewController:navi animated:YES completion:nil];
//                [strongSelf.navigationController pushViewController:navi animated:YES];
                NSLog(@"支付码");
                
            }
            
                break;
            case 1:
                NSLog(@"看数据");
                break;
            case 2:
                NSLog(@"办业务");
                break;
            case 3:
                NSLog(@"查进度");
                break;
            default:
                break;
        }
    };
    _tableView.tableHeaderView = _tableHeaderView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, KScreenW * 0.76, 44)];
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.placeholder = @"搜索你想要的内容";
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        
    }
    return _searchBar;
}

- (void)adapteIos11:(UIScrollView *)scrollView {
    if (iOS11) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviH, KScreenW, KScreenH - NaviH - SafeAreaBottom) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self adapteIos11:_tableView];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[BJHomeTypeOneTableViewCell class] forCellReuseIdentifier:@"reuse1"];
        [_tableView registerClass:[BJHomeTypeTwoTableViewCell class] forCellReuseIdentifier:@"reuse2"];
        [_tableView registerClass:[BJHomeTypeThreeTableViewCell class] forCellReuseIdentifier:@"reuse3"];
        [_tableView registerClass:[BJHomeTypeFourTableViewCell class] forCellReuseIdentifier:@"reuse4"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_arraySection[section] isEqualToString:@"最新公告"]) {
        return 2;
        
    } else if ([_arraySection[section] isEqualToString:@"热点课程"]) {
        return 1;
        
    } else if ([_arraySection[section] isEqualToString:@"推荐活动"]) {
        return 1;
        
    } else if ([_arraySection[section] isEqualToString:@"精华工单"]) {
        return 5;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BJHomeTableViewHeaderView *tableHeaderView = [[BJHomeTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 200)];
    tableHeaderView.contentView.backgroundColor = [UIColor whiteColor];
    tableHeaderView.arr = @[@"item0", @"item1", @"item2", @"item3", @"item4",@"item5",@"item6",@"item7",@"item8",@"item9",@"item10", @"item11", @"item12", @"item13", @"item14",@"item15",@"item16",@"item17",@"item18",@"item19",@"item0", @"item1", @"item2", @"item3", @"item4",@"item5",@"item6",@"item7",@"item8",@"item9",@"item10", @"item11", @"item12", @"item13", @"item14",@"item15",@"item16",@"item17",@"item18",@"item19"].mutableCopy;
    UITableViewHeaderFooterView *headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
    headView.frame = CGRectMake(0, 0, KScreenW, 50);
    UIView *viewL = [[UIView alloc] initWithFrame:CGRectMake(10, 15, 5, 20)];
    viewL.backgroundColor = BJRGBColor(223, 76, 39);
    [headView addSubview:viewL];
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewL.frame) + 10, 10, 200, 30)];
    labelTitle.text = _arraySection[section];
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.textAlignment = 0;
    labelTitle.font = [UIFont systemFontOfSize:HomeFont + 2];
    [headView addSubview:labelTitle];
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerVier = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    footerVier.contentView.backgroundColor = BJRGBColor(246, 243, 241);
    return footerVier;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _arraySection.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_arraySection[indexPath.section] isEqualToString:@"最新公告"]) {
        return 50;
    } else if ([_arraySection[indexPath.section] isEqualToString:@"热点课程"]) {
        return 150;
    } else if ([_arraySection[indexPath.section] isEqualToString:@"推荐活动"]) {
        return 230;
    } else if ([_arraySection[indexPath.section] isEqualToString:@"精华工单"]) {
        return 60;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_arraySection[indexPath.section] isEqualToString:@"最新公告"]) {
        BJHomeTypeOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        return cell;
    } else if ([_arraySection[indexPath.section] isEqualToString:@"热点课程"]) {
        BJHomeTypeTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        return cell;
        
    } else if ([_arraySection[indexPath.section] isEqualToString:@"推荐活动"]) {
        BJHomeTypeThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        return cell;
        
    } else if ([_arraySection[indexPath.section] isEqualToString:@"精华工单"]) {
        BJHomeTypeFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
        return cell;
        
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
