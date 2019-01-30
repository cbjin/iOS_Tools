//
//  BJFunctionOneViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/25.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJFunctionOneViewController.h"
#import "BaseHeader.h"
#import "BJSingleTest.h"

@interface BJFunctionOneViewController ()<UITableViewDelegate,
UITableViewDataSource, BJBaseViewTableDelegate, BJBaseViewTableDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BJBaseViewController *baseVC;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation BJFunctionOneViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self printName];
}

- (void)printName {
    BJSingleTest *single = [BJSingleTest sharedInstance];
    NSLog(@"%@", single.name);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self printName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaa:) name:@"fff" object:nil];
    // Do any additional setup after loading the view.
}

- (void)aaa:(NSNotification *)noti {
    NSLog(@"fff");
    
}

- (NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AppUI" ofType:@"plist"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        _arrData = dic[@"appUI"];
    }
    return _arrData;
}

#pragma mark - set UI

- (void)setUpUI {
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame), KScreenW, KScreenH - NaviH - TabBarH - SafeAreaBottom) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"use"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"use"];
    cell.textLabel.text = _arrData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BJFuncOneDetailViewController *detail = [BJFuncOneDetailViewController new];
    detail.type = _arrData[indexPath.row];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
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
