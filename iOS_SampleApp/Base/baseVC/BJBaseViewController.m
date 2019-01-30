//
//  ViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/12.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJBaseViewController.h"
#import "BaseHeader.h"

@interface BJBaseViewController ()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation BJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame), KScreenW, KScreenH - NaviH - TabBarH - SafeAreaBottom) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.delegate && [self.dataSource respondsToSelector:@selector(BaseTableView:numberOfRowsInSection:)]) {
        return [self.delegate BaseTableView:tableView numberOfRowsInSection:section];
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(BaseTablenumberOfSectionsInTableView:)]) {
        return [self.delegate BaseTablenumberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(BaseTableView:heightForRowAtIndexPath:)]) {
        return [self.dataSource BaseTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(BaseTableView:heightForHeaderInSection:)]) {
        return [self.dataSource BaseTableView:tableView heightForHeaderInSection:section];
    }
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(BaseTableView:cellForRowAtIndexPath:)]) {
        return [self.dataSource BaseTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
