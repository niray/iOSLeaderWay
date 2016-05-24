//
// Created by Huway Mac on 16/5/23.
// Copyright (c) 2016 Android Develope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BNRLine;

@interface BNRDrawView : UIView
@property(nonatomic, strong) BNRLine *currentLine;
@property(nonatomic, strong) NSMutableDictionary *linesInProgress;
@property(nonatomic, strong) NSMutableArray *finishedLines;
@property(nonatomic, weak) BNRLine *selectLine;
@property(nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property(nonatomic) BOOL *isMoving;
@end