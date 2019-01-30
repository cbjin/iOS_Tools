//
//  AppDelegate.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/9/12.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJAppDelegate.h"
#import "BaseHeader.h"
#import <objc/runtime.h>
@interface BJAppDelegate ()



@end

#define NotificationLogin @"loginForNoti"

@implementation BJAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[JPFPSStatus sharedInstance] open];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rootStateChange:) name:NotificationLogin object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLogin object:@NO];
    
    return YES;
}

- (void)rootStateChange:(NSNotification *)noti {
    [_window makeKeyAndVisible];
    BJTabBarMTViewController *tb = [[BJTabBarMTViewController alloc] init];
    _window.rootViewController = tb;
    [UITabBar appearance].translucent = NO;
    NSLog(@"jjjjjjjjjjjjjjjjjjjjjj");
    
}


- (void)test {
    NSString *str = @"https://221.212.213.112:8000/api/naturePersonCenter/faceRecognition/faceCompare/v1";
    UIImage *imgBASEIMG = [UIImage imageNamed:@"123"];
    UIImage *imgFACEIMG = [UIImage imageNamed:@"456"];
    NSString *BASEIMG = [UIImageJPEGRepresentation(imgBASEIMG, 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *FACEIMG = [UIImageJPEGRepresentation(imgFACEIMG, 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *data = @{
                           @"UNI_BSS_HEAD": @{
                                   @"APP_ID": @"wNAiGwxPTr",
                                   @"TIMESTAMP": @"2018-01-19 21:44:24 207",
                                   @"TRANS_ID": @"20170809162657538349056",
                                   @"TOKEN": @"3fa5af8cdc83b0ab8051d36b6c312a95"
                                   },
                           @"UNI_BSS_BODY": @{
                                   @"FACE_COMPARE_REQ": @{
                                           @"COMPARE_TRANS_ID": @"NP20180411102316739274",
                                           @"SYS_CODE": @"3102",
                                           @"SYSTEM": @"02",
                                           @"PROVINCE_CODE": @"51",
                                           @"EPARCHY_CODE": @"510",
                                           @"CERT_NUM": @"232324198504220022",
                                           @"SCENE": @"02",
                                           @"CERT_NAME": @"付欣昕",
                                           @"BASEIMG": BASEIMG,
                                           @"FACEIMG": FACEIMG
                                           }
                                   },
                           @"UNI_BSS_ATTACHED": @{
                                   @"MEDIA_INFO": @""
                                   }
                           };
    NSDictionary *dic = @{
                          @"Content-Type": @"application/json; charset=UTF-8",
                          @"Accept": @"application/json",
                          @"Accept-Encoding": @""
                          };
    [BJAFNetworkTool postUrlString:str body:data response:BJJSON bodyStyle:BJRequestJSON requestHeadFile:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"iOS_SampleApp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
