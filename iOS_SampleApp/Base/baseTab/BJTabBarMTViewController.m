//
//  BJTabBarMTViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2019/1/3.
//  Copyright © 2019年 蔡佰津. All rights reserved.
//

#import "BJTabBarMTViewController.h"
#import "BaseHeader.h"

@interface BJTabBarMTViewController ()

@property (nonatomic, strong) BJHomeMTViewController *funcOne;
@property (nonatomic, strong) BJDiscoverMTViewController *funcTwo;
@property (nonatomic, strong) BJOrderMTViewController *funcThree;
@property (nonatomic, strong) BJMyMTViewController *funcFour;

@end

#define KITEMONENAME @"首页"
#define KITEMTWONAME @"发现"
#define KITEMTHREENAME @"订单"
#define KITEMFOURNAME @"我的"

@implementation BJTabBarMTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _funcOne = [[BJHomeMTViewController alloc] init];
    BJBaseNaviController *naviOne = [[BJBaseNaviController alloc] initWithRootViewController:_funcOne];
    naviOne.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMONENAME image:[[UIImage imageNamed:@"首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"首页selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    _funcTwo = [[BJDiscoverMTViewController alloc] init];
    BJBaseNaviController *naviTwo = [[BJBaseNaviController alloc] initWithRootViewController:_funcTwo];
    naviTwo.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMTWONAME image:[[UIImage imageNamed:@"更多功能"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"更多功能selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    _funcThree = [[BJOrderMTViewController alloc] init];
    BJBaseNaviController *naviThree = [[BJBaseNaviController alloc] initWithRootViewController:_funcThree];
    naviThree.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMTHREENAME image:[[UIImage imageNamed:@"功能开关"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"功能开关selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    _funcFour = [[BJMyMTViewController alloc] init];
    BJBaseNaviController *naviFour = [[BJBaseNaviController alloc] initWithRootViewController:_funcFour];
    naviFour.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMFOURNAME image:[[UIImage imageNamed:@"我的"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.selectedIndex = 0;
    self.viewControllers = @[naviOne, naviTwo, naviThree, naviFour];
    
    // Do any additional setup after loading the view.
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
