//
//  BJTabBarViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/12.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJTabBarViewController.h"
#import "BaseHeader.h"

@interface BJTabBarViewController ()

@property (nonatomic, strong) BJFunctionOneViewController *funcOne;
@property (nonatomic, strong) BJFuncTionTwoViewController *funcTwo;
@property (nonatomic, strong) BJFunctionThreeViewController *funcThree;
@property (nonatomic, strong) BJFunctionFourViewController *funcFour;

@end

#define KITEMONENAME @"功能一"
#define KITEMTWONAME @"功能二"
#define KITEMTHREENAME @"功能三"
#define KITEMFOURNAME @"功能四"

@implementation BJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _funcOne = [[BJFunctionOneViewController alloc] init];
    BJBaseNaviController *naviOne = [[BJBaseNaviController alloc] initWithRootViewController:_funcOne];
    naviOne.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMONENAME image:[UIImage imageNamed:@"首页"] selectedImage:[UIImage imageNamed:@"首页selected"]];
    
    _funcTwo = [[BJFuncTionTwoViewController alloc] init];
    BJBaseNaviController *naviTwo = [[BJBaseNaviController alloc] initWithRootViewController:_funcTwo];
    naviTwo.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMTWONAME image:[UIImage imageNamed:@"更多功能"] selectedImage:[UIImage imageNamed:@"更多功能selected"]];
    
    _funcThree = [[BJFunctionThreeViewController alloc] init];
    BJBaseNaviController *naviThree = [[BJBaseNaviController alloc] initWithRootViewController:_funcThree];
    naviThree.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMTHREENAME image:[UIImage imageNamed:@"功能开关"] selectedImage:[UIImage imageNamed:@"功能开关selected"]];
    
    _funcFour = [[BJFunctionFourViewController alloc] init];
    BJBaseNaviController *naviFour = [[BJBaseNaviController alloc] initWithRootViewController:_funcFour];
    naviFour.tabBarItem = [[UITabBarItem alloc] initWithTitle:KITEMFOURNAME image:[UIImage imageNamed:@"我的"] selectedImage:[UIImage imageNamed:@"我的selected"]];
    
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
