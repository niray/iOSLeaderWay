//
// Created by Huway Mac on 16/5/23.
// Copyright (c) 2016 Android Develope. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"


@implementation BNRDrawView


- (instancetype)initWithFrame:(CGRect)r {
    self = [super initWithFrame:r];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.multipleTouchEnabled = YES;
        self.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];


        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(tapRecognizer:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:tapRecognizer];


        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    }
    return self;
}


- (void)tapRecognizer:(UIGestureRecognizer *)gr {
    NSLog(@"One Tap");
}

- (void)doubleTap:(UIGestureRecognizer *)gr {
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }

    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }

    if (self.selectLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectLine];
    }

//    [[UIColor blackColor] set];
//    for (BNRLine *line in _finishedLines) {
//        [self strokeLine:line];
//    }
//    if (self.currentLine) {
//        [[UIColor redColor] set];
//        [self strokeLine:_currentLine];
//    }
}


- (void)strokeLine:(BNRLine *)line {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    [path moveToPoint:line.begin];
    [path addLineToPoint:line.end];
    [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;

        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }

//   UITouch *t                          = [touches anyObject];
//   CGPoint location                    = [t locationInView:self];
//   self.currentLine                    = [[BNRLine alloc] init];
//   self.currentLine.begin              = location;
//   self.currentLine.end                = location;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }

//   UITouch *t                      = [touches anyObject];
//   CGPoint location                = [t locationInView:self];
//   self.currentLine.end            = location;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];

        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }

//    if (self.currentLine) {
//        [self.finishedLines addObject:self.currentLine];
//        self.currentLine                  = nil;
//        [self setNeedsDisplay];
//    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

@end
