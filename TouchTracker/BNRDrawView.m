//
// Created by Huway Mac on 16/5/23.
// Copyright (c) 2016 Android Develope. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

@end

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

        UILongPressGestureRecognizer *longGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longGR];


        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];

    }
    return self;
}

- (void)moveLine:(UIPanGestureRecognizer *)gr {
    if (!self.selectLine) return;

    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gr translationInView:self];
        CGPoint begin = self.selectLine.begin;
        CGPoint end = self.selectLine.end;

        begin.x += translation.x;
        begin.y += translation.y;

        end.x += translation.x;
        end.y += translation.y;

        self.selectLine.begin = begin;
        self.selectLine.end = end;

        [self setNeedsDisplay];
        [gr setTranslation:CGPointZero inView:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer :(UIGestureRecognizer *)otherGestureRecognizer {
    self.isMoving = (self.moveRecognizer == gestureRecognizer);
    return self.isMoving;
}

- (void)longPress:(UIGestureRecognizer *)gr {
    NSLog(@"%@", NSStringFromSelector(_cmd));

    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectLine = [self lineAtPoint:point];
        if (self.selectLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectLine = nil;
    }
    [self setNeedsDisplay];
}

- (void)tapRecognizer:(UIGestureRecognizer *)gr {
    CGPoint point = [gr locationInView:self];
    self.selectLine = [self lineAtPoint:point];
    NSLog(@"One Tap , %@", self.selectLine);


    if (self.selectLine) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteMenu = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteMenu, deleteMenu];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)deleteLine:(id)sender {
    [self.finishedLines removeObject:self.selectLine];
    [self setNeedsDisplay];
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

- (BNRLine *)lineAtPoint:(CGPoint)p {
    for (BNRLine *line in self.finishedLines) {
        CGPoint start = line.begin;
        CGPoint end = line.end;
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return line;
            }
        }
    }
    return nil;
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
    if (self.isMoving)return;
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
