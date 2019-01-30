//
//  BJHomeMTViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/12/21.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeMTViewController.h"
#import "BaseHeader.h"
#import "NSRegularExpression+SHY_GetValues.h"

@interface BJHomeMTViewController  ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, JHCustomMenuDelegate, CityListViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JHCustomMenu *menu;
@property (nonatomic, strong) UIButton *btnItem1;
@property (nonatomic, strong) NSArray *arr;

@end

#define NAVBAR_CHANGE_POINT 50

@implementation BJHomeMTViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self setUpNaviUI];
    [self setUPUI];
    // Do any additional setup after loading the view.
}

- (void)setUpNaviUI {
    
    UIView *viewNaviHeader = [[UIView alloc] initWithFrame:CGRectMake(0, NaviH, KScreenW * 0.55, 34)];
    self.navigationItem.titleView = viewNaviHeader;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewNaviHeader.frame), CGRectGetHeight(viewNaviHeader.frame))];
    _searchBar.placeholder = @"请输入关键字儿";
    _searchBar.delegate = self;
    _searchBar.searchBarStyle = UISearchBarStyleProminent;
    _searchBar.barStyle = UIBarStyleDefault;
    [viewNaviHeader addSubview:_searchBar];
    _searchBar.barTintColor = [UIColor clearColor];
    
    UITextField *searchTF = nil;
    searchTF = [[[_searchBar.subviews firstObject] subviews] lastObject];
    _searchBar.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage imageNamed:@"search-2"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
    iconView.frame = CGRectMake(0, 0, image.size.width , image.size.height);
    searchTF.leftView = iconView;
    searchTF.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.5];
    [searchTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    // 左侧 头像
    UIImage *imgIcon = [UIImage imageNamed:@"未登录"];
    UIButton *btnItem0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnItem0.frame = CGRectMake(0, 0, 40, 40);
    [btnItem0 setImage:imgIcon forState:UIControlStateNormal];
    [btnItem0 addTarget:self action:@selector(person:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnItem1.frame = CGRectMake(0, 0, 40, 40);
    [_btnItem1 setTitle:@"请选择" forState:UIControlStateNormal];
    [_btnItem1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnItem1.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btnItem1 addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -25;
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithCustomView:btnItem0];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:_btnItem1];
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, item0, item1];
    // 右侧 add
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.edgesForExtendedLayout = UIRectEdgeTop;
}

- (void)person:(UIBarButtonItem *)btnItem {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"BRegionUnifiedPortal://"]];
//    return;
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"徐野大煞笔"];  //创建语音  Hello World 合成的文本
//        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]; //合成英文 嗓音属性
//        utterance.rate = 0.5f;    //  播放速率
//        utterance.pitchMultiplier = 0.8f;  //改变音调
//        utterance.postUtteranceDelay = 0.1f;  //播放下一句是有个短时间的暂停
//        AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];  //运用合成器
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [av speakUtterance:utterance];
//        });
//        
//    });
//    [self presentCropViewController];
    
}



- (void)location:(UIBarButtonItem *)btnItem {
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"天津",@"厦门",@"重庆",@"福州",@"泉州",@"济南",@"深圳",@"长沙",@"无锡", nil];
    //历史选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",@"厦门",@"泉州", nil];
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:@"福州", nil];
    
    [self presentViewController:cityListView animated:YES completion:nil];
    
}

- (void)didClickedWithCityName:(NSString *)cityName {
    NSLog(@"%@", cityName);
    NSString *str = @"aaaaa(12bbasdf)ffff";
    NSArray <NSString *>* parts = [NSRegularExpression arrayOfCheckStringWithRegularExpression:@".*?\\((.*?)\\).*?" checkString:str];
    NSLog(@"%@", [parts firstObject]);
    [_btnItem1 setTitle:cityName forState:UIControlStateNormal];
}

- (void)add:(UIBarButtonItem *)btnItem {
    __weak __typeof(self) weakSelf = self;
    if (!self.menu) {
        self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"扫一扫", @"加好友", @"支付"] origin:CGPointMake(0, 0) width:125 rowHeight:44];
        _menu.delegate = self;
        _menu.dismiss = ^() {
            weakSelf.menu = nil;
        };
        _menu.arrImgName = @[@"扫一扫-1", @"加好友", @"支付"];
        [self.view addSubview:_menu];
    } else {
        [_menu dismissWithCompletion:^(JHCustomMenu *object) {
            weakSelf.menu = nil;
        }];
    }
}

- (LBXScanViewStyle *)setUP {
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    //扫码框中心位置与View中心位置上移偏移像素(一般扫码框在视图中心位置上方一点)
    style.centerUpOffset = 44;
    //扫码框周围4个角的类型设置为在框的上面,可自行修改查看效果
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    
    //扫码框周围4个角绘制线段宽度
    style.photoframeLineW = 6;
    //扫码框周围4个角水平长度
    style.photoframeAngleW = 24;
    //扫码框周围4个角垂直高度
    style.photoframeAngleH = 24;
    //动画类型：网格形式，模仿支付宝
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    //动画图片:网格图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];;
    
    //扫码框周围4个角的颜色
    style.colorAngle = [UIColor colorWithRed:65./255. green:174./255. blue:57./255. alpha:1.0];
    
    //是否显示扫码框
    style.isNeedShowRetangle = YES;
    //扫码框颜色
    style.colorRetangleLine = [UIColor colorWithRed:247/255. green:202./255. blue:15./255. alpha:1.0];
    
    //非扫码框区域颜色(扫码框周围颜色，一般颜色略暗)
    //必须通过[UIColor colorWithRed: green: blue: alpha:]来创建，内部需要解析成RGBA
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    return style;
}

- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select: %ld", indexPath.row);
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"扫一扫");
            BJScanViewController *scan = [BJScanViewController new];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:scan];
            LBXScanViewStyle *style = [self setUP];
            scan.style = style;
            [self presentViewController:navi animated:YES completion:nil];
        }
            break;
        case 1:
        {
            NSLog(@"加好友");
            [self welcomeTo];
        }
            break;
        case 2:
        {
            NSLog(@"支付");
            [self welcomeTo];
        }
            break;
        default:
            break;
    }
}

- (void)welcomeTo {
    [SVProgressHUD showInfoWithStatus:@"敬请期待"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });
        
    });
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[BJHomeSearchViewController new]] animated:YES completion:^{
        
    }];
    
    return NO;
}

- (void)setUPUI {
    [self.view addSubview:self.tableView];
    
    BJHomeTableHeaderView *tableHeaderView = [[BJHomeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 200)];
    tableHeaderView.block = ^(NSMutableDictionary *dic) {
        NSLog(@"%@", dic[@"name"]);
        [_searchBar resignFirstResponder];
    };
    _tableView.tableHeaderView = tableHeaderView;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - TabBarH - SafeAreaBottom) style:UITableViewStylePlain];
//        _tableView.contentInset = UIEdgeInsetsZero;
//        _tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *viewHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                      reuseIdentifier: @"reuse"];
    }
    cell.textLabel.text = @"徐野";
    cell.detailTextLabel.text = @"DSB";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_searchBar resignFirstResponder];
    BJDiscoverMTViewController *discover = [BJDiscoverMTViewController new];
    discover.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:discover animated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0) {
        CGFloat alpha = MIN(1, 1 - ((136 - offsetY) / 136));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        self.navigationController.navigationBarHidden = NO;
    } else {
        
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
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
