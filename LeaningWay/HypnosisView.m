//
//  HypnosisView.m
//  LeaningWay
//
//  Created by Huway Mac on 16/4/8.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "HypnosisView.h"

@interface HypnosisView()
@property (strong,nonatomic) UIColor *circleColor;
@end

@implementation HypnosisView


- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return  self;
}

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    UIBezierPath *path   =  [[UIBezierPath alloc]init];
    
    float maxRadius = (hypot(bounds.size.width, bounds.size.height)/2.0);
    
    for(float currentRadius = maxRadius;currentRadius > 0; currentRadius -=20){
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    
    path.lineWidth  = 10;
    
    [self.circleColor setStroke];
       
    [path stroke];//绘制路径
    
    UIImage *logoImage = [UIImage imageNamed:@"hs.jpg"];
    
 //   [logoImage drawInRect:rect];
    
    CGFloat locations [2] = {0.0 , 1.0};
    CGFloat components[8] = {1.0,0.0,0.0,1.0,1.0,1.0,0.0,1.0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,components,locations,2);
    
    CGPoint endPoint ;
    endPoint.x=bounds.size.width;
    endPoint.y = bounds.size.height;
    CGContextDrawLinearGradient(UIGraphicsGetCurrentContext() , gradient, center, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@ was touched",self);
    //获取三个0到1之间的数字
    float red = (arc4random()%100)/100.0;
    float green = (arc4random()%100)/100.0;
    float blue  = (arc4random()%100) /100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
    
}

-(void) setCircleColor:(UIColor *)circleColor{
    NSLog(@"%@ setNeedsDisplay ",self);
    _circleColor = circleColor;
    [self setNeedsDisplay];
}


@end
