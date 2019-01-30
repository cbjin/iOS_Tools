//
//  BaseHeader.h
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/12.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#ifndef BaseHeader_h
#define BaseHeader_h

#import "BJAppDelegate.h"
#import "BJBaseViewController.h"
#import "BJBaseNaviController.h"
#import "BJTabBarViewController.h"
#import "BJFunctionOneViewController.h"
#import "BJFuncTionTwoViewController.h"
#import "BJFunctionThreeViewController.h"
#import "BJFunctionFourViewController.h"
#import "BJHomeViewController.h"
#import "BJHomeTableViewHeaderView.h"
#import "UIButton+ImageAndTitle.h"
#import "BJHomeTableViewHeaderView.h"
#import "BJOneCollectionViewCell.h"
#import "BJBtnCollectionViewCell.h"

#import <HexColor.h>
#import <AFNetworking.h>
#import <JPFPSStatus/JPFPSStatus.h>
#import <DACircularProgressView.h>
#import <FMDB.h>
#import <iCarousel.h>
#import <IQKeyboardManager.h>
#import <JSONModel.h>
#import <Masonry.h>
#import <MBProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <NinaPagerView.h>
#import <PNChart.h>
#import <Reachability.h>
#import <Realm.h>
#import <RKNotificationHub.h>
#import <SAMKeychain.h>
#import <SDCycleScrollView.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Toast.h>
#import <TSMessage.h>
#import <UICountingLabel.h>
#import <WebViewJavascriptBridge.h>
#import <YYCache.h>
#import <YYCategories.h>
#import <YYDispatchQueuePool.h>
#import <YYImage.h>
#import <YYKeyboardManager.h>
#import <YYModel.h>
#import <YYText.h>
#import <YYWebImage.h>
#import <YTKNetwork.h>

#import <LBXScan/LBXScanView.h>
#import <LBXScan/LBXScanTypes.h>
#import <LBXScan/LBXScanNative.h>
#import <LBXScan/LBXZXCapture.h>
#import <LBXScan/LBXZBarWrapper.h>
#import "BJScanViewController.h"
#import "BJHomeMTHeaderView.h"
#import "BJTabBarMTViewController.h"

#import "CityListViewController.h"
#import "BJDiscoverMTViewController.h"
#import "BJOrderMTViewController.h"
#import "BJMyMTViewController.h"

#define LBXScan_Define_Native  //下载了native模块
#define LBXScan_Define_ZXing   //下载了ZXing模块
#define LBXScan_Define_ZBar   //下载了ZBar模块
#define LBXScan_Define_UI     //下载了界面模块

#import "BJAFNetworkTool.h"
#import "BJHomeHeaderView.h"
#import "BJHomeTypeOneTableViewCell.h"
#import "BJHomeTypeTwoTableViewCell.h"
#import "BJHomeTypeTwoCollectionViewCell.h"
#import "BJHomeTypeThreeTableViewCell.h"
#import "BJHomeTypeThreeCollectionViewCell.h"
#import "BJHomeTypeFourTableViewCell.h"
#import "BJTestViewController.h"
#import "BJTestWebViewController.h"
#import "BJJSWKTools.h"
#import <WebKit/WebKit.h>
#import "ScanningViewController.h"
#import "BJFuncOneDetailViewController.h"
#import "UINavigationBar+BJDynamicBar.h"


#import "BJHomeTableHeaderView.h"
#import "BJHomeSearchViewController.h"
#import "JHCustomMenu.h"
#import <TOCropViewController/TOCropViewController.h>

// MT
#import "BJHomeMTViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 获取屏幕宽度与高度

#define iOS11 @available(iOS 11.0, *)

#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height
#define NaviH (KScreenH == 812.0 ? 88 : 64)
#define HomeFont (KScreenW > 320 ? 15 : 12)
#define TabBarH 49
#define SafeAreaBottom (KScreenH == 812.0 ? 34 : 0)
#define BaseUrl @""
//
//#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
//#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

// 获取通知中心
#define BJNotificationCenter [NSNotificationCenter defaultCenter]

// 设置RGB/RGBA颜色
#define BJRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BJRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// clear背景颜色
#define BJClearColor [UIColor clearColor]
// 随机色
#define BJRandomColor BJRGBAColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 自定义log release自动关闭
#ifdef DEBUG
#define BJLog(fmt, ...) NSLog((@"\r\n=====================分割线=======================\n%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define BJLog(...)
#endif

#define KCollectionHeader UICollectionElementKindSectionHeader
#define KCollectionFooter UICollectionElementKindSectionFooter
#define UserDefaults [NSUserDefaults standardUserDefaults]


#endif /* BaseHeader_h */
