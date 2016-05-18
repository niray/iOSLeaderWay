//
//  AppDelegate.m
//  LeaningWay
//
//  Created by Huway Mac on 16/4/6.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "AppDelegate.h"
#import "HypnosisView.h"
#import "BNRHypnosisViewController.h"
#import "BHRReminderVIewController.h"
#import "BNRItemsViewController.h"

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
    [self setTableView];
    //self.window.rootViewController = vc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
//Q:1.UITabBarC 不显示名字和图片
//  2.不显示Notify

//4.
-(void)setTableView{
    BNRItemsViewController *itemVC = [[BNRItemsViewController alloc] init];
    self.window.rootViewController = itemVC;
}
//3. UITabBarUiView
- (void)setUIBarView {
    BNRHypnosisViewController *hvc = [[BNRHypnosisViewController alloc] init];
    hvc.title = @"试一2下";

    NSBundle *appBundle = [NSBundle mainBundle];

//    BHRReminderVIewController *rvc = [[BHRReminderVIewController alloc]
//                                      initWithNibName:@"BNRReminderViewController" bundle:appBundle];

    BHRReminderVIewController *rvc = [[BHRReminderVIewController alloc] init];
    rvc.title = @"试一下";
    UITabBarController *tabBarController = [[UITabBarController alloc] init];

    tabBarController.viewControllers = @[rvc, hvc];
    self.window.rootViewController = tabBarController;


    NSArray *items = tabBarController.tabBar.items;
    UITabBarItem *item0= items[0];
    UITabBarItem *item1 = items[1];
    
    
    UIImage *i = [UIImage imageNamed:@"1_normal"];
    [item0 setImage:i];
    
    UIImage *i1 = [UIImage imageNamed:@"1_selected"];
    [item1 setImage:i1];
}

//2.ScrollView 例子
- (void)setScrollView:(UIViewController *)vc {

    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    // bigRect.size.height *=2.0;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    //[self.window addSubview:scrollView];
    [scrollView setPagingEnabled:YES];
    [vc.view addSubview:scrollView];

    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:screenRect];
    //[self.window addSubview:hypnosisView];
    [scrollView addSubview:hypnosisView];

    screenRect.origin.x += screenRect.size.width;

    HypnosisView *anotherView = [[HypnosisView alloc] initWithFrame:screenRect];

    [scrollView addSubview:anotherView];

    scrollView.contentSize = bigRect.size;

}

//1.自定义View 例子
- (void)setRectView:(UIViewController *)vc :(CGRect)bounds {
    CGRect firstFrame = CGRectMake(0, 0, 110, 150);
    CGRect secondFrame = CGRectMake(250, 150, 100, 150);

    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:bounds];
    hypnosisView.backgroundColor = [UIColor brownColor];
    hypnosisView.frame = firstFrame;

    HypnosisView *hypnosisView2 = [[HypnosisView alloc] initWithFrame:CGRectZero];
    hypnosisView2.backgroundColor = [UIColor purpleColor];
    hypnosisView2.frame = secondFrame;

    [vc.view addSubview:hypnosisView];
    [vc.view addSubview:hypnosisView2];
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
