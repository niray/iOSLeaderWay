//
//  BHRReminderVIewController.m
//  LeaningWay
//
//  Created by Huway Mac on 16/4/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "BHRReminderVIewController.h"
#import "BNRItemStore.h"

@interface BHRReminderVIewController ()

@property(nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BHRReminderVIewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarController.title = @"知足";
        //        self.tabBarItem.image=i;
    }
    return self;
}

- (IBAction)addReminder:(id)sender {
    NSDate *date = self.datePicker.date;

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
   
    NSString *formartDate = [df stringFromDate:date];

    NSLog(@"Setting a reminder for %@", formartDate);
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me !";
    note.fireDate = [date dateByAddingTimeInterval:5];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"BNRReminderVC loaded its View");
}

@end