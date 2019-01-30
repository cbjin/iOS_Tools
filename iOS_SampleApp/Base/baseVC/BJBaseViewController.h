//
//  ViewController.h
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/12.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BJBaseViewTableDelegate <NSObject>


- (NSInteger)BaseTablenumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)BaseTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


@end

@protocol BJBaseViewTableDataSource <NSObject>

- (CGFloat)BaseTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)BaseTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)BaseTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface BJBaseViewController : UIViewController

@property (nonatomic, assign) id<BJBaseViewTableDelegate> delegate;
@property (nonatomic, assign) id<BJBaseViewTableDataSource> dataSource;
@property (nonatomic, strong) UITableView *tableView;


@end

