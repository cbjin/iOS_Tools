//
//  BJHomeSearchViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/12/26.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJHomeSearchViewController.h"
#import "BaseHeader.h"

@interface BJHomeSearchViewController ()<UISearchBarDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation BJHomeSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // white.png图片自己下载个纯白色的色块，或者自己ps做一个
    [navigationBar setBackgroundImage:[UIImage new]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavi];
    // Do any additional setup after loading the view.
}

- (void)setUpNavi {
    
    UIView *viewNaviHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KScreenW * 0.95, 34)];
    self.navigationItem.titleView = viewNaviHeader;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewNaviHeader.frame), CGRectGetHeight(viewNaviHeader.frame))];
    _searchBar.placeholder = @"请输入关键字儿";
    _searchBar.delegate = self;
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.showsCancelButton = YES;
    [_searchBar becomeFirstResponder];
    for (id cencelButton in [_searchBar.subviews[0] subviews])
    {
        if([cencelButton isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cencelButton;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
        }
        if ([cencelButton isKindOfClass:[UITextField class]]) {
            UITextField *searchTF = cencelButton;
            searchTF.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.5];
//            [searchTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            [searchTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];

        }
    }
    [viewNaviHeader addSubview:_searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self resignSearchBar];
    [self back];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self resignSearchBar];
}

- (void)resignSearchBar {
    [_searchBar resignFirstResponder];
    
}

- (void)back {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
