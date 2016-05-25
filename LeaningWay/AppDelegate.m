//
//  AppDelegate.m
//  LeaningWay
//
//  Created by Huway Mac on 16/4/6.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuListVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
//    // Required
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:<#(nonnull UIUserNotificationSettings *)#>]
//        
//        //可以添加自定义categories
//        [[UIApplication sharedApplication]  registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                       UIUserNotificationTypeSound |
//                                                       UIUserNotificationTypeAlert)
//                                           categories:nil];
//    } else {
//        //categories 必须为nil
//        [[UIApplication sharedApplication]  registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                           categories:nil];
//    }
//     



    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:bounds];

    //  UIViewController *vc = [[UIViewController alloc] init];

    //1.自定义View 例子
    //[self setRectView :vc :bounds];

    //2.ScrollView 例子
    //[self setScrollView:vc];

    //3.UITabBarUiView
//    [self setUIBarView];
    //4.UITableView
   // self.window.rootViewController =   [self setTableView];
//5.UINavigationController
    //   [self setUINavagationControll];
    //[self setDrawView];
    //self.window.rootViewController = vc;

    MenuListVC *menuVC = [[MenuListVC alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:menuVC];


    self.window.rootViewController = nc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
