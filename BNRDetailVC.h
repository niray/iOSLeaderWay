//
//  BNRDetailVC.h
//  LeaningWay
//
//  Created by Huway Mac on 16/5/20.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface BNRDetailVC : UIViewController

- (IBAction)backgroundTapped:(id)sender;

- (instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic,strong) BNRItem *item;

@end
