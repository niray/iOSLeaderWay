//
// Created by Huway Mac on 16/5/25.
// Copyright (c) 2016 Android Develope. All rights reserved.
//

#import "MenuListVC.h"
#import "BNRItemsViewController.h"
#import "HypnosisView.h"
#import "BNRHypnosisViewController.h"
#import "BHRReminderVIewController.h"
#import "BNRDrawVC.h"
#import "AppDelegate.h"

@implementation MenuListVC


- (void)viewDidLoad {
    [super viewDidLoad];


    self.menuDir = @[@"1.自定义View  ",
            @"2.ScrollView  ",
            @"3.UITabBarUiView ",
            @"4.UITableView 例子",
            @"5.UIDrawView "];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

}

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];

    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Menu";
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuDir.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id vc;
    switch (indexPath.row) {
        case 0 :
            [self setRectView];
            break;
        case 1 :
            [self setScrollView];
            break;
        case 2 :
            [self setUIBarView];
            break;
        case 3 ://4.TableView
            vc = [[BNRItemsViewController alloc] init];
            break;
        case 4 :
            //6.DrawView
            vc = [[BNRDrawVC alloc] init];
            break;
        default:
            break;
    }

    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"cell"];
    cell.textLabel.text = self.menuDir[indexPath.row];
    return cell;
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
    [self.navigationController pushViewController:tabBarController animated:YES];

    NSArray *items = tabBarController.tabBar.items;
    UITabBarItem *item0 = items[0];
    UITabBarItem *item1 = items[1];


    UIImage *i = [UIImage imageNamed:@"1_normal"];
    [item0 setImage:i];

    UIImage *i1 = [UIImage imageNamed:@"1_selected"];
    [item1 setImage:i1];
}

//2.ScrollView 例子
- (void)setScrollView {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    CGRect screenRect = appDelegate.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    // bigRect.size.height *=2.0;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    //[self.window addSubview:scrollView];
    [scrollView setPagingEnabled:YES];
    [self.navigationController.view addSubview:scrollView];

    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:screenRect];
    //[self.window addSubview:hypnosisView];
    [scrollView addSubview:hypnosisView];

    screenRect.origin.x += screenRect.size.width;

    HypnosisView *anotherView = [[HypnosisView alloc] initWithFrame:screenRect];

    [scrollView addSubview:anotherView];

    scrollView.contentSize = bigRect.size;

}

//1.自定义View 例子
- (void)setRectView {
    CGRect firstFrame = CGRectMake(0, 0, 110, 150);
    CGRect secondFrame = CGRectMake(250, 150, 100, 150);

    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    CGRect screenRect = appDelegate.window.bounds;
    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:screenRect];
    hypnosisView.backgroundColor = [UIColor brownColor];
    hypnosisView.frame = firstFrame;

    HypnosisView *hypnosisView2 = [[HypnosisView alloc] initWithFrame:CGRectZero];
    hypnosisView2.backgroundColor = [UIColor purpleColor];
    hypnosisView2.frame = secondFrame;

    [self.navigationController.view addSubview:hypnosisView];
    [self.navigationController.view addSubview:hypnosisView2];
}


@end