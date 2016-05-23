//
// Created by Huway Mac on 16/5/23.
// Copyright (c) 2016 Android Develope. All rights reserved.
//

#import "BNRDrawVC.h"
#import "BNRDrawView.h"

@implementation BNRDrawVC

- (void)loadView {
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end